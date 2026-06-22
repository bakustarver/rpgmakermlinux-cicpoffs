#!/usr/bin/env bash
set -euo pipefail
# ANSI colors for highlighting (kept for non-awk use)
CLR_BOLD="\033[1m"
CLR_RESET="\033[0m"

# ---------------------------------------------------------------------------
check_deps() {
  missing=()

  # required commands used by the script
  required=(cp mv mkdir date find awk sed tr sort mktemp wc cat awk grep)

  # ensure core utilities are present
  for cmd in "${required[@]}"; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
      missing+=("$cmd")
    fi
  done

  # md5: prefer md5sum, fallback to md5 (macOS)
  if command -v md5sum >/dev/null 2>&1; then
    MD5CMD="md5sum --binary --"
  elif command -v md5 >/dev/null 2>&1; then
    # md5 -r prints "hash filename" which is compatible with awk '{print $1}'
    MD5CMD="md5 -r"
  else
    missing+=("md5sum or md5")
  fi

  # stat: prefer GNU stat -c, then BSD stat -f, otherwise use wc -c fallback
  if command -v stat >/dev/null 2>&1; then
    if stat -c%s /dev/null >/dev/null 2>&1; then
      STAT_CMD="stat -c%s --"
    elif stat -f%z /dev/null >/dev/null 2>&1; then
      STAT_CMD="stat -f%z --"
    else
      STAT_CMD=""   # use wc -c fallback
    fi
  else
    STAT_CMD=""
  fi


  # Report missing required commands and exit if any
  if [ "${#missing[@]}" -ne 0 ]; then
    echo "Missing required dependencies:" >&2
    for m in "${missing[@]}"; do
      echo "  - $m" >&2
    done
    echo "Please install the missing packages and re-run the script." >&2
    exit 2
  fi


  # Export chosen commands for later use
  export MD5CMD STAT_CMD
}

# call dependency check early
check_deps
usage() {
  cat <<EOF
Usage: $0 /path/to/src /path/to/dest
Produces tocopy.txt (SIZE DIFF + MISSING) and shows an rsync dry run.
EOF
  exit 2
}

if [ "${#}" -lt 2 ]; then
  usage
fi

src="$1"
dest="$2"
shift 2

apply=false

# Normalize (remove trailing slash) and require directories
src="${src%/}"
dest="${dest%/}"

if [ ! -d "$src" ]; then
  echo "Source not a directory: $src" >&2
  exit 1
fi
if [ ! -d "$dest" ]; then
  echo "Dest not a directory: $dest" >&2
  exit 1
fi

# Temporary files for grouping results (null-delimited)
tmp_exists=$(mktemp)
tmp_newer=$(mktemp)
tmp_size=$(mktemp)
tmp_md5=$(mktemp)
tmp_missing=$(mktemp)
tmp_missing_dirs=$(mktemp)

cleanup() {
  rm -f "$tmp_exists" "$tmp_newer" "$tmp_size" "$tmp_md5" "$tmp_missing" "$tmp_missing_dirs"
}
trap cleanup EXIT

# Helper: process a found destination file (destf) for a given relative path
process_found() {
  rel="$1"
  destf="$2"
  srcf="$src/$rel"

  printf '%s\0' "$rel" >>"$tmp_exists"

  # NEWER: src file is newer than dest file
  if [ "$srcf" -nt "$destf" ]; then
    printf '%s\0' "$rel" >>"$tmp_newer"
  fi

  # SIZE DIFF
  ssize=$(stat -c%s -- "$srcf")
  dsize=$(stat -c%s -- "$destf")
  if [ "$ssize" -ne "$dsize" ]; then
    printf '%s\0' "$rel" >>"$tmp_size"
  else
    # Only compute MD5 if sizes are equal (saves time)
    srcmd5=$(md5sum --binary -- "$srcf" | awk '{print $1}')
    destmd5=$(md5sum --binary -- "$destf" | awk '{print $1}')
    if [ "$srcmd5" != "$destmd5" ]; then
      printf '%s\0' "$rel" >>"$tmp_md5"
    fi
  fi
}

