#!/usr/bin/env bash
# INPUT_FILE="${1:-/tmp/testd.txt}"
TITLE="Script Control Panel"
TMP_OUT="$(mktemp)"
OUTPUT_FILE="scrconf.txt"
INPUT_FILE="$(mktemp)"
trap 'rm -f "$TMPFILE"' EXIT

# Read script list from env or from a file if provided
if [[ -z "${RGSS_SCRIPTS:-}" ]]; then
  "$yadp" --info --text="Environment variable RGSS_SCRIPTS not set. Export it as lines 'index: name' and retry." --title="Error"
  exit 1
fi

# Normalize RGSS_SCRIPTS into lines "index: name"
echo "$RGSS_SCRIPTS" > "$INPUT_FILE"

if [[ ! -f "$INPUT_FILE" ]]; then
  echo "File not found: $INPUT_FILE" >&2
  exit 1
fi

mapfile -t LINES < <(sed -n 's/^[[:space:]]*//;s/[[:space:]]*$//;/^$/d;p' "$INPUT_FILE")

if [[ ${#LINES[@]} -eq 0 ]]; then
  echo "No lines to show in $INPUT_FILE" >&2
  exit 1
fi

# Load previous config into associative arrays
declare -A PRELOAD_CHECK PRELOAD_CMD
if [[ -f "$OUTPUT_FILE" ]]; then
  while IFS=- read -r idx cmd; do
    PRELOAD_CHECK["$idx"]="TRUE"
    PRELOAD_CMD["$idx"]="$cmd"
  done < "$OUTPUT_FILE"
fi

YAD_ARGS=(--form --title "$TITLE" --width=700 --height=400 --scroll --button=gtk-ok:0 --button=gtk-cancel:1)

for i in "${!LINES[@]}"; do
idx=$((i+1))
  label="${LINES[idx]}"
  safe_label="${label//:/ }"
  safe_label="${safe_label//\"/\\\"}"

  chk_val="${PRELOAD_CHECK[$idx]:-FALSE}"
  cmd_val="${PRELOAD_CMD[$idx]:- }"

  YAD_ARGS+=(--field="${safe_label}:CHK" "$chk_val")
  YAD_ARGS+=(--field=" " "$cmd_val")
done

if "$yadp" "${YAD_ARGS[@]}" >"$TMP_OUT"; then
  IFS='|' read -r -a VALUES < "$TMP_OUT"
  : > "$OUTPUT_FILE"

  for i in "${!LINES[@]}"; do
    chk_val="${VALUES[i*2]}"
    cmd_val="${VALUES[i*2+1]}"
    cmd_val="$(echo "$cmd_val" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
    idx=$((i+1))
    case "$chk_val" in
      1|TRUE|true)
        if [[ -n "$cmd_val" ]]; then
          echo "${idx}-${cmd_val}" >> "$OUTPUT_FILE"
        else
          echo "$idx" >> "$OUTPUT_FILE"
        fi
        ;;
    esac
  done

  echo "Selections saved to $OUTPUT_FILE"
else
  echo "Cancelled or closed."
fi

rm -f "$TMP_OUT"