# Iterate files in src, using find to print relative paths safely
export src dest
find "$src" -type f -printf '%P\0' |
while IFS= read -r -d '' rel; do
  srcf="$src/$rel"
  destf="$dest/$rel"
  alt_destf="$dest/$(basename "$src")/$rel"

  if [ -e "$destf" ]; then
    process_found "$rel" "$destf"
  elif [ -e "$alt_destf" ]; then
    # common case: whole src directory was copied under dest
    process_found "$rel" "$alt_destf"
  else
    printf '%s\0' "$rel" >>"$tmp_missing"
  fi
done

# ---------------------------------------------------------------------------
# Compute missing directories in src that are not present in dest
# (records relative paths, NUL-delimited; root is recorded as ".")
find "$src" -type d -printf '%P\0' |
while IFS= read -r -d '' rel; do
  # normalize root
  if [ -z "$rel" ]; then
    rel="."
  fi
  destdir="$dest/$rel"
  alt_destdir="$dest/$(basename "$src")/$rel"
  if [ ! -d "$destdir" ] && [ ! -d "$alt_destdir" ]; then
    printf '%s\0' "$rel" >>"$tmp_missing_dirs"
  fi
done

# Produce tocopy.txt combining SIZE DIFF and MISSING (one per line)
tocopy="/tmp/tocopy.txt"
{
  if [ -s "$tmp_size" ]; then
    tr '\0' '\n' <"$tmp_size"
  fi
  if [ -s "$tmp_missing" ]; then
    tr '\0' '\n' <"$tmp_missing"
  fi
} | awk '!seen[$0]++' > "$tocopy"


if [ ! -s "$tocopy" ]; then
  echo "No files to copy."
  exit 0
fi
# Generic printer: prints a hierarchical tree for a NUL-delimited or newline-delimited file.
# Arguments:
#   $1 = title
#   $2 = path to file
#   $3 = "nul" if file is NUL-delimited, otherwise "nl"
print_tree() {
  title="$1"
  file="$2"
  mode="$3"   # "nul" or "nl"

  echo "**$title**"
  if [ ! -s "$file" ]; then
    echo "  (none)"
    echo
    return
  fi

  # Build input stream (newline-delimited)
  if [ "$mode" = "nul" ]; then
    input_cmd="tr '\0' '\n' <\"$file\""
  else
    input_cmd="cat \"$file\""
  fi

  # Print tree: deduplicate nodes so each directory/file printed once
  eval "$input_cmd" \
    | awk -F'/' '
{
  if ($0 == "") next
  path = ""
  for (i = 1; i <= NF; ++i) {
    path = (i == 1) ? $i : path "/" $i
    if (!seen[path]++) {
      printf("  %*s%s\n", (i-1)*2, "", $i)
    }
  }
}
'
  echo
}

# Combined tree: summarized output for SIZE DIFF + MISSING + MISSING DIRS
print_combined_tree() {
  echo "Files and directories that will be added or overwritten:"

  SAMPLE_PER_DIR=3   # show up to this many files per directory
  MAX_DEPTH=3        # expand directories up to this depth

  combined_tmp=$(mktemp)

  {
    [ -s "$tmp_size" ] && tr '\0' '\n' <"$tmp_size"
    [ -s "$tmp_missing" ] && tr '\0' '\n' <"$tmp_missing"
    # include missing directories with trailing slash to indicate directories
    if [ -s "$tmp_missing_dirs" ]; then
      tr '\0' '\n' <"$tmp_missing_dirs" | sed 's%$%/%'
    fi
  } | sort -u | grep -v '^/$' > "$combined_tmp"   # filter out lone "/" entries

  # If nothing to copy, report and return
  if [ ! -s "$combined_tmp" ]; then
    echo "  (none) — no files to add or overwrite."
    echo
    rm -f "$combined_tmp"
    return
  fi

  # Summarize and colorize with random colors per directory/file
  awk -v sample="$SAMPLE_PER_DIR" -v maxdepth="$MAX_DEPTH" -F'/' '
BEGIN {
  srand()
  # color palette (foreground)
  colors[1]  = "\033[32m"  # green
  colors[2] = "\033[38;5;202m"  # orange-red
  colors[3] = "\033[38;5;208m"  # orange
  colors[4]  = "\033[34m"  # blue
  colors[5] = "\033[38;5;214m"  # gold
  colors[6] = "\033[38;5;82m"   # spring green
  colors[7] = "\033[38;5;48m"   # green-cyan
  colors[8] = "\033[38;5;51m"   # turquoise
  colors[9]  = "\033[33m"  # yellow
  colors[10]  = "\033[31m"  # red
  colors[11]  = "\033[35m"  # magenta
  colors[12]  = "\033[36m"  # cyan
  colors[13]  = "\033[91m"  # bright red
  colors[14]  = "\033[92m"  # bright green
  colors[15]  = "\033[94m"  # bright blue
  colors[16] = "\033[95m"  # bright magenta
  ncolors = 10
  reset = "\033[0m"
}
# simple stable hash: sum of bytes mod ncolors, ensures same dir gets same color within run
function color_for(name,   i, s, c) {
  s = 0
  for (i = 1; i <= length(name); ++i) s += ord(substr(name, i, 1))
  c = (s % ncolors) + 1
  return colors[c]
}
# ord() for gawk compatibility
function ord(str,   r, i, v) {
  r = 0
  for (i = 1; i <= length(str); ++i) {
    v = and(255, sprintf("%d", substr(str, i, 1)))
    r += v
  }
  return r
}
{
  if ($0 == "") next
  # treat trailing slash as directory marker; remove it for processing
  line = $0
  if (substr(line, length(line), 1) == "/") {
    line = substr(line, 1, length(line)-1)
    isdir = 1
  } else {
    isdir = 0
  }
  if (line == "") next
  if (NF == 1) {
    add_dir(".")
    leafdir = "."
    leaf_name = line
  } else {
    path = $1
    add_dir(path)
    for (i = 2; i < NF; ++i) {
      path = path "/" $i
      add_dir(path)
    }
    leafdir = $1
    for (i = 2; i < NF; ++i) leafdir = leafdir "/" $i
    leaf_name = $NF
  }
  leaf_count[leafdir]++
  if (leaf_sample_count[leafdir] < sample) {
    leaf_sample_count[leafdir]++
    suffix = isdir ? "/" : ""
    leaf_samples[leafdir, leaf_sample_count[leafdir]] = leaf_name suffix
  }
}
function add_dir(d) {
  if (!(d in dir_seen)) {
    dir_seen[d] = 1
    dir_list[++dir_count] = d
  }
}
END {
  if (!(". " in dir_seen) && !("." in dir_seen)) {
    add_dir(".")
  }
  # sort dir_list lexicographically so parents and children are contiguous
  for (i = 1; i <= dir_count; ++i) {
    for (j = i+1; j <= dir_count; ++j) {
      if (dir_list[i] > dir_list[j]) {
        tmp = dir_list[i]; dir_list[i] = dir_list[j]; dir_list[j] = tmp
      }
    }
  }


  for (i = 1; i <= dir_count; ++i) {
    d = dir_list[i]
    if (d == ".") {
      depth = 0
      name = "."
    } else {
      ncomp = split(d, comps, "/")
      depth = ncomp
      name = comps[ncomp]
    }
    indent = (depth == 0) ? 0 : (depth-1)*2

    # Print directory header (colored)
    if (d != ".") {
      col = color_for(d)
      printf("  %*s%s%s/%s\n", indent, "", col, name, reset)
    }

    # only expand directories up to maxdepth
    if (depth <= maxdepth) {
      if (leaf_sample_count[d] > 0) {
        for (k = 1; k <= leaf_sample_count[d]; ++k) {
          fname = leaf_samples[d, k]
          if (d == ".") {
            col = color_for(fname)
            printf("  %s%s%s%s\n", col, fname, reset, "")
          } else {
            col = color_for(d "/" fname)
            printf("  %*s%s%s%s%s\n", indent+2, "", col, fname, reset, "")
          }
        }
        rem = leaf_count[d] - leaf_sample_count[d]
        if (rem > 0) {
          if (d == ".") {
            col = color_for(".")
            printf("  %s... (%d more files)%s\n", col, rem, reset)
          } else {
            col = color_for(d)
            printf("  %*s%s... (%d more files)%s\n", indent+2, "", col, rem, reset)
          }
        }
      }
    }
  }
}
' "$combined_tmp"

  echo
  rm -f "$combined_tmp"
}


print_combined_tree


echo

# Prompt loop supports editing the tocopy list before proceeding
while true; do
  read -r -p "Copy the listed files to destination now? [y/N/editlist] " ans
  case "$ans" in
        y|Y)
      # proceed to copy (no backups)
      if [ ! -s "$tocopy" ]; then
        echo "No files to copy (tocopy.txt is empty)."
        exit 0
      fi

      # sanitize tocopy in-place: remove empty lines and trim whitespace
      tmp_sanitized=$(mktemp)
      awk 'NF{gsub(/^[ \t]+|[ \t]+$/,""); print}' "$tocopy" > "$tmp_sanitized" && mv "$tmp_sanitized" "$tocopy"

      errors=0

      # Create any missing directories first (preserve mode if desired)
      if [ -s "$tmp_missing_dirs" ]; then
        echo "Creating missing directories..."
        while IFS= read -r -d '' rel || [ -n "$rel" ]; do
          # normalize rel for root
          if [ "$rel" = "." ]; then
            destdir="$dest"
          else
            destdir="$dest/$rel"
          fi
          if [ ! -d "$destdir" ]; then
            if mkdir -p -- "$destdir"; then
              echo "Created dir: $rel"
            else
              echo "Error creating dir: $rel"
              errors=$((errors+1))
            fi
          fi
        done <"$tmp_missing_dirs"
      fi

      while IFS= read -r rel || [ -n "$rel" ]; do
        [ -z "$rel" ] && continue

        srcf="$src/$rel"
        destf="$dest/$rel"

        if [ ! -e "$srcf" ]; then
          echo "Warning: source file missing, skipping: $rel"
          errors=$((errors+1))
          continue
        fi

        destdir=$(dirname -- "$destf")
        mkdir -p -- "$destdir"

        # copy file, preserving mode/timestamps; overwrite dest if present
        if cp -p -- "$srcf" "$destf"; then
          echo "Copied: $rel"
        else
          echo "Error copying: $rel"
          errors=$((errors+1))
        fi
      done < "$tocopy"

      if [ "$errors" -ne 0 ]; then
        echo "Completed with $errors errors."
        exit 1
      else
        echo "All files copied successfully."
      fi

      break
      ;;
    editlist|e|E|edit)
      # Allow user to edit the tocopy list. Prefer yad if available, otherwise $EDITOR.
      if command -v yad >/dev/null 2>&1; then
      yadp="yad"
      elif [ -n "$yadp" ]; then
      :
      fi
        tmp_edit=$(mktemp)
        # open editable dialog; capture edited content to tmp_edit
        if "$yadp" --text-info --filename="$tocopy" --editable --title="Edit files to copy" --width=800 --height=600 >"$tmp_edit"; then
          # user pressed OK: replace tocopy with edited content
          mv "$tmp_edit" "$tocopy"
          echo "Saved edits to $tocopy."
        else
          # user cancelled: discard edits
          rm -f "$tmp_edit"
          echo "Edit cancelled; $tocopy unchanged."
        fi
      echo "Preview (first 200 lines):"
      sed -n '1,200p' "$tocopy" || true
      # loop back to prompt
      ;;
    ""|n|N)
      echo "Aborted. No changes made."
      exit 0
      ;;
    *)
      echo "Unrecognized option: $ans"
      echo "Type 'y' to copy, press Enter or 'n' to abort, or 'editlist' to edit $tocopy."
      ;;
  esac
done


if [ -s "$tmp_size" ] || [ -s "$tmp_md5" ] || [ -s "$tmp_missing" ]; then
  exit 1
else
  exit 0
fi
