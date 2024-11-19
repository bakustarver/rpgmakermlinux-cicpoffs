#==============================================================================
#    Advanced Text System
#    Version: 3.0c
#    Author: modern algebra (rmrk.net)
#    Date: September 7, 2010
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Thanks:
#    *Zeriab* for his tutorial on RegExp, but most of all for being my mentor 
#      and friend. Without him, this script, and all my other scripts, will 
#      never have been made.
#  For ideas on improving this script through bug reports or suggestions:
#    Arrow-1, Irock, Stonewall, PhantomH, Seasons in the Abyss, Aindra, Arion,
#    Okogawa, Megatronx, Charbel, Adrien., dricc, Raukue, EricDahRed, redyugi,
#    HeartofShadow, Woratana, tsy0302, Kayo, deadnub.
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Description:
#
#    This scripts adds a whole bunch of features to message boxes, making them
#   much prettier and with a lot more functionality than the default. What and 
#   how to use each feature will be exhaustively detailed in the instructions,
#   but for now I will just give a list of a few of the staple features:
#
#      ~Appended Text~
#    A staple feature of ATS, this will combine the messages of subsequent text
#   events (that share properties). It is useful particularly when combined 
#   with text scrolling.
#
#      ~Text Scrolling~
#    This feature allows longer text messages to scroll upwards, so that for 
#   longer messages, the contents of the window will scroll upwards when it 
#   reaches the bottom, allowing the player to read what has come before and
#   ignore the annoying new page requirements. This feature has been beefed up
#   in ATS 3.0, with the scroll now being much smoother and the speed user-
#   definable, in addition to the new feature of Scroll Review, which, once the
#   message is finished, allows the player to scroll upwards to see any text he
#   or she might have missed. Moreover, you can also scroll by page instead.
#
#      ~Paragraph Format~
#    Always a staple feature in the ATS, turning this feature on allows you to 
#   avoid the hassle that comes with making the text fit within the window by 
#   analyzing the exact length with reference to the grey arrows. Now you can 
#   type freely and know that nothing will get cut off. This feature takes on 
#   additional importance in ATS 3.0 with the addition of a special message 
#   codes like \S[] and \S![], more on which will be discussed later. As 
#   always, you can still manually define line breaks with the \LB code. As in 
#   previous versions, you can also justify text, meaning that the letters will 
#   be spaced out so as to exactly cover the width of the message box. Unlike 
#   previous versions, this paragraph formatter is integrated with the ATS in 
#   order to better accomodate text features and therefore does not require a 
#   separate Paragraph Formatter script to work.
#
#      ~Advanced Choices~
#    Another staple feature of the ATS, you have been able to append choices 
#   from subsequent choice branches and show them all in a separate window. 
#   This feature has been vastly expanded on in ATS 3.0. In earlier versions, 
#   many of the features respecting advanced choices, such as appending them 
#   and tying choices to switches, were available only if using the choice
#   window. In ATS 3.0, these features have been included in the traditional
#   in-message window. Don't want to use the choice window but do want to 
#   exclude some choices unless a particular switch is ON? You can do that now.
#   In addition to all of the old features, there are quite a few new ones that
#   will make your choices more dynamic. One is the ability to make an the 
#   cursor pass over an option. This means it is a perfect way to include  
#   headings or blank spaces in your choice box. Another new feature are the 
#   disable codes which allow you to make a choice unselectable, so when the 
#   player tries to select it the buzzer sound is played and nothing happens. 
#   Further, there is an external message property that can be set which you 
#   can use to automatically add certain properties to modify the choice text
#   if it is disabled, such as a command to reduce the opacity of it. In 
#   addition, you can automatically modify all choice texts at once - want to 
#   add a larger indent or make all choices blue - you can do that. Finally, 
#   another unique feature of ATS choices is the \+{} code. Placed in a comment
#   directly below a when branch of a choice branch, this allows you to add 
#   whatever text you want to that choice, effectively ignoring the limitations 
#   on choice message size. This means you can make your choices sentences 
#   instead of simple yes or nos. In addition to this, another new feature of 
#   ATS 3.0 choices is that choice messages can be longer than one line and 
#   that is recognized both in the choicebox and the new and improved default 
#   choice scheme. The last new feature added to choices in ATS 3.0 is the 
#   ability to set a help window for it. This means it will set a window whose
#   contents will change depending on which choice the player is hovering over.
#
#      ~Advanced Faces~
#    From the very start, animated faces have been a part of the ATS. This 
#   feature allows you to have the faces animate for every few letters drawn -
#   perfect to make it look like the face is talking. However, this is not all
#   the special features you gain with faces. As always, you can also use much
#   larger or smaller faces, mirror them, set them to the right side of the 
#   text box, or move them anywhere you like, change the opacity, or surround 
#   it with a window. New in ATS 3.0, you can now define the exact size of the 
#   border of the window if using it, or you can use another sprite for it 
#   (just like the dim background of the Message Window). Also new in ATS 3.0, 
#   you can scroll the face in when it first appears either horizontally or 
#   vertically, or fade it in. You can also choose to make the face appear over
#   or under the message window, and change the blend type. 
#
#      ~Letter Control~
#    This has always been a feature of the ATS and it allows you to control the
#   speed that text is drawn, as well as putting in pauses at will. It also 
#   allows you to specify a sound, and you can even have it vary the pitch with
#   every letter so that it mimics the sound of a voice. New in ATS 3.0, you 
#   can control the speed text is drawn not only through the \> and \< codes, 
#   but more directly via the \S[] command, where you can either set it to add
#   or subtract a number from the current speed, or you can set it directly. 
#   See the section on this code in Special Message Codes for details. 
#
#      ~Advanced Message Window~
#    There are also a number of special features related to the appearance and
#   position of the message window. Most of these should be familiar to users 
#   of ATS 2.0. You can manually control the size and exact position of the 
#   text box, or you can set it to automatic. Further, you can use the
#   :fit_window_to_text property to set the width of the window to be only as 
#   long as it needs to be to accomodate the longest line. As always, you can 
#   set what windowskin to use, the font, how much space for each line, and the
#   dim background. New features include the :do_not_obscure property, which, 
#   when using default positioning, will ensure that the characters specified 
#   in the :obscure_characters array. This feature will be ignored if manually
#   setting position however. The only thing it does is, if you have the 
#   position set to bottom, but that would cover the player and you include the
#   player in your obscure_characters array, then it would move the message box
#   to the top instead. As always, you can use \OC[], \UC[], \LC[], and \RC[] 
#   to position the window in reference to a character. Something new is the 
#   \E[] command, which will set it above the character, unless there is not
#   enough room, in which case it sets it below the character. Another new 
#   feature is speech tags, which, when using \OC[], \UC[], or \E[] codes will
#   place a tag from the character speaking to the message window if this 
#   feature is enabled. 
#
#      ~Word Boxes~
#    New to ATS 3.0, this is a very simple feature that works akin to the Gold
#   or Name window. Basically, it allows you to set a one line message to 
#   appear instantly. It can be used, for instance, if you want to show the 
#   value of a variable in the corner while showing this message or choice.
#   Naturally, name boxes have also been retained from ATS 2.0
#
#      ~Graphic Novel Support~
#    New to ATS 3.0, this feature, when activated, allows the player to 
#   completely hide and prevent from updating every message related window for 
#   as long as the player holds a button you choose or, if you wish, it can be
#   a toggle rather than a press. It is useful if you have a game that relies 
#   heavily on graphics and you want to give the player the opportunity to just
#   look at the background, like in many graphic novel games.
#
#      ~Move While Showing~
#    Also new to ATS 3.0, this is a feature that, when activated, allows the 
#   player to move around while a message is showing. However, when a choice
#   selection is active, this feature will be disabled.
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Instructions:
#
#    Place this script in its own slot in the Script Editor (F11) above Main 
#   and below Materials. This script is not compatible with most other message
#   systems, so you may need to remove any other message systems. If you are 
#   upgrading to this from ATS 2.0, you will need to also install the 
#   conversion patch, located in this script's thread at RMRK. 
#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#      ~Special Message Codes~
#         These codes work in all ATS windows.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#     You will recognize many of these from previous versions of the ATS. A lot
#    are new though.
# \lb    - Line break. Go to next line.
# \v[x]  - Draw the value of the variable with ID x.
# \n[x]  - Draw the name of the actor with ID x.
# \c[x]  - Set the colour of the text being drawn to the xth colour of the 
#         Windowskin palette. 0 is the normal color and 16 is the system color.
# \c[#RRGGBB] - Set the colour of the text being drawn to any colour, using 
#         hexadecimal. You can set each colour (red, green, blue) to anything 
#         from 0-255 (00-FF). You must use hexadecimal values.
# \p[x] OR \pid[x] - Draw the ID of the actor in the xth position in the party.
# \ni[x] - Draw the name of the item with ID x.
# \nw[x] - Draw the name of the weapon with ID x.
# \na[x] - Draw the name of the armor with ID x.
# \ns[x] - Draw the name of the skill with ID x.
# \nt[x] - Draw the name of the state with ID x.
# \nc[x] - Draw the name of the class with ID x.
# \ne[x] - Draw the name of the event with ID x on the current map.
# \nm[x] - Draw the name of the enemy with ID x.
# \nl[x] - Draw the name of the element with ID x.
# \nv[x] - Draw the name of the variable with ID x.
# \nsw[x] - Draw the name of the switch with ID x.
# \np[x] - Draw the name of the actor in the nth position in the party.
# \map   - Draw the name of the map the player is currently on.
# \map[x] - Draw the name of the map with ID x.
# \di[x] - Draw the description of the item with ID x.
# \dw[x] - Draw the description of the weapon with ID x.
# \da[x] - Draw the description of the armor with ID x.
# \ds[x] - Draw the description of the skill with ID x.
# \pi[x] - Draw the price of the item with ID x.
# \pw[x] - Draw the price of the weapon with ID x.
# \pa[x] - Draw the price of the armor with ID x.
# \i#[x] - Draw the number of the item with ID x that the party posesses.
# \w#[x] - Draw the number of the weapon with ID x that the party posesses.
# \a#[x] - Draw the number of the armor with ID x that the party posesses.
# \ac[x] - Draw the class of the actor with ID x.
# \i[x]  - Draw the icon with index x.
# \ii[x] - Draw the icon of the item with ID x.
# \wi[x] - Draw the icon of the weapon with ID x.
# \ai[x] - Draw the icon of the armor with ID x.
# \si[x] - Draw the icon of the skill with ID x.
# \ti[x] - Draw the icon of the state with ID x.
# \fn[fontname] - Change the font to fontname
# \fs[x] - Change the fontsize to x.
# \fa[x] - Change the alpha value (opacity) of the font to x.
# \b     - Turn bold on. Text drawn after this code will be bolded.
# /b     - Turn bold off.
# \i     - Turn italic on. Text drawn after this code will be italicized.
# /i     - Turn italic off.
# \s     - Turn shadow on. Text drawn after this code will have a shadow.
# /s     - Turn shadow off.
# \u     - Turn underline on. Text drawn after this code will be underlined.
# /u     - Turn underline off.
# \hl[x] - Turn highlight on. Text drawn after this code will be highlighted 
#         with colour x from the windowskin palette
# /hl OR \hl[-1] - Turn highlight off.
# \l     - align the text to the left
# \r     - align the text to the right
# \c     - align the text to the centre.
# \t     - Tab. Draws the next character at the nearest pixel that is a 
#         multiple of 32. Doesn't work well with the :justified_text property.
# \x[n]  - Sets the x position for drawing directly to n. 
# \f[key] - Draw the value corresponding to that key in the FILTERS array. If 
#          the key has quotation marks around it, you need to put "key"
# \s[x,text] - Will only draw text if the switch with ID x is ON.
# \s![x,text] - Will only draw text if the switch with ID x is OFF.
# \vocab[method] - Will draw whatever Vocab.method returns, if it is a valid 
#          method call. Suitable values for method are: level, level_a, hp, 
#          hp_a, mp, mp_a, atk, def, spi, agi, weapon, armor1, armor2, armor3,
#          armor4, weapon1, weapon2, attack, skill, guard, item, equip, status,
#          save, game_end, fight, escape, new_game, shutdown, to_title, gold,
#          continue, cancel
# \actor_method[x] - This will draw whatever actor.method returns for whoever
#          actor x. Some suitable values for method are: atk, def, spi, agi, 
#          level, exp, name, hp, maxhp, mp, maxmp, & any other methods that 
#          return values from Game_Actor.
# \i_method[x] - This will draw whatever item.method returns for the item with
#          ID x. Some suitable values for method are: name, description, 
#          base_damage, variance, atk_f, spi_f, price, hp_recovery_rate,
#          hp_recovery, mp_recovery_rate, mp_recovery, parameter_points, note,
#          n, & any other methods that return values from RPG::Item. Also, note
#          will return all of the contents of the note field, whereas n will 
#          only return notefield text located between a \msg[text]msg/ code.
# \w_method[x] - This will draw whatever weapon.method returns for the weapon 
#          with ID x. Some suitable values for method are: name, description,
#          price, hit, atk, def, spi, agi, note, n, & any other methods that 
#          return values from RPG::Weapon. Also, note will return all
#          of the contents of the note field, whereas n will only return  
#          notefield text located between a \msg[text]msg/ code.
# \a_method[x] - This will draw whatever armor.method returns for the armor 
#          with ID x. Some suitable values for method are: name, description,
#          price, eva, atk, def, spi, agi, note, n, & any other methods that 
#          return values from RPG::Armor. Also, note will return all
#          of the contents of the note field, whereas n will only return  
#          notefield text located between a \msg[text]msg/ code.
# \s_method[x] - This will draw whatever skill.method returns for the skill 
#          with ID x. Some suitable values for method are: name, description,
#          base_damage, variance, atk_f, spi_f, hit, mp_cost, note, n, & any 
#          other methods that return values from RPG::Weapon. Also, note will 
#          return all of the contents of the note field, whereas n will only 
#          return notefield text located between a \msg[text]msg/ code.
# \t_method[x] - This will draw whatever state.method returns for the state
#          with ID x. Some suitable values for method are: name, atk_rate, 
#          def_rate, spi_rate, agi_rate, message1, message2, message3, 
#          message4, note, n, & any other methods that return values from 
#          RPG::State. Also, note will return all of the contents of the note 
#          field, whereas n will only return notefield text located between a 
#          \msg[text]msg/ code.
# \enemy_method[x] - This will draw whatever enemy.method returns for whoever
#          the enemy with ID x is. Some suitable values for method are: name,
#          atk, def, spi, agi, hit, eva, exp, gold, note, n, & any other 
#          methods that return values from RPG::Enemy. Also, note will return
#          all of the contents of the note field, whereas n will only return 
#          text located between a \msg[text]msg/ code.
# \#{code}# - This will evaluate code. So, if you know scipting, you can place
#          any code there and it will draw whatever is returned by it. For 
#          instance: \#{$game_system.save_count}# would draw the number of 
#          times the player has saved the current game.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#       ~Message Box specific codes~
#          These codes will only work in the Message Window.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# \g     - Shows a window with the party's gold. Closes if already open
# \nb[name] - Shows a name box with name displayed in the box
# /nb    - Closes the namebox
# \wb[word] - shows the word in its own window, similar to the gold window.
# /wb    - Closes a wordbox
# \.     - Wait 15 frames (1/4 second) before drawing the next letter.
# \|     - Wait 60 frames (1 second) before drawing the next letter.
# \w[x]  - Wait x frames before drawing the next letter.
# \!     - Pause. Make the message wait for player input before continuing.
# \^     - Skip the next pause without waiting for player input.
# \>     - Speed up the text drawing by reducing wait time between letters by 
#         one frame.
# \<     - Slow down the text drawing by increasing wait time between letters by
#         one frame.
# \S[x]  - Change the speed the text draws by adding x to the current time 
#         between drawing letters. Thus, \s[2] is the equivalent of \<\< and 
#         \s[-3] is the equivalent of \>\>\>. You can also directly set the 
#         speed by putting an equal sign, so \s[=0] would set the time to one 
#         frame between drawing letters, and \s[=-1] would set it to instant.
# \@     - Turn on Show line fast - the line up to /@ will be shown instantly
# /@     - Turn off Show line fast.
# \@@    - Turn on Show message fast. This will show the entire message 
#         instantly, at least until the next scroll or it hits a /@@
# /@@    - Turn off Show message fast.
# \%     - Disable Text Skip through user input
# \se[sound effect name] - Plays a sound effect
# \me[music effect name] - Plays a musical effect
# \ani[target_id,animation_id] - Shows animation_id on target_id. 0 => player,
#         other numbers indicate the ID of the event
# \bln[target_id,balloon_id] - Same as ani, but shows a balloon
# \af[x] - Show the face of the actor with ID x.
# \pb    - Page Break. Clear the contents and start drawing from the first line
# \oc[x] - positions the message box over a character. 0 => player; when >1, it
#         will show over the event with that ID on the map.
# \uc[x] - same as \oc, but places box under character 
# \lc[x] - same as \oc, but places box to left of character
# \rc[x] - same as \oc, but places box to right of character
# \e[x]  - same as \oc, but if the box is too tall to comfortably fit, is moved
#         below the character instead.
# \mxy[x, y] - Set the position of the message window to x, y.
# \fxy[x, y] - Set the position of the face window to x, y.
# \nxy[x, y] - Set the position of the name window to x, y.
# \#!{code}# - This will evaluate code at the time the window reaches this code
#         when drawing. It does not put the result of the code into the message
#         but is instead intended to be evaluated. For instance: \#!{new_page}#
#         would perform the same function as \pb. You need to know syntax!
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#      ~Choice Branch Specific Codes~
#         These codes only work in choice branches.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# \skip  - Placing this in a choice text means that the player will not be able
#         to hover over or select this option, but will skip to the next one. 
#         Perfect for making subheadings for your choices, or blank spaces.
# \soff[x] - A choice with this in it will only appear in the branch if the 
#         switch with ID x is OFF.
# \son[x] - Same as soff[x], but it will only appear if switch x is ON.
# \d[x]  - A choice with this in it will be disabled (unselectable) if the 
#         switch with ID x is OFF. It will still show up, and the player can 
#         hover over it, but he or she will be prevented from selecting it.
# \d![x] - Same as \d[x], except it will be disabled if switch x is ON.
# \wb[text] - This code will create a help window. When the player hovers over
#         that choice, it will show text in the help window. This allows you to
#         explain the choice or make any content in the help window dependent 
#         on which choice the player is on.
# \+{text} - This is actually a code you can put in a comment that is directly
#         below the when branch of a choice, and it will add text to the 
#         choice. This effectively ignores the normal limitations on the size
#         of a message in a choice, allowing you to make longer texts for 
#         choices.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#      ~Message Properties~
#    The following are properties of the message window that are set prior to
#   calling the message and govern many properties. You set the default values
#   to the constants of the same name in Game_ATS, starting at line 766. Those 
#   will be the values that each game starts out with. You can then change them 
#   on a message to message basis through either of the codes:
#      ats_next (:property, new_value)
#   or:
#      $game_message.property = new_value
#   However, it will reset to the default after the next message is processed.
#   If you want to change it on a permanent basis, you have to use either:
#      ats_all (:property, new_value)
#   or:
#      $game_ats.property = new_value
#      $game_message.property = new_value
#
#    All of the properties and what types of values are expected for each are
#   listed below. Note that if you use the ats_next or ats_all commands, you 
#   have to retain the : in front of the name. If you use the $game_ats or 
#   $game_message route then you don't use the :
#
#    You can reset $game_ats to the constants with: $game_ats.reset
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# :max_lines - This is the maximum number of lines to show at a time before 
#       either going to a new page or scrolling. Default: 4
# :message_speed - This is the number of frames to wait in between drawing 
#       letters. -1 is instant. 0 is 1 frame. Default: 0
# :skip_disabled - Whether the player can speed text up by pressing ENTER.
# :append_text - Whether to include all text from subsequent text commands in 
#       the next message. true => append; false => do not append. Default: true
# :append_choice - Whether to include all choices from subsequent choice 
#       choice branches in the next choice selection. The cancel branch is 
#       inherited from the last branch to not have cancel disabled. 
#       true => append; false => do not append. Default: true
# :scrolling - Whether to scroll once :max_lines is exceeded or to pause and 
#       start a new page. true => scroll; false => new page. Default: true
# :scroll_speed - If :scrolling is true, this is how many pixels it moves per
#       frame when scrolling text. Default: 2
# :scroll_show_arrows - If :scrolling is true, this determines whether or not 
#       to show the arrows when the contents grow. true => show; false => do 
#       not show. Default: true
# :scroll_autopause - If :scrolling is true, this determines whether or not to
#       insert a pause before it scrolls to the next line. Default: false
# :scroll_review - If :scrolling is true, this option is whether or not the 
#       player has the option to review the message that has just finished by 
#       pressing up and down. true => yes; false => no. Default: true
# :scroll_by_page - Whether to scroll by whole page or by line. Default: false
# :paragraph_format - When this is true, the manual line breaks are ignored and
#       it will draw as many characters as will fit on each line. You can still
#       force a line break with the \lb code though. Default: false
# :justified_text - If :paragraph_format is true, then this option will make 
#       the spacing of a line exactly such that it takes up the entire width of
#       the message window. Default: false
# :letter_sound - When this is true, a sound will be played upon drawing 
#       letters. Default: false
# :letter_se - If :letter_sound is true, this is the SE that is played. It is 
#       set in the format ["filename", volume, pitch]. Default: ["Open1", 40]
# :letters_per_se - If :letter_sound is true, this is the frequency that the 
#       SE is played. The SE will play every time this number of letters is 
#       drawn. Default: 3
# :random_pitch - If :letter_sound is true, this is the range the pitch of the 
#       SE will vary within. It can be used to mimic the pitch variations of 
#       a human voice. It is a range in the format x..y. If x is equal to y, 
#       then the pitch won't vary. If set to an integer, it will take that as 
#       the variance from the regular pitch of the SE. Default: 100..100
# :speech_tag_index - This refers to which speech tag to use when showing a 
#       message window above or below an event or player. -1 => no tag, while 
#       anything greater refers to the graphic of the corresponding index in
#       :speech_tag_graphics. Default: -1
# :speech_tag_graphics - This is an array containing the names of all speech 
#       tag graphics in the System folder of Graphics. Which one is used when
#       showing a message depends on the value of :speech_tag_index.
#       Default: ["Speech Tag 1", "Speech Tag 2", "Thought Tag 1"]
# :start_sound - If true, a sound will be played when a message starts.
#       Default: false
# :start_se - If :start_sound is true, this is the SE that is played. It is 
#       set in the format ["filename", volume, pitch]. Default: ["Chime2"]
# :finish_sound - If true, a sound will be played when a message finishes.
#       Default: false
# :finish_se - If :finish_sound is true, this is the SE that is played. It is 
#       set in the format ["filename", volume, pitch]. Default: ["Chime1"]
# :pause_sound - If true, a sound will be played when a message pauses.
#       Default: false
# :pause_se - If :pause_sound is true, this is the SE that is played. It is 
#       set in the format ["filename", volume, pitch]. Default: ["Decision2"]
# :terminate_sound - If true, a sound will be played when a message closes.
#       Default: false
# :terminate_se - If :terminate_sound is true, this is the SE that is played. It is 
#       set in the format ["filename", volume, pitch]. Default: ["Cancel"]
# :move_when_visible - When this is true, the player will still be able to move
#       when the message window is displaying text. It is recommended that you
#       turn scroll review off when using this feature though, as it looks 
#       dumb. Also, whenever a choice starts, it takes precedence and the 
#       player will not be able to move even if this is true. Default: false
# :graphic_novel - When this is true, it means the player can press the 
#       :hide_button and everything relating to the message window becomes 
#       invisible and stops updating until the player releases the button. It
#       is intended for use where a player might want to see the whole screen
#       and not have things hidden by the ATS windows. Default: false
# :hide_button - If :graphic_novel is true, this is the button that hides the
#       ATS windows when pressed. Default: Input::F5
# :gn_press_or_toggle - If :graphic_novel is true, this determines whether the
#       player has to hold down the :hide_button or whether it acts as a toggle.
#       true => press; false => toggle. Default: true
# :filters - This is a hash holding user-defined replacements for special 
#       codes. This is the hash that is accessed when using the \f[x] message
#       code and is useful, for instance, if you have a character choose their
#       sex at the start of the game. Then you can set the filters to the 
#       appropriate pronoun and use that and not have to have separate text 
#       boxes just to differentiate between when people say he or her. 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# :message_x - This is the x coordinate of the message window. If it is set to
#       -1, then it will be centred. If not, it will be directly set to that
#       coordinate of the screen. Default: -1
# :message_y - This is the y coordinate of the message window. If it is set to
#       -1, then it will abide by the normal way of setting position through 
#       the top, middle, bottom option in the text window. If it is not -1, 
#       then it will be directly set to that coordinate. Default: -1
# :wlh - the line height of lines in the message window. Default: 24
# :battle_wlh - the line height of lines in the message window during battle. 
#       This should always be 24 unless you have a good reason. Default: 24
# :do_not_obscure - When using default positioning, this will choose a 
#       different position setting if the current one is over any of the 
#       characters included in :obscure_characters
# :obscure_characters - If :do_not_obscure is true and the message is being set
#       using default positioning, then the message box will be choose override
#       the chosen position if the chosen position obscures one or more of the
#       characters in this array and another position would obscure less. The 
#       player is identified by 0 and any number greater than that refers to 
#       the event with that ID. When setting up the default, it is recommended 
#       that you only include the player and set others only on a map by map
#       basis. Default: [0]
# :obscure_buffer - this is how much space from the bottom of the character you
#       want to avoid obscuring. It should be set to the height of the tallest
#       character you want to avoid obscuring. Default: 32
# :fit_window_to_text - If this is true, then the window will be made to be 
#       just wide enough to contain the longest line and just tall enough to 
#       contain either all the lines up to :max_lines. Default: false
# :message_width - This is how many pixels wide the message window is.
#       Default: 544
# :message_height - This is how many pixels tall the message window is.
#       Default: 128
# :message_opacity - This is the opacity of the window. Default: 255
# :message_backopacity - This is the opacity of the background of the 
#       windowskin. Default: 200
# :message_windowskin - This is the windowskin that this window uses. It must 
#       be a graphic located in the System folder. Default: "Window"
# :message_fontcolour - This is the default colour of the font that is used
#       everytime a new page is made. It can either refer to the windowskin
#       palette (0-31) or be [red, green, blue] array. Default: 0
# :message_fontname - This is the default font of the window. It can either 
#       refer to a single font or to a prioritized array of fonts, where the 
#       first one is used unless that font is not installed, and so on. 
#       Default: ["Verdana", "Arial", "Courier New"]
# :message_fontsize - This is the default size of the font. Default: 20
# :message_fontalpha - This is the default opacity of the text. Default: 255
# :message_dim - The graphic to use when selecting the "Dim" option. 
#       Default: "MessageBack"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# :face_x - The x coordinate of the face box. If set to -1, the x-coordinate 
#       will be automatically positioned. If not, it will be directly set to 
#       this value. Default: -1
# :face_y - The y coordinate of the face box. If set to -1, the y-coordinate 
#       will be automatically positioned. If not, it will be directly set to 
#       this value. Default: -1
# :face_z - If this is >0, it will show up above the message window. If less 
#       than 0, it will show up below the message window. Default: 10
# :face_side - When :face_x is -1, this determines which side of the message 
#       box the face shows up on. true => Left; false => Right. Default: true
# :face_offset_x - When :choice_x is -1, this is added to the x position.
#       Default: 0
# :face_offset_y - When :choice_y is -1, this is added to the y position.
#       Default: 0
# :face_width - This determines the width of the face. When 0, it will show the
#       whole width of the face, even if using single face graphics. If you want
#       to show only a portion of the face, then set it directly. Default: 0
# :face_height - This determines the height of the face. When 0, it will show 
#       the whole height of the face, even if using single face graphics. If 
#       you want to show only part of the face, then set it directly. Default: 0
# :face_mirror - When true, the face will be drawn mirrored. Default: false
# :face_opacity - This is the opacity of the face. Default: 255
# :face_blend_type - This is the blend type of the face sprites. 0 => normal; 
#       1 => addition; 2 => subtraction. Default: 0
# :face_fadein - When this is true, the face will fadein when starting a 
#       message instead of just automatically appearing. Default: false
# :face_fade_speed - If :face_fadein is true, this is how much the opacity will
#       change every frame. Default: 10
# :face_scroll_x - Option to scroll the face in horizontally. Default: false
# :face_scroll_y - Option to scroll the face in vertically. Default: false
# :face_scroll_speed - If either :face_scroll_x or :face_scroll_y are true, 
#       this is the number of pixels per frame it scrolls in at.
# :animate_faces - When this is true, specially labelled face files will 
#       animate. Face files that have ![x] in the name will take the first x
#       faces in the file and animate between them. Alternatively, it can take
#       the face of the same index from separate face files that are sequenced
#       by suffixes _1, _2, etc... Default: true
# :letters_per_face - when :animate_faces is true, this is how many letters to
#       draw between rotating the faces.
# :face_window - If true, the face will be framed by a window. Default: false
# :face_window_opacity - If :face_window is true, this is the opacity of that
#       window. Default: 255
# :face_windowskin - If :face_window is true, this is the windowskin it uses.
#       Default: "Window"
# :face_border_size - If :face_window is true, this is the size of the border.
#       Default: 6
# :face_dim - If using :face_window and dim, the sprite to stretch as a 
#       background for the face. Default: "MessageBack"
# :face_use_dim - The setting for using dim. If 0, it will never use dim. If 1, 
#       it will use the dim sprite if :face_window is true. If 2, it will use
#       dim only when the message window is also using dim. Default: 0
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# :choice_text - This is a bracket for any choice text. It is useful if, for
#       instance, you want particular codes to apply to every choice in a 
#       branch. You must include %s in the string, and that is where the actual
#       choice text will show up, bracketed by whatever other codes you put in
#       Default: "    %s" (meaning every choice will be indented by four spaces)
# :disabled_choice_text - Same as above, except it only applies to choices that
#       are disabled and is applied after :choice_text is. It is useful if you
#       want to differentiate between disabled choices and non-disabled ones.
#       Unlike :choice_text, %s doesn't have to be included and in that case all
#       disabled choices would simply be replaced by this text.
#       Default: "\\FA[128]%s\\FA[255]" (meaning disabled choices will be drawn
#       at 128 opacity).
# :choicebox_text - The same as :choice_text, but this is what is applied when
#       using a choicebox instead of :choice_text. Default: "%s" (no change)
# :choice_window - Whether or not choices will show up in a separate window. 
#       Default: false
# :choice_x - The x coordinate of the choice window. When this is -1, the x 
#       position will be set automatically in reference to the position of the
#       message window (end of the side opposite the face). When anything else,
#       the x position is directly set to that coordinate. Default: -1
# :choice_y - The y coordinate of the choice window. Whwn this is -1, the y
#       position is set automatically directly above the message window or 
#       below, if it goes off screen when placed above. Default: -1
# :choice_offset_x - When :choice_x is -1, this is added to the auto x position.
#       Default: -16
# :choice_offset_y - When :choice_y is -1, this is added to the auto y position.
#       Default: 16
# :choice_width - This is the width of the choice window. When -1, it will set
#       it to as wide as necessary to accomodate the longest line, up to a 
#       maximum of the screen width. Default: 192
# :choice_height - This is the height of the choice window. When -1, it is set
#       to the number of rows necessary to draw all choices, up to :max_lines.
# :column_max - When using :choice_window, the number of columns. Default: 1
# :row_max - When :choice_height is -1, the max number of rows. Default: 4
# :choice_spacing - When :column_max > 1, this is how much empty space is left
#       between options on the same row. Default: 20
# :choice_opacity - This is the opacity of the choice window. Default: 255
# :choice_backopacity - This is the opacity of the background of the choice 
#       window. Default: 200
# :choice_windowskin - This is the name of the System file to use as the 
#       windowskin for the choice window. Default: "Window"
# :choice_fontcolour - The default colour of text in the choice window. It can
#       be from the windowskin palette or a [red, green, blue] array. Default: 0
# :choice_fontname - The font for the choice window. If an array, it will take
#       the first font in the array that the player has installed. 
#       Default: ["Verdana", "Arial", "Courier New"]
# :choice_fontsize - Default size of the font in the choice window. Default: 20
# :choice_wlh - The vertical space of each row of the choice window. Default: 24
# :choice_dim - If using :choice_window and dim, the sprite to stretch as a 
#       background for the choice branch. Default: "MessageBack"
# :choice_use_dim - The setting for using dim. If 0, it will never use dim. If
#       1, it will use the dim sprite if :choice_window is true. If 2, it will
#       use dim only when the message window is also using dim. Default: 2
# :choice_on_line - Whether to show the choice box adjacent to the message 
#       window or not. Doesn't apply if :choice_width is not directly set or if 
#       :fit_window_to_text is on and larger than :choice_width. Default: false
# :choice_opposite_face - When true, the side the choice is shown on is the
#       opposite side the face is on. And vice versa. Default: true
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# :choicehelp_x - The x coordinate of the choicehelp window. When this is -1, 
#       the x position is centred. Default: -1
# :choicehelp_y - The y coordinate of the choicehelp window. Whwn this is -1, 
#       the y position is at the top of the screen unless it overlaps with the
#       message window, in which case it goes to the bottom. Default: -1
# :choicehelp_width - This is the width of the choicehelp window. When -1, it 
#       will set it to the width of the longest line, up to a maximum of the 
#       screen width. Default: -1
# :choicehelp_height - This is the height of the choicehelp window. When -1, it
#       is set to accomodate the greatest number of lines that any choice option
#       requires: Default: -1
# :choicehelp_center - Whether or not to centre the text vertically when the 
#       number of lines is smaller than the height of the window. Default: true
# :choicehelp_opacity - This is the opacity of the choicehelp window. 
#       Default: 255
# :choicehelp_backopacity - This is the opacity of the background of the 
#       choicehelp window. Default: 200
# :choicehelp_windowskin - This is the name of the System file to use as the 
#       windowskin for the choicehelp window. Default: "Window"
# :choicehelp_fontcolour - This is the default colour of text in the choicehelp 
#       window. It can either be from the windowskin palette or a 
#       [red, green, blue, alpha] array. Default: 0
# :choicehelp_fontname - This is either a string or array containing the name 
#       of the font used in the choicehelp window. If an array, it will take 
#       the first font in the array that the player has installed. 
#       Default: ["Verdana", "Arial", "Courier New"]
# :choicehelp_fontsize - This is the default size of the font in the choicehelp 
#       window. Default: 20
# :choicehelp_wlh - This is the vertical space required for each line of the 
#       choicehelp window. Default: 24
# :choicehelp_dim - If using :choicehelp_window and dim, the sprite to stretch
#       as a background for the choicehelp branch. Default: "MessageBack"
# :choicehelp_use_dim - The setting for using dim. If 0, it will never use dim.
#       If 1, it will use the dim sprite if :choicehelp_window is true. If 2, 
#       it will use dim only when the message window is also using dim. 
#       Default: 2
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# :name_x - The x coordinate of the name window. When this is -1, the x 
#       coordinate is automatically placed on the same side the face would be 
#       if automatically positioned. Default: -1
# :name_y - The y coordinate of the name window. When this is -1, the y 
#       coordinate is just above the message window, unless it goes off the 
#       screen, in which case it is placed just below. Default: -1
# :name_offset_x - When :name_x is -1, this is added to the x position.
#       Default: 16
# :name_offset_y - When :name_y is -1, this is added to the y position.
#       Default: 16
# :name_opacity - This is the opacity of the name window. Default: 255
# :name_backopacity - This is the opacity of the background of the name window. 
#       Default: 200
# :name_windowskin - This is the name of the System file to use as the 
#       windowskin for the name window. Default: "Window"
# :name_border_size - The size of the windowskin border around the name. 
#       Default: 8
# :name_wlh - This is the vertical space required for each line of the name 
#       window. Default: 24
# :name_fontcolour - This is the default colour of text in the name window. It 
#       can either be from the windowskin palette or a  [red, green, blue] 
#       array. Default: 0
# :name_fontname - This is either a string or array containing the name of the 
#       font used in the name window. If an array, it will take the first font 
#       in the array that the player has installed. 
#       Default: ["Verdana", "Arial", "Courier New"]
# :name_fontsize - This is the default size of the font in the name window.
#       Default: 20
# :name_dim - If using dim, the sprite to stretch as a background for the name 
#       box. Default: "MessageBack"
# :name_use_dim - The setting for using dim. If 0, it will never use dim.
#       If 1, it will use the dim sprite. If 2, it will use dim only when the
#       message window is also using dim. Default: 2
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# :word_x - The x coordinate of the word window. When this is -1, the word 
#       window is centred, or to the left of the gold window if the gold window
#       is visible and :word_y is -1. If not -1, it is directly set to that
#       coordinate. Default: -1
# :word_y - The y coordinate of the word window. When this is -1, the y 
#       coordinate is at the same position as the gold window, unless the gold
#       window is visible and the word window is too wide to fit to the left of
#       it, in which case it is directly above or below the gold window, 
#       depending on where it fits. If not -1, it is directly set to that
#       coordinate. Default: -1
# :word_width - The width of the word window. When -1, it is set to accomodate
#       the longest line. Default: 160
# :word_height - The height of the word window. When -1, it will be set to 
#       accomodate the number of lines. Default: -1
# :word_opacity - This is the opacity of the word window. Default: 255
# :word_backopacity - This is the opacity of the background of the word window. 
#       Default: 200
# :word_windowskin - This is the word of the System file to use as the 
#       windowskin for the word window. Default: "Window"
# :word_wlh - This is the vertical space required for each line of the word 
#       window. Default: 24
# :word_fontcolour - This is the default colour of text in the word window. It 
#       can either be from the windowskin palette or a  [red, green, blue] 
#       array. Default: 0
# :word_fontname - This is either a string or array containing the name of the 
#       font used in the word window. If an array, it will take the first font 
#       in the array that the player has installed. 
#       Default: ["Verdana", "Arial", "Courier New"]
# :word_fontsize - This is the default size of the font in the word window.
#       Default: 20
# :word_dim - If using dim, the sprite to stretch as a background for the word 
#       box. Default: "MessageBack"
# :word_use_dim - The setting for using dim. If 0, it will never use dim.
#       If 1, it will use the dim sprite. If 2, it will use dim only when the
#       message window is also using dim. Default: 2
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#      ~ats_next only codes~
#  The following codes can only be set on a message by message basis with 
# ats_next or $game_message. ats_all and $game_ats does not work for these.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# :do_not_refresh - When this is set to true, the contents of the message 
#       window will not refresh until it is turned off. This means that text
#       messages will be appended to all the previous messages even if there 
#       are other events in between, such as a Show Picture or Control 
#       Variables switch and so on... Note that you will not be able to change
#       the face either without forcibly setting a new page. To turn it off, 
#       you need to use a ats_next (:do_not_refresh, false) right before the 
#       last message that you want appended. I do not recommend doing anything
#       too fancy with this; the idea is to permit you to do small things, like
#       Showing a picture, turning a switch on or off or doing some stuff with
#       conditional branches in between drawing letters. It's not designed or
#       tested for much of anything else.
# :character - This is the same idea as the \oc, \uc, etc... character 
#       positioning codes. This allows you to place it prior to opening the 
#       window however. Set this value to the ID of the character you want to
#       position it in reference to (0 => Player, >1 => Event with that ID.
# :char_ref - This is how you want to place it. 0 => Over; 1 => Left; 
#       2 => Under; 3 => Right; 4 => Over if fits, otherwise under.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# You can set default values for all properties starting at line 766.
#==============================================================================

#==============================================================================
# ** Game_ATS
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  This class holds all of the default data for the ATS
#==============================================================================

class Game_ATS
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  #      EDITABLE REGION
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  MAX_LINES = 4                 # See line 376.
  MESSAGE_SPEED = 0             # See line 378.
  SKIP_DISABLED = false         # See line 380.
  APPEND_TEXT = false            # See line 381.
  APPEND_CHOICE = true          # See line 383.
  SCROLLING = true              # See line 387.
    SCROLL_SPEED = 2            # See line 389.
    SCROLL_SHOW_ARROWS = true   # See line 391.
    SCROLL_AUTOPAUSE = false    # See line 394.
    SCROLL_REVIEW = true        # See line 396.
    SCROLL_BY_PAGE = false      # See line 399.
  PARAGRAPH_FORMAT = true      # See line 400.
    JUSTIFIED_TEXT = false      # See line 403.
  LETTER_SOUND = false          # See line 406.
    LETTER_SE = "Open1", 40     # See line 408.
    LETTERS_PER_SE = 3          # See line 410.
    RANDOM_PITCH = 100..100     # See line 413.
  SPEECH_TAG_INDEX = -1         # See line 418.
  # SPEECH_TAG_GRAPHICS         # See line 422.
    SPEECH_TAG_GRAPHICS = ["Speech Tag 1", "Speech Tag 2", "Thought Tag 1"]
  START_SOUND = false           # See line 426.
    START_SE = "Chime2"         # See line 428.
  FINISH_SOUND = false          # See line 430.
    FINISH_SE = "Chime1"        # See line 432.
  PAUSE_SOUND = false           # See line 434.
    PAUSE_SE = "Decision2"      # See line 436.
  TERMINATE_SOUND = false       # See line 438.
    TERMINATE_SE = "Cancel"     # See line 440.
  MOVE_WHEN_VISIBLE = false     # See line 442.
  GRAPHIC_NOVEL = false         # See line 447.
    HIDE_BUTTON = Input::F5     # See line 452.
    GN_PRESS_OR_TOGGLE = true   # See line 454.
  FILTERS = {                   # See line 457.
    'ATS' => '\c[1]Advanced Text System\c[0], Version 3.0',
    0     => 'Numbered filters work too',
  } 
  FILTERS.default = "" # <- Do not touch
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  MESSAGE_X = -1                # See line 464.
  MESSAGE_Y = -1                # See line 467.
  WLH = 24                      # See line 471.
  BATTLE_WLH = 24               # See line 472.
  DO_NOT_OBSCURE = false        # See line 474.
    OBSCURE_CHARACTERS = [0]    # See line 477.
    OBSCURE_BUFFER = 32         # See line 485.
  FIT_WINDOW_TO_TEXT = false    # See line 488.
  MESSAGE_WIDTH = 544           # See line 491.
  MESSAGE_HEIGHT = 128          # See line 493.
  MESSAGE_OPACITY = 255         # See line 495.
  MESSAGE_BACKOPACITY = 200     # See line 496.
  MESSAGE_WINDOWSKIN = "Window" # See line 498.
  MESSAGE_FONTCOLOUR = 0        # See line 500.
  MESSAGE_FONTNAME = ["Verdana", "Arial", "Courier New"] # See line 503.
  MESSAGE_FONTSIZE = 20         # See line 507.
  MESSAGE_FONTALPHA = 255       # See line 508.
  MESSAGE_DIM = "MessageBack"   # See line 509.
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  FACE_X = -1                   # See line 512.
  FACE_Y = -1                   # See line 515.
  FACE_Z = 10                   # See line 518.
  FACE_SIDE = true              # See line 520.
  FACE_OFFSET_X = 0             # See line 522.
  FACE_OFFSET_Y = 0             # See line 524.
  FACE_WIDTH = 0                # See line 526.
  FACE_HEIGHT = 0               # See line 529.
  FACE_MIRROR = false           # See line 532.
  FACE_OPACITY = 255            # See line 533.
  FACE_BLEND_TYPE = 0           # See line 534.
  FACE_FADEIN = false           # See line 536.
    FACE_FADE_SPEED = 10        # See line 538.
  FACE_SCROLL_X = false         # See line 540.
  FACE_SCROLL_Y = false         # See line 541.
    FACE_SCROLL_SPEED = 12      # See line 542.
  ANIMATE_FACES = true          # See line 544.
    LETTERS_PER_FACE = 6        # See line 545.
  FACE_WINDOW = false           # See line 551.
    FACE_WINDOW_OPACITY = 255   # See line 552.
    FACE_WINDOWSKIN = "Window"  # See line 554.
    FACE_BORDER_SIZE = 6        # See line 556.
    FACE_DIM = "MessageBack"    # See line 558.
    FACE_USE_DIM = 0            # See line 560.
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  CHOICE_TEXT = "    %s"        # See line 564.
  DISABLED_CHOICE_TEXT = "\\FA[128]%s\\FA[255]" # See line 569.
  CHOICEBOX_TEXT = "%s"         # See line 576.
  CHOICE_WINDOW = false         # See line 578.
  CHOICE_X = -1                 # See line 580.
  CHOICE_Y = -1                 # See line 584.
  CHOICE_OFFSET_X = -16         # See line 587.
  CHOICE_OFFSET_Y = 16          # See line 589.
  CHOICE_WIDTH = 192            # See line 591.
  CHOICE_HEIGHT = -1            # See line 594.
  COLUMN_MAX = 1                # See line 596.
  ROW_MAX = 4                   # See line 597.
  CHOICE_SPACING = 20           # See line 598.
  CHOICE_OPACITY = 255          # See line 600.
  CHOICE_BACKOPACITY = 200      # See line 601.
  CHOICE_WINDOWSKIN = "Window"  # See line 603.
  CHOICE_FONTCOLOUR = 0         # See line 605.
  CHOICE_FONTNAME = ["Verdana", "Arial", "Courier New"] # See line 607.
  CHOICE_FONTSIZE = 20          # See line 610.
  CHOICE_WLH = -1               # See line 611.
  CHOICE_DIM = "MessageBack"    # See line 612.
  CHOICE_USE_DIM = 2            # See line 614.
  CHOICE_ON_LINE = false        # See line 617.
  CHOICE_OPPOSITE_FACE = true   # See line 620. 
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  CHOICEHELP_X = -1             # See line 623.
  CHOICEHELP_Y = -1             # See line 625.
  CHOICEHELP_WIDTH = 544        # See line 628.
  CHOICEHELP_HEIGHT = -1        # See line 631.
  CHOICEHELP_CENTER = true      # See line 634.
  CHOICEHELP_OPACITY = 255      # See line 636.
  CHOICEHELP_BACKOPACITY = 200  # See line 638.
  CHOICEHELP_WLH = -1           # See line 640.
  CHOICEHELP_WINDOWSKIN = "Window" # See line 642.
  CHOICEHELP_FONTCOLOUR = 0     # See line 645.
  CHOICEHELP_FONTNAME = ["Verdana", "Arial", "Courier New"] # See line 649.
  CHOICEHELP_FONTSIZE = 20      # See line 651.
  CHOICEHELP_DIM = "MessageBack"# See line 653.
  CHOICEHELP_USE_DIM = 2        # See line 655.
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  NAME_X = -1                   # See line 660.
  NAME_Y = -1                   # See line 663.
  NAME_OFFSET_X = 16            # See line 666.
  NAME_OFFSET_Y = 16            # See line 668.
  NAME_OPACITY = 255            # See line 670.
  NAME_BACKOPACITY = 200        # See line 671.
  NAME_WINDOWSKIN = "Window"    # See line 673.
  NAME_BORDER_SIZE = 8          # See line 675.
  NAME_WLH = -1                 # See line 677.
  NAME_FONTCOLOUR = 0           # See line 679.
  NAME_FONTNAME = ["Verdana", "Arial", "Courier New"] # See line 682.
  NAME_FONTSIZE = 20            # See line 686.
  NAME_DIM = "MessageBack"      # See line 688.
  NAME_USE_DIM = 2              # See line 690.
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  WORD_X = -1                   # See line 694.
  WORD_Y = -1                   # See line 698.
  WORD_WIDTH = 160              # See line 704.
  WORD_HEIGHT = -1              # See line 706.
  WORD_OPACITY = 255            # See line 708.
  WORD_BACKOPACITY = 200        # See line 709.
  WORD_WINDOWSKIN = "Window"    # See line 711.
  WORD_WLH = -1                 # See line 713.
  WORD_FONTCOLOUR = 0           # See line 715.
  WORD_FONTNAME = ["Verdana", "Arial", "Courier New"] # See line 718.
  WORD_FONTSIZE = 20            # See line 722.
  WORD_DIM = "MessageBack"      # See line 724.
  WORD_USE_DIM = 2              # See line 726.
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  #      END EDITABLE REGION
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ATS_2 = false
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Public Instance Variables
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # For each constant, create accessor
  for name in self.class.constants
    # Run the script
    attr_accessor name.downcase.to_sym
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Object Initialization
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def initialize
    reset
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Reset
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def reset
    constants = Game_ATS.constants
    constants.each do |name|
      method_name = "#{name.downcase}="   # Build the setter method name
      value = Game_ATS.const_get(name)    # Get the constant value from Game_ATS
      self.send(method_name.to_sym, value) # Send the method call dynamically
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Set Sound Effect
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def set_sound_effect(settings)
    return settings if settings.is_a?(RPG::SE)

    settings = [settings] if settings.is_a?(String)

    settings[1] = 80 if !settings[1]  # Ensure the second element is set

    return RPG::SE.new(*settings)  # Call RPG::SE.new with the unpacked arguments
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Overwrite SE methods * Thanks Zeriab
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  for method in ["letter", "terminate", "pause", "start", "finish"]
    # Run the script
    eval("def #{method}_se= (*args); @#{method}_se = set_sound_effect (*args); end")
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Set Random Pitch
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def random_pitch= (val)
    @random_pitch = val.is_a? (Integer) ? self.letter_se.pitch..val : val
  end
end

#==============================================================================
# ** Game_Message
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Summary of Changes: 
#    new attr_accessor - all Game_ATS accessors; char_ref; character; 
#      appending_text; choices; disabled_choices; help_choices; skip_choices;
#      override_run
#    aliased methods - initialize; clear; busy
#    new methods - convert_special_characters; perform_substitution; 
#      perform_conversion; play_se; random_pitch=
#==============================================================================

class Game_Message
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Public Instance Variables
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # For each ATS constant, create accessor
  for name in (Game_ATS.constants) do attr_accessor name.downcase.to_sym end
  # Non Game_ATS variables
  attr_accessor :char_ref
  attr_accessor :character
  attr_accessor :appending_text
  attr_accessor :choices
  attr_accessor :disabled_choices
  attr_accessor :skip_choices
  attr_accessor :help_choices
  attr_accessor :override_run
  attr_accessor :highlight
  attr_accessor :underline
  attr_accessor :do_not_refresh
  attr_accessor :do_not_start
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Object Initialization
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias malgb_advtx_inliz_2fk9 initialize unless $@

  def initialize(*args)
    @do_not_refresh = false
    # malg_ats3_clr_msg_9lo1(*args)  # Call your method without a space before `(*args)`
    malgb_advtx_inliz_2fk9(*args)   # Call the original `initialize` method (aliased)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Clear
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias malg_ats3_clr_msg_9lo1 clear unless $@
  def clear (*args)
    @do_not_start = @do_not_refresh
    @texts = []
    @choices = []
    @disabled_choices = []
    @skip_choices = []
    @help_choices = []
    @choice_start = 99
    @choice_max = 0
    @choice_cancel_type = 0
    @choice_proc = nil
    @ignored_codes = []
    return if @do_not_start
    malg_ats3_clr_msg_9lo1 (*args) # Run Original Method
    @alignment = 0
    @appending_text = false
    @character = -1
    @char_ref = 0
    @override_run = false
    @highlight = -1
    @underline = false
    # Set ATS variables
    (Game_ATS.constants).each { |name|
      self.send ("#{name.downcase}=".to_sym, $game_ats.send (name.downcase.to_sym))
    }
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Busy?
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias malbr_busy_ats3_8ik2 busy unless $@
  def busy (*args)
    return false if @appending_text
    return malbr_busy_ats3_8ik2 (*args)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Convert Special Characters
  #    text : the text to convert
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def convert_special_characters (text) 
    return if text == nil
    @ignored_codes.clear
    # Remove Ignore code strings
    text.gsub! (/\\\$(.*?)\/\$/i) { 
      @ignored_codes.push ($1.to_s)
      "\x0a<#{@ignored_codes.size - 1}>"
    }
    # Get substitutions
    text = perform_substitution (text)
    text = perform_conversion (text)
    text.gsub! (/\\\\/)           { "\\" }
    text.gsub! (/\x0a<(\d+)>/) { @ignored_codes[$1.to_i] } # Recover Protected strings
    return text
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Convert Substitution Codes
  #    text : the text to convert
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def perform_substitution (text)
    # Switch conditional text
    text.gsub! (/\\V\[(\d+)\]/i) { $game_variables[$1.to_i] }   # Variable
    text.gsub! (/\\PID\[(\d+)\]/i)  { $game_party.members[($1.to_i % $game_party.members.size)].id } # Party Member X
    text.gsub! (/\\P\[(\d+)\]/i) { $game_party.members[($1.to_i % $game_party.members.size)].id } # Party Member X
    text.gsub! (/\\V\[(\d+)\]/i) { $game_variables[$1.to_i] }   # Variable
    # FILTERS
    text.gsub!(/\\F\[["'](.+?)["']\]/i)  { Game_ATS::FILTERS[$1.to_s] }
    text.gsub!(/\\F\[(.+?)\]/i)    { Game_ATS::FILTERS[$1.to_i] }
    # Party ID to Actor ID
    text.gsub!(/\\N\[([0-9]+)\]/i) { $game_actors[$1.to_i].name rescue ""} # Actor Name
    # New Codes
    text.gsub! (/\\AC\[(\d+)\]/i) { $game_actors[$1.to_i].class.name rescue "" } # Actor Class
    text.gsub! (/\\VOCAB\[(\w+)\]/i) { Vocab.send ($1.downcase) rescue "" }
    # Actor, Item, Weapon, Armor, Skill Stats
    data_arrays = [$game_actors, $data_items, $data_weapons,  $data_armors, 
    $data_skills, $data_states, $data_enemies]
    regexp_array = ["ACTOR_", "I_", "W_", "A_", "S_", "T_", "ENEMY_"]
    for i in 0...regexp_array.size
      regexp = regexp_array[i]
      data = data_arrays[i]
      if i != 0
        text.gsub! (/\\#{regexp}N\[(\d+)\]/i) {
          id = $1.to_i
          data[id].note[/\\MSG\[(.+?)\]MSG\//i].nil? ? data[id].note : $1.to_s.gsub (/\n/) { "" }            # Remove \n 
        }
      end
      # Item Stats
      text.gsub! (/\\#{regexp}([^\[]+?)\[(\d+)\]/i) { |match| data[$2.to_i].send ($1.downcase).to_s rescue match }
    end
    text.gsub! (/\\MAP\[(\d+)\]/i) { (load_data ("Data/MapInfos.rvdata"))[$1.to_i].name rescue "" }
    text.gsub! (/\\MAP/i) { (load_data ("Data/MapInfos.rvdata"))[$game_map.map_id].name rescue "" }
    text.gsub! (/\\NL\[(\d+)\]/i){ $data_system.elements[$1.to_i] rescue "" } 
    text.gsub! (/\\NC\[(\d+)\]/i) { $data_classes[$1.to_i].name rescue "" } # Class Name
    text.gsub! (/\\NE\[(\d+)\]/i) { $game_map.events[$1.to_i].name rescue "" } # Event Name
    text.gsub! (/\\NM\[(\d+)\]/i) { $data_enemies[$1.to_i].name rescue "" } # Monster Name
    text.gsub! (/\\NI\[(\d+)\]/i) { $data_items[$1.to_i].name rescue "" }   # Item Name
    text.gsub! (/\\NW\[(\d+)\]/i) { $data_weapons[$1.to_i].name rescue "" } # Weapon Name
    text.gsub! (/\\NA\[(\d+)\]/i) { $data_armors[$1.to_i].name rescue "" } # Armor Name
    text.gsub! (/\\NS\[(\d+)\]/i) { $data_skills[$1.to_i].name rescue "" } # Skill Name
    text.gsub! (/\\NT\[(\d+)\]/i) { $data_states[$1.to_i].name rescue "" } # State Name
    text.gsub! (/\\NP\[(\d+)\]/i) { $game_party.members[($1.to_i % $game_party.members.size)].name } # Party Name
    text.gsub! (/\\NV\[(\d+)\]/i) { $data_system.variables[$1.to_i] rescue "" } # Variable Name
    text.gsub! (/\\NSW\[(\d+)\]/i){ $data_system.switches[$1.to_i] rescue "" } # Switch Name
    text.gsub! (/\\PI\[(\d+)\]/i) { $data_items[$1.to_i].price.to_s rescue "" } # Item Price
    text.gsub! (/\\PW\[(\d+)\]/i) { $data_weapons[$1.to_i].price.to_s rescue "" } # Weapon Price
    text.gsub! (/\\PA\[(\d+)\]/i) { $data_armors[$1.to_i].price.to_s rescue "" } # Armor Price
    text.gsub! (/\\DI\[(\d+)\]/i) { $data_items[$1.to_i].description rescue "" } # Item Description
    text.gsub! (/\\DW\[(\d+)\]/i) { $data_weapons[$1.to_i].description rescue "" } # Weapon Description
    text.gsub! (/\\DA\[(\d+)\]/i) { $data_armors[$1.to_i].description rescue "" } # Armor Description
    text.gsub! (/\\DS\[(\d+)\]/i) { $data_skills[$1.to_i].description rescue "" } # Skill Description
    text.gsub! (/\\I#\[(\d+)\]/i) { $game_party.item_number ($data_items[$1.to_i]) } # Item Number
    text.gsub! (/\\W#\[(\d+)\]/i) { $game_party.item_number ($data_weapons[$1.to_i]) } # Weapon Number
    text.gsub! (/\\A#\[(\d+)\]/i) { $game_party.item_number ($data_armors[$1.to_i]) } # Armor Number
    text.gsub! (/\\S\!<(\d+),(.+?)>/i) { $game_switches[$1.to_i] ? "" : $2.to_s }
    text.gsub! (/\\S<(\d+),(.+?)>/i)  { $game_switches[$1.to_i] ? $2.to_s : "" }
    text.gsub! (/\\#\{(.+?)\}#/im) { (eval ($1.to_s)).to_s rescue "" }
    return text.sub! (/\\RESUB/i, "") != nil ? perform_substitution (text) : text
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Perform Conversion
  #    text : the text to convert
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def perform_conversion (text)
    text.gsub! (/\\C\[(\d+)\]/i)        { "\x01<#{$1}>" } # Colour
    text.gsub! (/\\C\[#([\dABCDEF]{6,6})\]/i) { "\x01<##{$1}>"} # Colour Hex
    text.gsub! (/\\G/i)                 { "\x02" }        # Gold Window
    text.gsub! (/\\\./)                 { "\x03<15>" }    # Wait 15 frames
    text.gsub! (/\\\|/)                 { "\x03<60>" }    # Wait 60 frames
    text.gsub! (/\\W\[(\d+)\]/i)        { "\x03<#{$1}>" } # Wait x frames
    text.gsub! (/\\!/)                  { "\x04" }        # Wait for Input
    text.gsub! (/\\@@/)                 { "\x05<0>" }     # Show Fast ON
    text.gsub! (/\/@@/)                 { "\x05<1>" }     # Show Fast OFF
    text.gsub! (/\\@/)                  { "\x06<0>" }     # Show Line Fast ON
    text.gsub! (/\/@/)                  { "\x06<1>" }     # Show Line Fast OFF
    text.gsub! (/\\\^/)                 { "\x07" }        # Skip Pause
    text.gsub! (/\\>/)                  { "\x08<-1>" }     # Message speed- 1
    text.gsub! (/\\</)                  { "\x08<1>" }    # Message speed + 1
    text.gsub! (/\\[Ss]\[(=?-?\d+)\]/i) { "\x08<#{$1}>" } # Message speed + x
    text.gsub! (/\\%/)                  { "\xb0<0>" }     # Enable Skip
    text.gsub! (/\/%/)                  { "\xb0<1>" }     # Disable Skip
    # Animation and Balloons
    text.gsub! (/\\ANI\[(\d+),\s*(\d+)\]/i) { "\x0b<#{$1},#{$2},0>" } # Animation
    text.gsub! (/\\BLN\[(\d+),\s*(\d+)\]/i) { "\x0b<#{$1},#{$2},1>" } # Balloon
    # Position to Character
    text.gsub! (/\\OC\[(\d+)\]/i)     { "\x0c<#{$1},0>" } # Over Character
    text.gsub! (/\\LC\[(\d+)\]/i)     { "\x0c<#{$1},1>" } # Left of Character
    text.gsub! (/\\UC\[(\d+)\]/i)     { "\x0c<#{$1},2>" } # Under Character
    text.gsub! (/\\RC\[(\d+)\]/i)     { "\x0c<#{$1},3>" } # Right of Character
    text.gsub! (/\\E\[(\d+)\]/i)      { "\x0c<#{$1},4>" } # Under if over doesn't work
    text.gsub! (/\\SE\[(.+?)\]/i)    { "\x1b<#{$1},SE>" } # Play Sound Effect
    text.gsub! (/\\ME\[(.+?)\]/i)    { "\x1b<#{$1},ME>" } # Play Musical Effect
    # Show Icons
    text.gsub! (/\\IC?O?N?\[(\d+)\]/i)  { "\x0d<#{$1}>" } # Show Icon X
    text.gsub! (/\\IIC?O?N?\[(\d+)\]/i) { "\x0d<#{$data_items[$1.to_i].icon_index}>" rescue "" } # Item Icon
    text.gsub! (/\\WIC?O?N?\[(\d+)\]/i) { "\x0d<#{$data_weapons[$1.to_i].icon_index}>" rescue "" } # Weapon Icon
    text.gsub! (/\\AIC?O?N?\[(\d+)\]/i) { "\x0d<#{$data_armors[$1.to_i].icon_index}>" rescue "" } # Armor Icon
    text.gsub! (/\\SIC?O?N?\[(\d+)\]/i) { "\x0d<#{$data_skills[$1.to_i].icon_index}>" rescue "" }
    text.gsub! (/\\TIC?O?N?\[(\d+)\]/i) { "\x0d<#{$data_states[$1.to_i].icon_index}>" rescue "" }
    text.gsub! (/\\[Bb]/)               { "\x0e<0>" }     # Bold ON
    text.gsub! (/\/[Bb]/)               { "\x0e<1>" }     # Bold OFF
    text.gsub! (/\\[Ii]/)               { "\x0f<0>" }     # Italics ON
    text.gsub! (/\/[Ii]/)               { "\x0f<1>" }     # Italics OFF
    text.gsub! (/\\[Ss]/)               { "\x10<0>" }     # Shadow ON
    text.gsub! (/\/[Ss]/)               { "\x10<1>" }     # Shadow OFF
    text.gsub! (/\\[Uu]/)               { "\x11<0>" }     # Underline ON
    text.gsub! (/\/[Uu]/)               { "\x11<1>" }     # Underline OFF
    text.gsub! (/\\HL\[(-?\d+)\]/i)     { "\x12<#{$1}>" } # Higlight X 
    text.gsub! (/\/HL/i)                { "\x12<-1>" }    # Highlight OFF
    text.gsub! (/\\FN\[(.+?)\]/i)       { "\x13<#{$1}>" } # Font Name
    text.gsub! (/\\FS\[(\d+)\]/i)       { "\x14<#{$1}>" } # Font Size
    text.gsub! (/\\FA\[(\d+)\]/i)       { "\x15<#{$1}>" } # Font Alpha
    text.gsub! (/\\LB/i)                { "\x16" }        # Force Line Break
    text.gsub! (/\\AF\[(\d+)\]/i)  { "\x17<#{$1.to_s}>" } # Use Actor Face
    text.gsub! (/\\LEFT/i)              { "\x18<0>" }     # Align Left
    text.gsub! (/\\L/i)                 { "\x18<0>" }     # Align Left
    text.gsub! (/\\CENTRE/i)            { "\x18<1>" }     # Align Centre
    text.gsub! (/\\CE?NTE?R/i)          { "\x18<1>" }     # Align Centre
    text.gsub! (/\\C/i)                 { "\x18<1>" }     # Align Centre
    text.gsub! (/\\RI?GHT/i)            { "\x18<2>" }     # Align Right
    text.gsub! (/\\R/i)                 { "\x18<2>" }     # Align Right
    text.gsub! (/\\PB/i)                { "\x1d" }        # Force Page Break
    text.gsub! (/(\x1d\s*)\x00/i)       { $1.to_s }       # If force page, remove x00 code
    text.gsub! (/\\T/i)                 { "\x09" }        # Tab
    text.gsub! (/\\X\[(\d+)\]/i)        { "\xb1<#{$1}>" } # Content X
    # Position Direct Setting
    text.gsub! (/\\[PM]XY\[(-?\d+),\s*(-?\d+)\]/im) { "\x1f<0,#{$1.to_s},#{$2.to_s}>" }
    # Face Direct Setting
    text.gsub! (/\\FXY\[(-?\d+),\s*(-?\d+)\]/im) { "\x1f<1,#{$1.to_s},#{$2.to_s}>" }
    # Name Direct Setting
    text.gsub! (/\\NXY\[(-?\d+),\s*(-?\d+)\]/im) { "\x1f<2,#{$1.to_s},#{$2.to_s}>" }
    text.gsub! (/\\#\!\{(.+?)\}#/im)    { "\x7f{#{$1}#}" }
    text.gsub! (/\\NB\[(.*?)\]/im)      { "\x19{#{$1}}" } # Name Window
    text.gsub! (/\/NB/i)                { "\x19{}"}
    text.gsub! (/\\NAME\[(.*?)\]/im)    { "\x19{#{$1}}" } # Name Window
    text.gsub! (/\\WB\[(.*?)\]/im)      { "\x1a{#{$1}}" } # Word Box
    text.gsub! (/\/WB/i)                { "\x1a{}" }
    return text
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Play SE
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def play_se (se)
    # Avoid FileErrors
    begin 
      se.play 
    rescue 
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Set Choice Texts
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def choice_text= (string)
    if string.is_a? (String)
      @choice_text = convert_special_characters (string)
      @choice_text += "%s" if @choice_text[/%s/] == nil
    else
      @choice_text = "%s"
    end
  end
  def choicebox_text= (string)
    if string.is_a? (String)
      @choicebox_text = convert_special_characters (string)
      @choicebox_text += "%s" if @choicebox_text[/%s/] == nil
    else
      @choicebox_text = "%s"
    end
  end
  def disabled_choice_text= (string)
    @disabled_choice_text = string.is_a? (String) ? convert_special_characters (string) : "%s"
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Set Random Pitch
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def random_pitch= (val)
    @random_pitch = val.is_a? (Integer) ? self.letter_se.pitch..val : val
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Overwrite SE methods * Thanks Zeriab
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  for method in ["letter", "terminate", "pause", "start", "finish"]
    # Run the script
    eval("def #{method}_se= (*args); @#{method}_se = $game_ats.set_sound_effect (*args); end")
  end
end 

#==============================================================================
# ** Game_Event
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Summary of Changes:
#    new method - name
#==============================================================================

class Game_Event
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Name
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def name
    return @event.name
  end
end

#==============================================================================
# ** Game_Player
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Summary of Changes:
#    aliased methods - movable?; move_by_input
#==============================================================================

class Game_Player
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Move By Input
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias mabr_adtxs3_inpmv_6yw2 move_by_input unless $@
  def move_by_input (*args)
    $game_message.override_run = $game_message.move_when_visible
    mabr_adtxs3_inpmv_6yw2 (*args) # Run Original Method
    $game_message.override_run = false
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Check if Player can Move
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias malg_advtxt3_movble_5sa2 movable? unless $@
  def movable? (*args)
    true_visible = $game_message.visible
    $game_message.visible = false if $game_message.move_when_visible
    check = malg_advtxt3_movble_5sa2 (*args) # Run Original Method
    $game_message.visible = true_visible
    return check
  end
end

#==============================================================================
# ** Game_Interpreter
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Summary of Changes:
#    overwritten methods - command_403; setup_choices; setup_num_input
#    aliased methods - command_101; command_102; running?
#    new methods - interpret_choices; choice_plus; choice_switch; choice_help;
#      ats_next; ats_all
#==============================================================================

class Game_Interpreter
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Show Message
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias modalg_ats_apnd_txt_show_94b command_101 unless $@
  def command_101 (*args)
    value = modalg_ats_apnd_txt_show_94b (*args)
    if $game_message.append_text && @list[@index].code == 101 && @list[@index].parameters == @params
      $game_message.appending_text = true
      value = command_101 (*args)
      $game_message.appending_text = false
    end
    return value
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Show Choices
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias malgr_ats3_shwchc_4ac2 command_102 unless $@
  def command_102 (*args)
    if @list[@index].indent > 1000
      @list[@index - 1].indent -= 1000
      @list[@index].indent -= 1000
      return command_skip
    else
      return malgr_ats3_shwchc_4ac2 (*args) # Run Original Method
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * When [Cancel]
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def command_403
    if @branch[@indent] == 999              # If canceling choice
      @branch.delete(@indent)               # Erase branching data
      return true                           # Continue
    else                                    # If doesn't match condition
      return command_skip                   # Command skip
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Setup Choices
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def setup_choices (params)
    params = interpret_choices (Marshal.load (Marshal.dump (params))) 
    $game_message.choice_start = $game_message.texts.size
    $game_message.choice_max = params[0].size
    for s in params[0]
      $game_message.choices.push(s)
    end
    $game_message.texts.push ("\x1c") if $game_message.texts.empty?
    $game_message.choice_cancel_type = params[1]
    $game_message.choice_proc = Proc.new { |n| @branch[@indent] = n }
    @index += 1
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Number Input Setup
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def setup_num_input(params)
    if $game_message.texts.size < $game_message.max_lines || $game_message.scrolling
      $game_message.num_input_variable_id = params[0]
      $game_message.num_input_digits_max = params[1]
      @index += 1
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Interpret Choices
  #    params : the parameters of the initial 102 command.
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def interpret_choices (params)
    # Collect all next choices as well. 
    ind = @index + 1
    choice_id = 0
    params[1] = 1000 if params[1] == 5
    choice_text = $game_message.choice_window ? $game_message.choicebox_text : $game_message.choice_text
    loop do
      # Advance to next choice code
      while (@list[ind].indent % 1000) > @indent 
        ind += 1                           # Advance index
      end
      case @list[ind].code
      when 402
        choice_s = @list[ind].parameters[1].dup
        ind += 1
        # Choice+ processing.
        choice_s, ind = choice_plus (choice_s, ind)
        # SOFF and SON processing
        choice_s, delete, disable = choice_switch (choice_s)
        choice_s, help = choice_help (choice_s)
        if delete || choice_s.empty?
          @list[ind - 1].parameters[0] = -1
          params[0].delete_at (choice_id)
        else
          $game_message.help_choices[choice_id] = help
          choice_s = sprintf (choice_text, choice_s)
          if disable
            choice_s = sprintf ($game_message.disabled_choice_text, choice_s)
            $game_message.disabled_choices.push (choice_id)
          end
          # Choice Skip?
          choice_s.gsub! (/\x1e/i) { $game_message.skip_choices.push (choice_id); "" }
          @list[ind - 1].parameters[0] = choice_id
          params[0][choice_id] = choice_s
          choice_id += 1
        end
      when 403
        ind += 1
      when 404
        if !$game_message.append_choice || @list[ind + 1].code != 102
          @index = ind if $game_message.skip_choices.size == params.size
          $game_message.help_choices.clear if $game_message.help_choices.uniq.size == 1 && $game_message.help_choices[0].empty?
          break
        end
        p2 = @list[ind + 1].parameters.dup
        @list[ind].indent += 1000 if @list[ind].indent < 1000
        @list[ind + 1].indent += 1000 if @list[ind + 1].indent < 1000
        params[1] = p2[1] == 5 ? 1000 : p2[1] == 0 ? params[1] : params[0].size + p2[1]
        params[0].push (*p2[0])
        ind += 2
      else
        break
      end
    end
    return params
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Running?
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias modral_atsys3_runn_5tg3 running? unless $@
  def running? (*args)
    return false if $game_message.override_run
    return modral_atsys3_runn_5tg3 (*args) 
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Choice + Processing
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def choice_plus (choice_s, ind)
    # Choice + Processing
    if @list[ind].code == 108 # Comment
      string = @list[ind].parameters[0].dup
      ind2 = ind + 1
      while @list[ind2].code == 408
        string += @list[ind2].parameters[0]
        ind2 += 1
      end
      string.gsub (/\\\+{(.+?)}/im) { choice_s += $1.to_s; "" }
      choice_s.gsub! (/\n/)                   { "" }            # Remove \n 
    end
    return choice_s, ind
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Choice Switch
  #    s : the choice string
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def choice_switch (s)
    del = false
    dis = false
    s.gsub! (/\\SOFF\[(\d+)\]/i) { del = true if $game_switches[$1.to_i]; "" }
    s.gsub! (/\\SON\[(\d+)\]/i) { del = true if !$game_switches[$1.to_i]; "" }         
    if !del
      s.gsub! (/\\D\[(\d+)\]/i) { dis = true if !$game_switches[$1.to_i]; "" }
      s.gsub! (/\\D!\[(\d+)\]/i) { dis = true if $game_switches[$1.to_i]; "" }
      s.gsub! (/\\SKIP/i) { "\x1e" }
      s.gsub! (/\\PB/i) { "" } # Delete any page breaks.
      $game_message.convert_special_characters (s)
      s.gsub! (/\x16/) { "\x00" }        # Force Line Break
    end
    return s, del, dis
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Choice Help
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def choice_help (choice_s)
    help_text = ""
    choice_s.gsub! (/\x1a{(.+?)}/im) { help_text += $1.to_s; "" }
    return choice_s, help_text
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Change ATS parameter for next message
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def ats_next (parameter, *args)
    $game_message.send ("#{parameter}=".to_sym, *args) unless args.empty?
    return $game_message.send (parameter)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Change ATS
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def ats_all (parameter, *args)
    $game_ats.send ("#{parameter}=".to_sym, *args) unless args.empty?
    $game_message.send ("#{parameter}=".to_sym, *args) unless args.empty?
    return $game_message.send (parameter)
  end
end

#==============================================================================
# ** P_Formatter_ATS
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  A special formatter class designed to accomodate ATS message codes
#==============================================================================

class P_Formatter_ATS
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Public Instance Variables
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  attr_accessor :bitmap
  attr_reader   :force_break
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Object Initialization
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def initialize (font = nil)
    @bitmap = Bitmap.new (1, 1)
    @bitmap.font = font if font
    @curly_args_codes = ["\x19", "\x1a", "\x7f"]
    @args_codes = ["\x01", "\x03", "\x05", "\x06", "\x08", "\x0b", 
      "\x0c", "\x0d", "\x0e", "\x0f", "\x10", "\x11", "\x12", "\x13", "\x14", 
      "\x15", "\x17", "\x18", "\x1b", "\x1f", "\xb0", "\xb1"]
    @no_args_codes = ["\x00", "\x02", "\x04", "\x07", "\x09", "\x16", "\x1c", 
      "\x1d", "\x1e"]
    @force_break = false
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Dispose Bitmap
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def dispose
    @bitmap.dispose unless @bitmap.nil? || @bitmap.disposed?
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Format By Line
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def format_by_line (string, width)
    @string = string
    @max_width = width
    @justify = $game_message.justified_text
    return 0, 0, @justify if string.empty?
    @line_width = 0
    @word_length = 0
    @w_draw_count = 0
    @l_draw_count = 0
    @curly_argument = 0
    @code_argument = 0
    # Set up
    @line_space = 0
    @last_word = 0
    @break_loop = false
    @last_space_counted = false
    @force_break = false
    i = 0
    while !@break_loop
      if i >= @string.size
        if @l_draw_count != 0
          @l_draw_count += 1 
          @line_width += @bitmap.text_size (" ").width
        end
        @l_draw_count += @w_draw_count
        @line_width += @word_length
        next_line (i)
      else
        format_character (i)
        i += 1
      end
    end
    return @line_space, @l_draw_count, @justify
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Format Character
  #    i : index of character to format, or the character
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def format_character (i)
    character = @string[i, 1]
    if @curly_argument > 0
      @curly_argument -= 1 if character == "}"
    elsif @code_argument > 0
      @code_argument -= 1 if character == ">"
    elsif @curly_args_codes.include? (character)
      extract_curly_args_code (character, i)
    elsif @args_codes.include? (character)
      extract_args_code (character, i)
    elsif @no_args_codes.include? (character)
      extract_no_args_code (character, i)
    elsif character == " "
      next_word (i)
      return if @break_loop
      @line_width += @bitmap.text_size (" ").width
      @l_draw_count += 1
      @last_space_counted = true
    else # Regular Character
      @word_length += @bitmap.text_size(character).width
      @w_draw_count += 1
      if i == @string.size - 1 && @line_width + @word_length > @max_width
        next_line (@last_word) 
      end
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Next Word
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def next_word (i)
    if @line_width + @word_length > @max_width
      if @line_width == 0
        @last_word = i
        @line_width = @word_length
        @l_draw_count = @w_draw_count
        @word_length = 0
        @w_draw_count = 0
      end
      next_line (@last_word)
    end
    @last_word = i
    @line_width += @word_length
    @l_draw_count += @w_draw_count
    @word_length = 0
    @w_draw_count = 0
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Proceed to Next Line
  #    last_word : the index of the beginning of the previous word
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def next_line (last_word)
    @justify = false if last_word == @string.size
    @string[last_word, 1] = "\x00"
    if @last_space_counted
      @line_width -= @bitmap.text_size (" ").width
      @l_draw_count -= 1
    end
    # Calculates the blank space left to cover in the line
    line_blank = @max_width - @line_width
    @line_space = ( line_blank.to_f / [(@l_draw_count.to_f - 1.0), 1.0].max )
    @break_loop = true
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Extract Curly Argument Code
  #    code : the code to extract
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def extract_curly_args_code (code, index)
    @curly_argument += 1
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Extract Argument Code
  #    code : the code to extract
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def extract_args_code (code, index)
    case code
    when "\x0d" # Icon
      @w_draw_count += 1
      @word_length += 24
    when "\x0e" # Bold
      @bitmap.font.bold = (@string[index + 2, 1].to_i == 0)    
    when "\x0f" # Italic
      @bitmap.font.italic = (@string[index + 2, 1].to_i == 0)   
    when "\x10" # Shadow
      @bitmap.font.shadow = (@string[index + 2, 1].to_i == 0)
    when "\x13" # Font Name
      bmp = @bitmap
      bmp.font.name = bmp.font.name.to_ary if !bmp.font.name.is_a? (Array)
      @string[index, @string.size - index][/<(.*?)>/]
      bmp.font.name = ([$1.to_s] + bmp.font.name).uniq
    when "\x14" # Font Size
      @string[index, @string.size - index][/<(\d*)>/]
      @bitmap.font.size = $1.to_i
    when "\xb1" # Set Contents_X
      @string[index, @string.size - index][/<(\d*)>/]
      @word_length = $1.to_i
    end
    @code_argument += 1
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Extract No Argument Code
  #    code : the code to extract
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def extract_no_args_code (code, index)
    if ["\x00", "\x1d"].include? (code) # New line or New Page
      if @line_width + @word_length > @max_width
        next_line (@last_word) 
      else
        @line_width += @word_length
        @l_draw_count += @w_draw_count
        line_blank = @max_width - @line_width
        @line_space = ( line_blank.to_f / [(@l_draw_count.to_f - 1.0), 1.0].max )
        @break_loop = true
        @justify = false
        @force_break = true
      end
    elsif code == "\x09" # Tab
      next_word (index)
      @line_width = $game_message.justified_text ? @line_width + 32 :((@line_width / 32) + 1)*32
    end
  end
end

#==============================================================================
# ** Sprite MessageFace
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  This sprite displays face graphics
#==============================================================================

class Sprite_MessageFace < Sprite_Base
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Object Initialization
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def initialize (face_file, face_index, viewport = nil) 
    super (viewport)
    wdth, hght = $game_message.face_width, $game_message.face_height
    face = Cache.face (face_file)
    if face_file[/^\$/] != nil # SINGLE
      wdth = face.width if wdth <= 0
      wdth = [face.width, wdth].min
      hght = face.height if hght <= 0
      hght = [face.height, hght].min
      rect = Rect.new((face.width-wdth) / 2, (face.height-hght) / 2, wdth, hght)
    else
      # Resize if face smaller than allotted size
      wdth = face.width / 4 if wdth <= 0
      wdth = [face.width / 4, wdth].min
      hght = face.height / 2 if hght <= 0
      hght = [face.height / 2, hght].min
      rect = Rect.new(0, 0, wdth, hght)
      rect.x = (face_index % 4) * wdth + ((face.width / 4) - wdth) / 2
      rect.y = (face_index / 4) * hght + ((face.height / 2) - hght) / 2
    end
    self.bitmap = Bitmap.new (rect.width, rect.height)
    self.bitmap.blt(0, 0, face, rect)
    self.mirror = $game_message.face_mirror
    self.blend_type = $game_message.face_blend_type
    self.visible = false
    self.opacity = $game_message.face_fadein ? 0 : $game_message.face_opacity
    $game_message.face_width, $game_message.face_height = rect.width, rect.height
  end
end

#==============================================================================
# ** Sprite SpeechTag
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  This sprite displays the tag when speaking
#==============================================================================

class Sprite_SpeechTag < Sprite
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Public Instance Variable
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  attr_reader :speech_tag_index
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Object Initialization
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def initialize (viewport = nil, *args)
    @border_sprite = Sprite.new (viewport)
    super (viewport, *args)
    @border_sprite.z = self.z + 1
    @bitmaps = []
    reset_graphic
    self.visible = false
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Dispose
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def dispose (*args)
    if self.bitmap
      self.bitmap.dispose 
      @border_sprite.bitmap.dispose
    end
    @border_sprite.dispose
    super (*args)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Reset Graphic
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def reset_graphic (index = $game_message.speech_tag_index)
    return if @speech_tag_index == index
    @speech_tag_index = index
    return if index < 0
    begin
      bitmap = Cache.system ($game_message.speech_tag_graphics[index])
    rescue
      return
    end
    @bitmaps.each { |bmp| bmp.dispose unless bmp.disposed? }
    @bitmaps.clear
    dummy_bmp = Bitmap.new (bitmap.width / 2, bitmap.height / 2)
    src_rect = Rect.new (0, 0, bitmap.width / 2, bitmap.height / 2)
    for i in 0...4
      new_bmp = dummy_bmp.dup
      src_rect.x, src_rect.y = (i % 2)*new_bmp.width, (i / 2)*new_bmp.height
      new_bmp.blt (0, 0, bitmap, src_rect)
      @bitmaps.push (new_bmp)
    end
    dummy_bmp.dispose
    self.bitmap = @bitmaps[0]
    @border_sprite.bitmap = @bitmaps[1]
    self.back_opacity = $game_message.message_backopacity
    self.opacity = $game_message.message_opacity
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Set Direction
  #    dir : 0 => Down; 2 => Up
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def set_direction (dir)
    self.bitmap = @bitmaps[dir]
    @border_sprite.bitmap = @bitmaps[dir + 1]
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Set Back Opacity
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias back_opacity= opacity= unless self.method_defined? (:back_opacity=) unless $@
  def opacity= (value)
    self.back_opacity = (self.opacity*(value.to_f / 255.0)).to_i
    @border_sprite.opacity = value
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Visible
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def visible= (boolean)
    super (boolean)
    @border_sprite.visible = boolean
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * X=, Y=, Z=, Angle
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  for attr in ["x", "y", "z", "angle"]
    ATS_ATTR = <<_END_
      def #{attr}= (*args)
        old_val = self.#{attr}
        super (*args)
        diff = self.#{attr} - old_val
        @border_sprite.#{attr} += diff
      end
_END_
    eval (ATS_ATTR)
  end
end

#==============================================================================
# *** Window_MessageBase
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  This module holds methods shared by all ATS windows
#==============================================================================

module Window_MessageBase
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Message Draw Icon
  #    allows for different opacities
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def message_draw_icon (icon_index, x, y, o = $game_message.message_fontalpha)
    bitmap = Cache.system("Iconset")
    rect = Rect.new(icon_index % 16 * 24, icon_index / 16 * 24, 24, 24)
    self.contents.blt(x, y, bitmap, rect, o)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Text Color
  #    n : either a windowskin palette or the array
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def text_color (n)
    if n.is_a? (Array)
      return Color.new (*n)
    else
      return super (n)
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Set Alignment
  #    align : The alignment ( 1 => Centre, 2 => Right )
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def set_alignment (align = 1)
    # Get rest of line
    formatter = P_Formatter_ATS.new (self.contents.font.dup)
    ls, lc, j = formatter.format_by_line (@text.dup, @contents_width - @contents_x)
    formatter.dispose
    es = ls * (lc - 1)
    @contents_x += (es / 2)*align
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Draw Message Character
  #    c : the character to be drawn
  #``````````````````````````````````````````````````````````````````````````
  #  This method utilizes the codes shared between the MessageBox, WordBox,
  # and ChoiceBox
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def draw_message_character (c, bmp = self.contents)
    @text = "" if @text.nil?
    case c
    when "\x01"                       # \C[n] (text character color change)
      @text.sub! (/<(#?)(.+?)>/i, "")
      if $1 == ""
        bmp.font.color = text_color($2.to_i)
        if $game_message.message_fontalpha != 255
          bmp.font.color.alpha = $game_message.message_fontalpha
        end
      else
        a = $2.to_s.scan (/../)
        bmp.font.color = text_color ([a[0].to_i (16), a[1].to_i (16), a[2].to_i (16), $game_message.message_fontalpha])
      end
    when "\x09"                       # Tab
      x = @line_x + (((@contents_x - @line_x).to_i / 32) + 1)*32
      highlight_underline (x - @contents_x)
      @contents_x = x
    when "\xb1"                        # Set Contents X
      @text.sub! (/<(\d*)>/, "")
      @contents_x = $1.to_i
      return false if self.is_a? (Window_Message)
    when "\x0d"                       # Icon
      @text.sub!(/<(\d*)>/, "")
      highlight_underline (24)
      message_draw_icon ($1.to_i, @contents_x, @contents_y)
      @contents_x += 24
      @contents_x += @ls if self.is_a? (Window_Message)
    when "\x0e"                       # Bold
      @text.sub!(/<([01])>/, "")
      bmp.font.bold = (Game_ATS::ATS_2 && $1.to_i == 0) ? !bmp.font.bold : $1.to_i == 0
    when "\x0f"                       # Italics
      @text.sub!(/<([01])>/, "")
      bmp.font.italic = (Game_ATS::ATS_2 && $1.to_i == 0) ? !bmp.font.italic : $1.to_i == 0
    when "\x10"                       # Shadow
      @text.sub!(/<([01])>/, "")
      bmp.font.shadow = (Game_ATS::ATS_2 && $1.to_i == 0) ? !bmp.font.shadow : $1.to_i == 0
    when "\x11"                        # Underline
      @text.sub!(/<([01])>/, "")
      @underline = (Game_ATS::ATS_2 && $1.to_i == 0) ? !@underline : $1.to_i == 0
    when "\x12"                        # Highlight
      @text.sub! (/<(-?\d+)>/, "")
      @highlight = $1.to_i
    when "\x13"                       # Font Name
      bmp.font.name = bmp.font.name.to_ary if !bmp.font.name.is_a? (Array)
      @text.sub!(/<(.*?)>/, "")
      bmp.font.name = ([$1.to_s] + bmp.font.name).uniq
    when "\x14"                       # Font Size
      @text.sub!(/<(\d*)>/, "")
      bmp.font.size = $1.to_i
    when "\x15"                       # Font Alpha
      @text.sub! (/<(\d*)>/, "")
      $game_message.message_fontalpha = $1.to_i
      bmp.font.color.alpha = $game_message.message_fontalpha
    when "\x18"                       # Alignment
      @text.sub! (/<([012])>/, "")
      return true if @align == $1.to_i
      @align = $1.to_i
      set_alignment (@align)
    else
      return false    
    end
    return true
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Draw Regular Character
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def draw_regular_character (c, bmp = self.contents)
    c_width = bmp.text_size(c).width
    c_width += @ls if !@ls.nil?
    highlight_underline (c_width)
    bmp.draw_text(@contents_x, @contents_y, c_width + 4, @wlh, c)
    @contents_x += c_width
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Highlight and Underline section
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def highlight_underline (c_width)
    # Highlight
    if @highlight >=0 
      hl_rect = Rect.new (@contents_x, @contents_y + 1, c_width, @wlh - 2)
      colour = text_color (@highlight)
      colour.alpha = 128 if colour.alpha > 128
      contents.fill_rect (hl_rect, colour)
    end
    # Underline
    if @underline
      y = @contents_y + contents.font.size + (@wlh - contents.font.size) / 2
      contents.fill_rect (@contents_x, y, c_width, 2, contents.font.color)
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Create Background Sprite
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def create_back_sprite (dim, use_dim)
    @back_sprite.viewport = self.viewport
    bmp = Cache.system(dim)
    @back_sprite.bitmap = Bitmap.new (self.width, self.height)
    @back_sprite.bitmap.stretch_blt (@back_sprite.bitmap.rect, bmp, bmp.rect)
    if use_dim.is_a? (Integer)
      @back_sprite.visible = use_dim == 0 ? false : use_dim == 1 ? true : $game_message.background == 1
    else
      @back_sprite.visible = use_dim
    end
    @back_sprite.x = self.x
    @back_sprite.y = self.y
    @back_sprite.z = self.z - 10
    self.opacity = 0 if @back_sprite.visible
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * X, Y, Z
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  for attr in ["x", "y", "z"]
    ATS_NAMATTR = <<__END__
      def #{attr}= (*args)
        old_val = self.#{attr}
        super (*args)
        diff = self.#{attr} - old_val
        @back_sprite.#{attr} += diff
      end
__END__
    eval (ATS_NAMATTR)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Get Top Row
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def top_row
    return super if !@wlh
    return self.oy / @wlh
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Set Top Row
  #     row : row shown on top
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def top_row=(row)
    if !@wlh
      super (row)
    else
      row = 0 if row < 0
      self.oy = row * @wlh
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Get Number of Rows Displayable on 1 Page
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def page_row_max
    return super if !@wlh
    return (self.height - 32) / @wlh
  end
end

#==============================================================================
# ** Window_WordBox
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  This window will show a single line of text
#==============================================================================

class Window_WordBox < Window_Base
  include Window_MessageBase
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Object Initialization
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def initialize (viewport, word, x = 0, y = 0, width = -1, height = 56, name = false)
    @back_sprite = Sprite.new (viewport)
    @text = $game_message.convert_special_characters (word)
    @wlh = name ? $game_message.name_wlh : $game_message.word_wlh
    @wlh = $game_message.wlh if @wlh < 0
    height = 32 + (((word.scan (/\x00/).size) + 1)*@wlh) if height == -1
    @underline = false
    @highlight = -1
    # Get Text Size
    dummy_formatter = P_Formatter_ATS.new 
    lines = (@text + "\x00").scan (/.+?\x00/)
    tw = 32
    for line in lines
      ls, lc, j = dummy_formatter.format_by_line (line, 5000)
      tw1 = 5000 - (ls * (lc - 1))
      tw = tw1 if tw1 > tw
    end
    dummy_formatter.dispose
    if width < 0
      width = [(name ? tw + ($game_message.name_border_size*2) + 4 : tw + 36), 33].max
    end
    super (x, y, width, height)
    self.viewport = viewport
    self.openness = 0
    self.z = 300
    set_stats
    @contents_x, @line_x = 0, 0
    @contents_y = 0
    @contents_width = contents.width
    @align = 0
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Set Stats
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def set_stats
    self.windowskin = Cache.system ($game_message.word_windowskin)
    self.opacity = $game_message.word_opacity
    self.back_opacity = $game_message.word_backopacity
    create_back_sprite ($game_message.word_dim, $game_message.word_use_dim)
    self.contents.font.name = $game_message.word_fontname
    self.contents.font.size = $game_message.word_fontsize
    self.contents.font.color = text_color ($game_message.word_fontcolour)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Dispose
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def dispose (*args)
    @back_sprite.bitmap.dispose
    @back_sprite.dispose
    super (*args)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Draw Word
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def draw_word (text = @text, bmp = self.contents)
    @text = text.dup
    loop do
      c = @text.slice!(/./m)            # Get next text character
      # Stop when text finished
      break if c.nil?     
      if !draw_message_character (c, bmp)
        if c == "\x00"
          @contents_y += @wlh
          @contents_x, @line_x = 0, 0
          set_alignment (@align)
        else
          draw_regular_character (c, bmp)
        end
      end
    end
  end
end

#==============================================================================
# ** Window_NameBox
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  This window shows the name
#==============================================================================

class Window_NameBox < Window_WordBox
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Object Initialization
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def initialize (name, viewport = nil)
    @word_sprite = Sprite_Base.new (viewport)
    wlh = $game_message.name_wlh > 0 ? $game_message.name_wlh : $game_message.wlh
    rows = (name.scan (/\x00/).size) + 1
    hght = [($game_message.name_border_size*2) + rows*wlh, 33].max
    super (viewport, name, 0, 0, -1, hght, true)
    self.viewport = viewport
    @word_sprite.x, @word_sprite.y = $game_message.name_border_size, $game_message.name_border_size
    @word_sprite.bitmap = Bitmap.new (self.width - (2*$game_message.name_border_size), self.height - (2*$game_message.name_border_size))
    @word_sprite.bitmap.font.name = $game_message.name_fontname
    @word_sprite.bitmap.font.size = $game_message.name_fontsize
    @word_sprite.bitmap.font.color = text_color ($game_message.name_fontcolour)
    @contents_x, @line_x = 2, 2
    draw_word (name, @word_sprite.bitmap)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Set Stats
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def set_stats
    self.opacity = $game_message.name_opacity
    self.back_opacity = $game_message.name_backopacity
    create_back_sprite ($game_message.name_dim, $game_message.name_use_dim)
    self.windowskin = Cache.system ($game_message.name_windowskin)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Dispose
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def dispose (*args)
    super (*args)
    @word_sprite.bitmap.dispose
    @word_sprite.dispose
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * X, Y, Z
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  for attr in ["x", "y", "z"]
    ATS_NAMATTR = <<__END__
      def #{attr}= (*args)
        old_val = self.#{attr}
        super (*args)
        diff = self.#{attr} - old_val
        @word_sprite.#{attr} += diff
      end
__END__
    eval (ATS_NAMATTR)
  end
end

#==============================================================================
# ** Window_FaceBox
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  This window processes faces
#==============================================================================

class Window_FaceBox < Window_Base
  include Window_MessageBase
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Public Instance Variables
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  attr_reader   :busy
  attr_reader   :face_sprites
  attr_accessor :scroll_x
  attr_accessor :scroll_y
  attr_accessor :scroll_x_speed
  attr_accessor :scroll_y_speed
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Object Initialization
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def initialize (viewport)
    @back_sprite = Sprite.new (viewport)
    @face_sprites = []
    @animate_face_count = 0
    @fade_count = 0
    @active_face = 0
    @busy = false
    @scroll_x = 0
    @scroll_y = 0
    @scroll_x_speed = 8
    @scroll_y_speed = 8
    super (0, 0, 128, 128)
    self.viewport = viewport
    self.visible = false
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Remake Window
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def remake_window (width = $game_message.face_width, height = $game_message.face_height)
    self.width = [width + 2*$game_message.face_border_size, 33].max
    self.height = [height + 2*$game_message.face_border_size, 33].max
    create_contents
    self.windowskin = Cache.system ($game_message.face_windowskin)
    if $game_message.face_fadein
      self.back_opacity = 0
      @fade_count = $game_message.face_opacity
    else
      self.back_opacity = $game_message.face_opacity
    end
    create_back_sprite ($game_message.face_dim, $game_message.face_use_dim)
    self.visible = $game_message.face_window 
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Dispose
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def dispose (*args)
    super (*args)
    clear
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Clear
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def clear
    @face_sprites.each { |face| face.dispose } # Dispose all faces
    @face_sprites.clear
    return if self.disposed?
    self.visible = false
    @busy = false
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Update
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def update
    if !@face_sprites.empty? && @face_sprites[@active_face].visible
      # Update Fade In
      if @fade_count > 0 
        speed = [$game_message.face_fade_speed, @fade_count].min
        @fade_count -= speed
        self.back_opacity += speed
        @face_sprites.each { |sprite| sprite.opacity += speed }
      end
      # Update Horizontal Scroll
      if @scroll_x != 0
        speed = @scroll_x > 0 ? [@scroll_x_speed, @scroll_x].min : [-1*@scroll_x_speed, @scroll_x].max
        self.x += speed
        @scroll_x -= speed
      end
      # Update Verticaltal Scroll
      if @scroll_y != 0
        speed = @scroll_y > 0 ? [@scroll_y_speed, @scroll_y].min : [-1*@scroll_y_speed, @scroll_y].max
        self.y += speed
        @scroll_y -= speed
      end
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Animate Face
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def animate_face
    if @face_sprites.size > 1
      @face_sprites[@active_face].visible = false
      @animate_face_count = (@animate_face_count + 1) % $game_message.letters_per_face
      @active_face = (@active_face + 1) % @face_sprites.size if @animate_face_count == 0
      @face_sprites[@active_face].visible = true
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Pause Animation
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def pause
    return if @face_sprites.size < 2
    @face_sprites[@active_face].visible = false
    @active_face = 0
    @face_sprites[0].visible = true
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Set Face
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def set_face (face_file, index = 0)
    clear
    name = face_file.dup
    loop do
      # Make face and store in @face_sprites unless invalied
      face = Sprite_MessageFace.new (name, index, self.viewport) rescue break
      @face_sprites.push (face)
      break unless $game_message.animate_faces
      # If face_file has a number appended, add all of it's animations
      if name[/\_(\d+)$/i] != nil  
        name.sub! (/(\d+)$/) { ($1.to_i + 1).to_s }
      elsif name[/^\!\[(\d+)\]./] != nil # If name has exclamation code
        # Take all animations from the same face file
        index += 1
        break if index == $1.to_i 
      else
        break
      end
    end
    @active_face = 0
    @face_sprites[@active_face].visible = true if @face_sprites[@active_face]
    @busy = true
    remake_window
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Goal X; Goal Y : accomodate for scrolling
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def goal_x
    return self.x + @scroll_x
  end
  def goal_y
    return self.y + @scroll_y
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * X=; Y=; Z=
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def x= (value)
    super (value)
    @face_sprites.each { |sprite| sprite.x = self.x + $game_message.face_border_size}
  end
  def y= (value)
    super (value)
    @face_sprites.each { |sprite| sprite.y = self.y + $game_message.face_border_size}
  end
  def z= (value)
    super (value)
    @face_sprites.each { |sprite| sprite.z = self.z }
  end
end

#==============================================================================
# ** Window_ChoiceBox
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  This makes a separate window for handling choices, if desired.
#==============================================================================

class Window_ChoiceBox < Window_Selectable
  include Window_MessageBase
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Object Initialization
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def initialize (viewport = nil)
    font = Font.new ($game_message.choice_fontname, $game_message.choice_fontsize)
    @wlh = $game_message.choice_wlh > 0 ? $game_message.choice_wlh : $game_message.wlh
    width, height, line_num = prepare_choices (font.dup)
    @back_sprite = Sprite.new (viewport)
    super (0, 0, width, height)
    if line_num*@wlh > (height - 32)
      self.contents.dispose
      self.contents = Bitmap.new (width - 32, line_num*@wlh)
    end
    self.viewport = viewport
    self.windowskin = Cache.system ($game_message.choice_windowskin)
    self.opacity = $game_message.choice_opacity
    self.back_opacity = $game_message.choice_backopacity
    self.openness = 0
    self.contents.font = font
    self.contents.font.color = text_color ($game_message.choice_fontcolour)
    create_back_sprite ($game_message.choice_dim, $game_message.choice_use_dim)
    @spacing = $game_message.choice_spacing
    @column_max = $game_message.column_max
    @item_max = $game_message.choices.size
    @underline = false
    @highlight = -1
    @last_index = -1
    refresh
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Prepare Choices
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def prepare_choices (font)
    max_width = ($game_message.choice_width > 32 ? $game_message.choice_width : Graphics.width) - 32 
    max_width = (max_width - ($game_message.choice_spacing*($game_message.column_max - 1))) / $game_message.column_max
    longest_line = 1
    line_num = 0
    formatter = P_Formatter_ATS.new (font)
    @group_sizes = []
    @choices = []
    group_size = 1
    $game_message.choices.each_index { |i|
      lines = []
      line_sizes = []
      if i % $game_message.column_max == 0
        if i != 0
          line_num += group_size 
          @group_sizes.push (group_size)
        end
        group_size = 1
      end
      string = $game_message.choices[i].dup
      while !string.empty?
        ls, lc, j = formatter.format_by_line (string, max_width)
        length = max_width - (ls*(lc - 1))
        string.sub! (/(.*?)\x00/) { "" }
        lines.push ($1.to_s)
        line_sizes.push (length)
        longest_line = [length, longest_line].max
      end
      group_size = [group_size, lines.size].max
      @choices.push ([lines, line_sizes])
    }
    line_num += group_size
    @group_sizes.push (group_size)
    if $game_message.choice_width > 32
      width = $game_message.choice_width
      @line_size = max_width
    else
      width = 36 + ((longest_line + $game_message.choice_spacing)*$game_message.column_max) - $game_message.choice_spacing
      @line_size = longest_line
    end
    height = $game_message.choice_height > 32 ? $game_message.choice_height : 32 + (@wlh*[line_num, $game_message.row_max].min)
    return width, height, line_num
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Refresh
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def refresh
    @choices.each_index { |i|
      @align = 0
      rect = item_rect (i)
      start_x = rect.x
      @contents_y = rect.y
      for j in 0...@choices[i][0].size
        @text = @choices[i][0][j].dup
        length = @choices[i][1][j]
        @contents_x, @line_x = start_x, start_x 
        @contents_width = start_x + @line_size
        set_alignment (@align)
        while !@text.empty?
          c = @text.slice! (/./m)
          draw_regular_character (c) if !draw_message_character (c)
        end
        @contents_y += @wlh
      end
    }
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Item Rect
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def item_rect(index)
    rect = super (index)
    rect.y = 0
    for j in 0...(index / $game_message.column_max)
      rect.y += @group_sizes[j]
    end
    rect.y *= @wlh
    rect.height = @group_sizes[index / $game_message.column_max]*@wlh
    return rect
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Update Cursor
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def update_cursor
    if @index < 0                   # If the cursor position is less than 0
      self.cursor_rect.empty        # Empty cursor
    else                            # If the cursor position is 0 or more
      @help_window.set_text (@index) if @help_window
      return if @index == @last_index
      if $game_message.skip_choices.include? (@index)
        mod = @index - @last_index 
        @index = (@index + mod) % $game_message.choice_max
        return
      end
      rect = item_rect(@index)      # Get rectangle of selected item
      row = rect.y / @wlh           # Get current row
      # Scroll up if before the currently displayed
      self.top_row = row if row < top_row
      # Scroll down if after the currently displayed
      row += (rect.height / @wlh) - 1
      self.bottom_row = row if row > bottom_row
      rect.y -= self.oy             # Match rectangle to scroll position
      self.cursor_rect = rect       # Refresh cursor rectangle
      @last_index = @index
    end
  end
end

#==============================================================================
# ** Window ChoiceHelp
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  This window shows help text when hovering over choices
#==============================================================================

class Window_ChoiceHelp < Window_Base
  include Window_MessageBase
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Object Initialization
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def initialize (choice_helps)
    @back_sprite = Sprite.new
    @choice_helps = []
    @underline = false
    @highlight = -1
    font = Font.new ($game_message.choicehelp_fontname, $game_message.choicehelp_fontsize)
    p_formatter = P_Formatter_ATS.new (font)
    longest_line = 1
    x, y = $game_message.choicehelp_x, $game_message.choicehelp_y
    width, height = $game_message.choicehelp_width, $game_message.choicehelp_height
    @wlh = $game_message.choicehelp_wlh < 0 ? $game_message.wlh : $game_message.choicehelp_wlh
    wdth = width > 0 ? width - 32 : 5000
    tallest = 1
    choice_helps.each { |string| 
      s_d = $game_message.convert_special_characters (string.dup)
      s_d.gsub! (/\x16/) { "\x00" }
      lines = []
      line_lengths = []
      while !s_d.empty?
        ls, lc, j = p_formatter.format_by_line (s_d, wdth)
        line_lengths.push (wdth - (ls * (lc - 1)))
        lines.push (s_d.slice! (/.*?\x00/))
      end
      tallest = [tallest, lines.size].max
      @choice_helps.push ([lines, line_lengths])
    }
    p_formatter.dispose
    width = line_lengths.max + 32 if width < 0
    x = x >= 0 ? x : [(Graphics.width - width) / 2, 0].max
    y = $game_message.choicehelp_y < 0 ? 0 : $game_message.choicehelp_y
    width = [33, [width, Graphics.width - x].min].max
    height = height < 0 ? 32 + (tallest*@wlh) : [height, 33].max
    super (x, y, width, height)
    @contents_width = contents.width
    self.windowskin = Cache.system ($game_message.choicehelp_windowskin)
    self.opacity = $game_message.choicehelp_opacity
    self.back_opacity = $game_message.choicehelp_backopacity
    self.openness = 0
    create_back_sprite ($game_message.choicehelp_dim, $game_message.choicehelp_use_dim)
    self.contents.font = Font.new ($game_message.choicehelp_fontname, $game_message.choicehelp_fontsize)
    self.contents.font.color = text_color ($game_message.choicehelp_fontcolour)
    @index = -1
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Set Text
  #    index : the index of the choice being highlighted
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def set_text (index)
    if index != @index
      return if self.disposed?
      contents.clear
      @index = index
      lines = @choice_helps[index][0]
      lengths = @choice_helps[index][1]
      @contents_y = $game_message.choicehelp_center ? (contents.height - (lines.size*@wlh)) / 2 : 0
      @align = 0
      lines.each_index { |i|
        @text = lines[i].dup
        @contents_x, @line_x = 0, 0
        set_alignment (@align)
        while !@text.empty? # Stop when text finished
          c = @text.slice!(/./m)            # Get next text character
          draw_regular_character (c) if !draw_message_character (c)
        end
        @contents_y += @wlh
      }
    end
  end
end

#==============================================================================
# ** Window_Gold
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Summary of Changes:
#    Make @closing and @opening publicly accessible
#==============================================================================

class Window_Gold
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Public Instance Variables
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  attr_reader :closing
  attr_reader :opening
end

#==============================================================================
# ** Window_Message
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Summary of Changes:
#    overwritten methods - create_back_sprite; update_message; update_cursor;
#      convert_special_characters; reset_window; draw_face; input_pause; z=;
#      close; visible=
#    aliased methods - initialize; dispose; update; update_show_fast; new_page;
#      start_message; new_line; finish_message; start_choice; terminate_message
#      start_number_input; input_choice
#    new methods - create_namebox; create_wordbox; create_choicebox; 
#      create_choicehelp; remake_window; fit_window_to_text; set_position;
#      position_to_character; do_not_obscure_characters; set_face_position;
#      set_speechtag_position; set_name_position; set_choice_position;
#      dispose_ats_windows; update_letter_se; format_line; start_scroll_message;
#      contents_width; draw_message_character; set_alignment
#==============================================================================

class Window_Message
  include Window_MessageBase
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Object Initialization
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias modalg_ats3_win_msg_init_9id1 initialize unless $@
  def initialize (viewport = nil, *args)
    @back_sprite = Sprite.new
    modalg_ats3_win_msg_init_9id1 (*args)
    remake_window
    self.viewport = viewport ? viewport : Viewport.new (0, 0, Graphics.width, Graphics.height)
    self.viewport.z = self.z
    @face_window = Window_FaceBox.new (self.viewport)
    @speechtag_sprite = Sprite_SpeechTag.new (self.viewport)
    @longest_line = 0
    @scrolling = 0
    @review_scroll = 0
    @letter_se_count = 0
    @ls = 0
    @underline = false
    @highlight = -1
    @last_index = -1
    @align = 0
    @max_oy = 0
    @p_formatter = P_Formatter_ATS.new (self.contents.font.dup)
    @wlh = $game_message.wlh
    @anti_update = true if self.is_a? (Window_BattleMessage) # Yanfly Melody compatibility measure
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Dispose
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias modrna_atxts3_dsps_9th5 dispose unless $@
  def dispose (*args)
    modrna_atxts3_dsps_9th5 (*args) # Run Original Method
    dispose_ats_windows
    @face_window.dispose
    @speechtag_sprite.dispose
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Update
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias mdrnalg_advtxt3_upd_3xa2 update unless $@
  def update (*args)
    # Graphic Novel Support
    if $game_message.graphic_novel && !self.is_a? (Window_BattleMessage)
      if $game_message.gn_press_or_toggle # Press
        self.viewport.visible = !Input.press? ($game_message.hide_button)
      else # Toggle
        self.viewport.visible = !self.viewport.visible if Input.trigger? ($game_message.hide_button)
      end
      return if !self.viewport.visible
    end
    [@choice_window, @choicehelp_window, @word_window, @name_window].each { |window|
      window.update if window && !window.disposed? }
    mdrnalg_advtxt3_upd_3xa2 (*args)
    # If Window opening, but no text and just a choice window.
    if @opening && $game_message.choice_window && @text.empty? && !$game_message.choices.empty?
      close
      $game_message.visible = @closing
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Create Background Sprite
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def create_back_sprite
    if @back_sprite
      @back_sprite.bitmap.dispose if @back_sprite.bitmap && !@back_sprite.bitmap.disposed?
      @back_sprite.dispose if !@back_sprite.disposed?
    end
    @back_sprite = Sprite.new (self.viewport)
    bmp = Cache.system($game_message.message_dim)
    @back_sprite.bitmap = Bitmap.new (self.width, self.height + 32)
    @back_sprite.bitmap.stretch_blt (@back_sprite.bitmap.rect, bmp, bmp.rect)
    @back_sprite.visible = (@background == 1)
    @back_sprite.x = self.x
    @back_sprite.y = self.y
    @back_sprite.z = 190
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Create Namebox
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def create_namebox (name)
    @name_window.dispose unless @name_window.nil? || @name_window.disposed?
    return if name.empty?
    @name_window = Window_NameBox.new (name, self.viewport)
    @name_window.open
    set_name_position
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Create Wordbox
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def create_wordbox (word)
    @word_window.dispose unless @word_window.nil? || @word_window.disposed?
    return if word.empty?
    x = $game_message.word_x
    y = $game_message.word_y == -1 ? @gold_window.y : $game_message.word_y
    @word_window = Window_WordBox.new (self.viewport, word, x, y, $game_message.word_width, $game_message.word_height)
    if $game_message.word_x == -1
      if $game_message.word_y == -1 && (@gold_window.opening || (@gold_window.openness == 255 && !@gold_window.closing))
        @word_window.x = @gold_window.x - @word_window.width
        if @word_window.x < 0
          val = @gold_window.y == 0 ? @gold_window.height : -1*@word_window.height
          @word_window.y += val
          @word_window.x = (Graphics.width - @word_window.width) / 2
        end
      else
        @word_window.x = (Graphics.width - @word_window.width) / 2
      end
    end
    @word_window.draw_word
    @word_window.open
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Create Choicebox
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def create_choicebox
    @choice_window = Window_ChoiceBox.new (self.viewport)
    @choice_window.z = self.z + 10
    @choice_window.open
    set_choice_position
    $game_message.choices.clear
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Create ChoiceHelp Window
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def create_choicehelp
    @choicehelp_window = Window_ChoiceHelp.new ($game_message.help_choices)
    @choicehelp_window.open
    @choicehelp_window.viewport = self.viewport
    if $game_message.choicehelp_y < 0
      unless Graphics.height - @choicehelp_window.height < self.y + self.height 
        @choicehelp_window.y = Graphics.height - @choicehelp_window.height 
      end
    end
    @choicehelp_window.z = self.z + 5
    @choice_window.help_window = @choicehelp_window if @choice_window
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Remake Window
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def remake_window (width = $game_message.message_width, height = $game_message.message_height)
    return if width <= 32 || height <= 32
    self.width, self.height = width, height
    self.contents.dispose
    self.contents = Bitmap.new (width - 32, height - 32)
    create_back_sprite
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Fit Window to Text
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def fit_window_to_text
    all_lines = $game_message.texts.dup
    all_lines += $game_message.choices.dup if !$game_message.choice_window
    return if all_lines.size < 1
    @longest_line = 0
    con_hght = [$game_message.max_lines, all_lines.size].min
    $game_message.message_height = 32 + (con_hght*@wlh)
    $game_message.max_lines = con_hght
    # Get Width of longest line
    dummy_formatter = P_Formatter_ATS.new 
    all_lines.each { |line|
      c_line = $game_message.convert_special_characters (line.dup)
      ls, lc, j = dummy_formatter.format_by_line (c_line, 5000)
      @longest_line = [@longest_line, (5000 - ls * (lc - 1))].max
      if @longest_line > (Graphics.width - 32)
        @longest_line = Graphics.width - 32 
        break
      end
    }
    dummy_formatter.dispose
    $game_message.message_width = 32 + @longest_line
    $game_message.choice_on_line = false if $game_message.message_width + $game_message.choice_width > Graphics.width
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Set Position
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def set_position (x = $game_message.message_x, y = $game_message.message_y)
    if $game_message.character >= 0
      position_to_character ($game_message.character, $game_message.char_ref)
      self.x = $game_message.message_x
      self.y = $game_message.message_y
    else
      # Set the y position, either directly or by default
      if y == -1
        do_not_obscure_characters if $game_message.do_not_obscure
        self.y = ((Graphics.height - $game_message.message_height) / 2)*@position
      else
        self.y = y
      end
      if self.y < @gold_window.height
        @gold_window.y = Graphics.height - @gold_window.height
      else
        @gold_window.y = 0
      end
      # Set the x position
      if x == -1 # Centre by default
        self.x = (Graphics.width - $game_message.message_width) / 2
      else
        self.x = x
      end
    end
    set_face_position
    set_name_position
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Position To Character
  #    character_id : the character around which the message window is to go
  #    type : Over, Below, Left or Right of character
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def position_to_character (character_id, type)
    whatever_fits = (type == 4)
    type = 0 if whatever_fits # Above if fits, else Under
    character = character_id == 0 ? $game_player : $game_map.events[character_id]
    # Do not change position if character does not exist
    return if character == nil
    # Do not change position if the character is not on screen.
    return unless character.screen_x.between? (0, Graphics.width) && character.screen_y.between? (0, Graphics.height)
    # Get the size of the character
    bmp = Cache.character (character.character_name).clone
    if character.character_name[/^.?\$/] == nil
      c_wdth, c_hght = bmp.width / 12, bmp.height / 8 
    else
      c_wdth, c_hght = bmp.width / 3, bmp.height / 4
    end
    bmp.dispose
    # Centre X or Y depending on position
    if type % 2 == 0
      # Centre X
      x = [character.screen_x - (self.width / 2) , 0].max
      x = (x + self.width <= Graphics.width) ? x : Graphics.width - self.width
    else
      # Centre Y
      y = [character.screen_y - ((self.height + c_hght) / 2), 0].max
      y = (y + self.height <= Graphics.height) ? y : Graphics.height - self.height
    end
    case type
    when 0 # Over
      if whatever_fits && character.screen_y - c_hght - self.height < 0
        position_to_character (character_id, 2)
        return
      end
      y = [character.screen_y - c_hght - self.height, 0].max
    when 1 # Left
      x = [character.screen_x - (c_wdth / 2) - self.width, 0].max
    when 2 # Below
      y = [character.screen_y, Graphics.height - self.height].min 
    when 3 # Right
      x = [character.screen_x + (c_wdth / 2), Graphics.width - self.width].min
    end
    $game_message.message_x = x
    $game_message.message_y = y
    if character_id >= 0 && $game_message.speech_tag_index >= 0
      set_speech_sprite_position (character.screen_x, character.screen_y, c_wdth, c_hght, type)
      position_to_character (character_id, 2) if whatever_fits && !@speechtag_sprite.visible
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Do Not Obstruct Characters
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def do_not_obscure_characters
    obscured = [0, 0, 0]
    positions = [2, 0, 1]
    positions.delete (@position)
    positions.unshift (@position)
    positions.each { |pos|
      y = ((Graphics.height - $game_message.message_height) / 2)*pos
      range = y..(y + self.height)
      $game_message.obscure_characters.each { |id|
        char = id == 0 ? $game_player : $game_map.events[id]
        next if char.nil?
        range2 = (char.screen_y - $game_message.obscure_buffer)..char.screen_y
        obscured[pos] += 1 if range === range2.first || range2 === range.first
      }
      if obscured[pos] == 0
        @position = pos
        return
      end
    }
    @position = obscured.index (obscured.min)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Set Speech Sprite Position
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def set_speech_sprite_position (c_x, c_y, c_w, c_h, char_ref)
    @speechtag_sprite.opacity = $game_message.message_opacity
    @speechtag_sprite.set_direction (char_ref)
    @speechtag_sprite.x = c_x - (@speechtag_sprite.width / 2)
    if char_ref == 0 
      return if $game_message.message_y < @speechtag_sprite.height - 16
      @speechtag_sprite.y = c_y - c_h - @speechtag_sprite.height
      $game_message.message_y -= (@speechtag_sprite.height - 16)
      @speechtag_sprite.visible = true
    elsif char_ref == 2
      return if $game_message.message_y + (@speechtag_sprite.height - 16) > Graphics.height
      @speechtag_sprite.y = c_y
      $game_message.message_y += @speechtag_sprite.height - 16
      @speechtag_sprite.visible = true
    else
      @speechtag_sprite.visible = false
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Set Face Position
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def set_face_position (x = $game_message.face_x, y = $game_message.face_y)
    return if @face_window.nil? || @face_window.disposed?
    # Determine Goal X
    if x == -1
      if $game_message.face_side
        x = (self.x + 16 - $game_message.face_border_size) + $game_message.face_offset_x
      else
        x = (self.x + self.width - @face_window.width - 16 + $game_message.face_border_size) - $game_message.face_offset_x
      end
    end
    if y == -1
      if @face_window.height < self.height
        y = self.y + ((self.height - @face_window.height) / 2) # Centre
      else
        y = (self.y + self.height) - @face_window.height
      end
      y = self.y if y < 0 # Align to top of window if out of bounds
      y += $game_message.face_offset_y
    end
    # Set up Horizontal Scroll
    if $game_message.face_scroll_x
      left = x + @face_window.width
      right = Graphics.width - x
      if left < right
        @face_window.x = -1*@face_window.width
        @face_window.scroll_x = left
        @face_window.scroll_x_speed = left / $game_message.face_scroll_speed
      else
        @face_window.x = Graphics.width
        @face_window.scroll_x = -1*right
        @face_window.scroll_x_speed = right / $game_message.face_scroll_speed
      end
    else
      @face_window.x = x
    end
    # Set up Vertical Scroll
    if $game_message.face_scroll_y
      up = y + @face_window.height
      down = Graphics.height - y
      if up < down
        @face_window.y = -1*@face_window.height
        @face_window.scroll_y = up
        @face_window.scroll_y_speed = up / $game_message.face_scroll_speed
      else
        @face_window.y = Graphics.height
        @face_window.scroll_y = -1*down
        @face_window.scroll_y_speed = down / $game_message.face_scroll_speed
      end
    else
      @face_window.y = y
    end
    # If there is overlap and meant to fit to text_size
    if $game_message.fit_window_to_text && @longest_line > 0
      con_x, con_w = contents_width (-1)
      $game_message.message_width = @longest_line + contents.width + 32 - con_w
      remake_window
      if self.x + self.width > Graphics.width
        diff = self.x - (Graphics.width - self.width) 
        self.x -= diff
        @face_window.x -= diff
      end
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Set Name Position
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def set_name_position (x = $game_message.name_x, y = $game_message.name_y)
    return if @name_window.nil? || @name_window.disposed?
    # Set NameBox coordinates
    if y == -1
      y = self.y - @name_window.height + $game_message.name_offset_y
      y = self.y + self.height - $game_message.name_offset_y if y < 0
    end
    if x == -1
      if $game_message.face_side
        x = self.x + $game_message.name_offset_x
      else
        x = self.x + self.width - @name_window.width - $game_message.name_offset_x
      end
      # If face is showing
      if @face_window.busy
      # If overlap with face
        if ((@face_window.goal_y + $game_message.face_border_size + 1).between? (y, y + @name_window.height) ||
          y.between? (@face_window.goal_y + $game_message.face_border_size + 1, @face_window.goal_y + @face_window.height)) && 
          (x.between? (@face_window.goal_x + $game_message.face_border_size, @face_window.goal_x + @face_window.width) ||
          @face_window.goal_x.between? (x, x + @name_window.width))
          if $game_message.face_side
            x = @face_window.goal_x + @face_window.width
          else
            x = @face_window.goal_x - @name_window.width
          end
        end
      end
    end
    @name_window.x = x
    @name_window.y = y
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Set Choice Position
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def set_choice_position (x = $game_message.choice_x, y = $game_message.choice_y)
    return if @choice_window.nil? || @choice_window.disposed?
    if y == -1
      if self.openness == 0
        y = (Graphics.height - @choice_window.height) / 2
      else
        y = self.y - @choice_window.height + $game_message.choice_offset_y
        y = self.y + self.height - $game_message.choice_offset_y if y < 0
      end
    end
    if x == -1
      choice_side = $game_message.choice_opposite_face ? !$game_message.face_side : $game_message.face_side
      if self.openness == 0
        x = (Graphics.width - @choice_window.width) / 2
      elsif choice_side
        x = self.x - $game_message.choice_offset_x
      else
        x = self.x + self.width - @choice_window.width + $game_message.choice_offset_x
      end
    end
    @choice_window.x = x
    @choice_window.y = y
    @choice_window.y = self.y if $game_message.choice_on_line
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Dispose Windows
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def dispose_ats_windows
    ats_windows = [@name_window, @word_window, @choice_window, @choicehelp_window]
    ats_windows.each { |window| window.dispose unless window.nil? || window.disposed? }
    @name_window = nil
    @word_window = nil
    @choice_window = nil
    @choicehelp_window = nil
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Update Show Fast
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias mrnagb_atsys3_updshfst_6yv3 update_show_fast unless $@
  def update_show_fast (*args)
    real_count = @wait_count
    @wait_count = 2 if $game_message.skip_disabled
    mrnagb_atsys3_updshfst_6yv3 (*args) # Run Original Method
    @wait_count = real_count
    @face_window.update
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Update Message
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def update_message
    loop do
      if @scrolling > 0
        speed = [$game_message.scroll_speed, @scrolling].min
        @scrolling -= speed
        self.oy += speed
        if @scrolling <= 0 && self.contents.height < self.oy + self.height - 32
          bmp = self.contents
          # Max # of lines before cutting top out approx. 200
          if self.contents.width * (self.oy + self.height - 32) < 2500000
            self.contents = Bitmap.new (self.contents.width, self.oy + self.height - 32)
            self.contents.font = bmp.font.dup
            src_rect = bmp.rect
          else
            src_rect = Rect.new (0, @wlh, bmp.rect.width, bmp.rect.height - @wlh)
          end
          self.contents.blt (0, 0, bmp, src_rect)
          bmp.dispose if src_rect.y != 0
        end
        break
      end
      c = @text.slice!(/./m)            # Get next text character
      # If no text left
      if c.nil? 
        if @choice_sizes
          @choice_sizes[-1].push (@line_count - @choice_sizes[-1][0])
        end
        if $game_message.choices.empty?
          $game_message.choice_start = @choice_sizes[0][0] if @choice_sizes
          finish_message                  # Finish update
          break
        else
          if @choice_sizes.nil?
            $game_message.scroll_by_page = false
            if $game_message.choice_window
              create_choicebox
              finish_message
              return
            end
            if !$game_message.scrolling 
              if $game_message.max_lines < @line_count + $game_message.choices.size
                self.pause = true
                $game_message.choice_start = 0
                @text = "\x1d"
              end
              $game_message.scrolling = true
              return
            end
            @choice_sizes = []
          end
          @text = "#{$game_message.choices.shift}\x00"
          # New line stuff
          format_line
          @choice_sizes.push ([@line_count])
          c = @text.slice!(/./m)            # Get next text character
        end
      end
      draw_message_character (c)
      break unless @show_fast || @line_show_fast || $game_message.message_speed < 0
      break if self.pause 
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Update Letter SE
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def update_letter_se
    return if !$game_message.letter_sound || @show_fast || @line_show_fast || 
      $game_message.message_speed < 0
    # Randomize Pitch
    rp = $game_message.random_pitch
    $game_message.letter_se.pitch = rp.first + rand(rp.last - rp.first) unless rp.first == rp.last
    # Update Sound
    $game_message.play_se ($game_message.letter_se) if @letter_se_count == 0
    @letter_se_count = (@letter_se_count + 1) % $game_message.letters_per_se
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Update cursor
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def update_cursor
    return if @choice_window
    if @index >= 0
      @choicehelp_window.set_text (@index) if @choicehelp_window
      return if @index == @last_index
      if $game_message.skip_choices.include? (@index)
        mod = @last_index < @index ? 1 : -1
        @index = (@index + mod) % $game_message.choice_max
        return
      end
      row = @choice_sizes[@index][0]
      hght = @choice_sizes[@index][1]*@wlh
      y = (row) * @wlh
      x, con_width = contents_width (self.contents.height > self.height - 32 ? -1 : y)
      # Scroll up if before the currently displayed
      self.top_row = row if row < top_row
      row += @choice_sizes[@index][1] - 1
      # Scroll down if after the currently displayed
      self.bottom_row = row if row > bottom_row
      self.cursor_rect.set(x, y - self.oy, con_width, hght)
      @last_index = @index
    else
      self.cursor_rect.empty
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Start Message
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias malg_atxs3_msgstrt_8ik3 start_message unless $@
  def start_message (*args)
    @starting = true
    @wlh = $game_message.wlh
    @align = 0
    @max_oy = 0
    @line_x = 0
    @underline = $game_message.underline
    @highlight = $game_message.highlight
    malg_atxs3_msgstrt_8ik3 (*args)
    @text.gsub! (/([^\s])\s*\x00/) { "#{$1} " } if $game_message.paragraph_format
    # Remove x00 from middle of wb and nb boxes
    @text.gsub! (/[\x19\x1a]{.*?}/) { |match| match.gsub (/\x00/) { "" } }
    @text.gsub! (/\x16/) { "\x00" }
    format_line
    self.windowskin = Cache.system ($game_message.message_windowskin).dup
    self.windowskin.clear_rect (80, 16, 32, 32) unless $game_message.scroll_show_arrows
    self.contents.font.name = $game_message.message_fontname
    self.contents.font.size = $game_message.message_fontsize
    @p_formatter.bitmap.font = self.contents.font.dup
    $game_message.play_se ($game_message.start_se) if $game_message.start_sound
    @starting = false
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * New Page
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias malba_advts3_nwpge_7uj2 new_page unless $@
  def new_page (*args)
    if !$game_message.do_not_start || !@starting
      if @text.sub! (/\A\x17<(\d+)>/, "") != nil
        actor = $game_actors[$1.to_i]
        if !actor.nil?
          $game_message.face_name = actor.face_name
          $game_message.face_index = actor.face_index
        end
      end
      @face_window.clear if !@face_window.nil? && !@face_window.disposed?
      malba_advts3_nwpge_7uj2 (*args) # Run Original Method
      self.contents.font.color = text_color ($game_message.message_fontcolour)
      self.contents.font.color.alpha = $game_message.message_fontalpha if $game_message.message_fontalpha != 255
      self.oy = 0
    elsif (@line_count - (self.oy / @wlh)) >= $game_message.max_lines
      # If scrolling
      start_scroll_message if $game_message.scrolling
    end
    @contents_x, @contents_width = contents_width
    @line_x = @contents_x
    unless @starting
      @text.sub! ("\x00", " ") if @text && $game_message.paragraph_format && !(@p_formatter && @p_formatter.force_break)
      format_line
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * New Line
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias modalg_ats3_nl_scroll_0ol2 new_line unless $@
  def new_line (*args)
    modalg_ats3_nl_scroll_0ol2 (*args)
    @contents_y = @line_count*@wlh
    @contents_x, @contents_width = contents_width (@contents_y)
    @line_x = @contents_x
    format_line
    # If Reached end of page
    if (@line_count - (self.oy / @wlh)) >= $game_message.max_lines
      # Do not pause if message is over
      return if @text == "" && ($game_message.choices.empty? || $game_message.choice_window)
      # If scrolling
      if $game_message.scrolling
        start_scroll_message
      else
        self.pause = true
      end
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Format Line
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def format_line
    if $game_message.paragraph_format
      @ls, dc, justify = @p_formatter.format_by_line (@text, @contents_width)
    else
      @ls = 0
    end
    set_alignment (@align) if @align != 0
    @ls = 0 if @ls > 0 && (!justify || @align != 0)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Convert Special Characters
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def convert_special_characters
    $game_message.convert_special_characters (@text)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Set Window Background and Position
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def reset_window
    @background = $game_message.background
    @position = $game_message.position
    $game_message.choice_on_line = false if $game_message.choice_width < 32
    fit_window_to_text if $game_message.fit_window_to_text
    if $game_message.choice_window && $game_message.choice_on_line
      $game_message.message_width = [$game_message.message_width, Graphics.width - $game_message.choice_width].min
      total_width = $game_message.message_width + $game_message.choice_width
      if $game_message.message_x == -1
        $game_message.message_x = (Graphics.width - total_width) / 2 
      elsif $game_message.message_x + total_width > Graphics.width
        $game_message.message_x = Graphics.width - total_width
      end 
      choice_side = $game_message.choice_opposite_face ? !$game_message.face_side : $game_message.face_side
      if choice_side 
        $game_message.choice_x = $game_message.message_x
        $game_message.message_x += $game_message.choice_width
      else
        $game_message.choice_x = $game_message.message_x + $game_message.message_width
      end
      $game_message.choice_height = $game_message.message_height
    end
    remake_window unless $game_message.do_not_start
    # Set opacity
    self.opacity = @background == 0 ? $game_message.message_opacity : 0
    self.back_opacity = $game_message.message_backopacity
    # Remake speech bubble if different
    @speechtag_sprite.reset_graphic
    @speechtag_sprite.z = self.z + 1
    if @text.include? ("\x1c")
      @text = "" 
      self.openness = 0 unless $game_message.do_not_refresh
    end
    set_position
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Finish Message
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias malbra_ats3_fnmsg_7uj2 finish_message unless $@
  def finish_message (*args)
    @face_window.pause
    $game_message.play_se ($game_message.finish_se) if $game_message.finish_sound
    malbra_ats3_fnmsg_7uj2 (*args)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Start Choices
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias modrn_ats3_strtchc_5sf2 start_choice unless $@
  def start_choice (*args)
    modrn_ats3_strtchc_5sf2 (*args)
    $game_message.move_when_visible = false
    if @choice_window
      self.index = -1 
      @choice_window.index = 0
    end
    create_choicehelp if !$game_message.help_choices.empty?
    @max_oy = [(@line_count - $game_message.max_lines)*@wlh, 0].max
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Start Number Input
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias malgr_advts3_strtnuminp_8qw2 start_number_input unless $@
  def start_number_input (*args)
    malgr_advts3_strtnuminp_8qw2 (*args) # Run Original Method
    if $game_message.scrolling
      self.oy += @wlh if @line_count >= $game_message.max_lines
      @number_input_window.y -= self.oy
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Start Scroll Message
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def start_scroll_message
    scroll_plus = @wlh
    scroll_plus *= $game_message.max_lines if $game_message.scroll_by_page
    @scrolling += scroll_plus
    @show_fast = false
    if $game_message.scroll_autopause && !@text.nil? && !@text.empty?
      self.pause = true 
      $game_message.play_se ($game_message.pause_se) if $game_message.pause_sound
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * End Message
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias modal_atsv3_trmmsg_8yx4 terminate_message unless $@
  def terminate_message (*args)
    if !$game_message.do_not_refresh
      if !@face_window.nil? && !@face_window.disposed?
        if self.is_a? (Window_BattleMessage)
          @face_window.visible = false 
          @face_window.clear
          create_contents if contents.height > height - 32
          self.oy = 0
        end
      end
      dispose_ats_windows
    else
      @choice_window.dispose if @choice_window && !@choice_window.disposed?
      @choicehelp_window.dispose if @choicehelp_window && !@choicehelp_window.disposed?
      @choice_window = nil
      @choicehelp_window = nil
    end
    $game_message.play_se ($game_message.terminate_se) if $game_message.terminate_sound
    modal_atsv3_trmmsg_8yx4 (*args) # Run Original Method
    @last_index = -1
    @choice_sizes = nil
    @speechtag_sprite.visible = false
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Contents Width
  #    y : the line to check it on
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def contents_width (y = 0)
    # If can scroll, make sure no overlap over whole range. Get the ranges
    if y < 0 || ($game_message.scrolling && $game_message.texts.size > $game_message.max_lines)
      m_range = (self.y + 16)..(self.y + 16 + ($game_message.max_lines*@wlh))
    else
      screen_y = self.y + 16 + y - self.oy
      m_range = screen_y..screen_y + @wlh
    end
    return 0, contents.width if @face_window.z < self.z
    f_range = @face_window.goal_y..(@face_window.goal_y + @face_window.height)
    # If there is overlap with the face window
    if @face_window.busy && (m_range === f_range.first || f_range === m_range.first)
      left = @face_window.goal_x - (self.x + 20)
      right = self.x + self.width - 20 - (@face_window.goal_x + @face_window.width)
      if left >= right
        return 0, left
      else
        return @face_window.goal_x + @face_window.width - (self.x + 12), right
      end
    end
    return 0, contents.width # Start X, total width
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Draw Face
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def draw_face (face_file, face_index, *args)
    @face_window.set_face (face_file, face_index)
    set_face_position
    @face_window.z = self.z + $game_message.face_z
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Draw Message Character
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def draw_message_character (c)
    return if super (c)
    case c
    when "\x00"                       # New line
      new_line
    when "\x02"                       # \G    (gold display)
      @gold_window.refresh
      @gold_window.openness > 0 ? @gold_window.close : @gold_window.open
    when "\x03"                       # \W[x]     (Wait x frames)
      @text.sub!(/<(\d+)>/, "")
      @wait_count = $1.to_i
      @face_window.pause
      @show_fast, @line_show_fast = false, false
    when "\x04"                       # \!        (Wait for input)
      self.pause = true
      $game_message.play_se ($game_message.pause_se) if $game_message.pause_sound
      @show_fast, @line_show_fast = false, false
    when "\x05"                       # \/@  (Fast display ON)
      @text.sub!(/<([01])>/, "")
      @line_show_fast = (Game_ATS::ATS_2 && $1.to_i == 0) ? !@line_show_fast: $1.to_i == 0
    when "\x06"                       # \/@@  (Fast display OFF)
      @text.sub!(/<([01])>/, "")
      @show_fast = (Game_ATS::ATS_2 && $1.to_i == 0) ? !@show_fast : $1.to_i == 0
    when "\x07"                       # \^  (No wait for input)
      @pause_skip = true
    when "\x08"                       # Speed Change
      @text.sub!(/<(=?-?\d+)>/, "")
      s = $1.to_s
      s.sub! (/(=)/, "")
      if $1.nil?
        $game_message.message_speed = [$game_message.message_speed + s.to_i, -1].max
      else
        $game_message.message_speed = [s.to_i, -1].max
      end
    when "\x0b"                        # Show Animation
      # Extract Target and Graphic ID
      @text.sub! (/<(\d*),(\d*),([01])>/, "")
      return if self.is_a? (Window_BattleMessage)
      char = $1.to_i < 1 ? $game_player : $game_map.events[$1.to_i] # Target
      if char != nil
        $3.to_i == 0 ? char.animation_id = $2.to_i : char.balloon_id = $2.to_i
      end
    when "\x0c"                        # Position to Character
      @text.sub! (/<(\d+),([0-4])>/, "")
      return if self.is_a? (Window_BattleMessage)
      $game_message.character = $1.to_i
      $game_message.char_ref = $2.to_i
      set_position
      new_page
    when "\x17"                        # Use Actor Face
      @text.sub! (/<(\d+)>/, "")
      $game_message.face_name = $game_actors[$1.to_i].face_name
      $game_message.face_index = $game_actors[$1.to_i].face_index
      draw_face ($game_message.face_name, $game_message.face_index)
      set_name_position
    when "\x19"                       # Name Box
      @text.sub! (/{(.*?)}/, "")
      create_namebox ($1.to_s)
    when "\x1a"                       # Word Box
      @text.sub! (/{(.*?)}/, "")
      create_wordbox ($1.to_s)
    when "\x1b"                        # Play SE
      @text.sub! (/<(.+?),([MS]E)>/, "")
      $game_message.play_se ((RPG.const_get ($2.to_s)).new ($1.to_s))
    when "\x1d"                        # New Page
      create_contents
      new_page
    when "\x1f"                        # Position setting
      @text.sub! (/<([012]),(-?\d+),(-?\d+)>/, "" )
      return if self.is_a? (Window_BattleMessage)
      case $1.to_i
      when 0 then set_position ($2.to_i, $3.to_i)
      when 1 then set_face_position ($2.to_i, $3.to_i)
      when 2 then set_name_position ($2.to_i, $3.to_i)
      end
      new_page unless $1.to_i == 2
    when "\x7f"                        # Evaluate Code
      @text.sub! (/\{(.+?)#\}/, "")
      eval ($1.to_s)
    when "\xb0"                        # Enable/Disable Skipping
      @text.sub!(/<([01])>/, "")
      $game_message.skip_disabled = (Game_ATS::ATS_2 && $1.to_i == 0) ? !$game_message.skip_disabled : $1.to_i == 0
      @show_fast, @line_show_fast = false, false
    when "\xb1"                        # Set Contents X
      start_x, throwaway = contents_width (@contents_y)
      @contents_x += start_x
    else                               # Normal text character
      draw_regular_character (c)
      @wait_count += $game_message.message_speed if !@show_fast && 
        !@line_show_fast && $game_message.message_speed > 0
      update_letter_se
      @face_window.animate_face
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Set Alignment
  #    align : The alignment ( 1 => Centre, 2 => Right )
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def set_alignment (align = 1)
    # Get rest of line
    formatter = P_Formatter_ATS.new (self.contents.font.dup)
    txt = @text[/.*?\x00/]
    txt = "" if txt.nil?
    ls, lc, j = formatter.format_by_line (txt, @line_x + @contents_width - @contents_x)
    formatter.dispose
    es = ls * (lc - 1)
    @contents_x += (es / 2)*align
    @ls = 0 if align > 0
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Input Pause
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def input_pause (*args)
    # Allow to review message before inputting
    if $game_message.scroll_review
      if @review_scroll != 0
        scroll_plus = @review_scroll > 0 ? [@review_scroll, $game_message.scroll_speed].min : 
          [@review_scroll, -1*$game_message.scroll_speed].max
        self.oy += scroll_plus
        self.oy = [[self.oy, 0].max, @max_oy].min
        @review_scroll -= scroll_plus
      end
      if Input.press? (Input::UP)
        @review_scroll -= $game_message.scroll_speed
      elsif Input.press? (Input::DOWN)
        @review_scroll += $game_message.scroll_speed
      end
    end
    # Original Method
    if Input.trigger?(Input::B) or Input.trigger?(Input::C)
      self.oy = @max_oy
      self.pause = false
      if @text != nil and not @text.empty?
        new_page if !$game_message.scrolling && @line_count >= $game_message.max_lines
      else
        terminate_message
      end
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Choice Input
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias modab_ats3_inptchc_7yh2 input_choice unless $@
  def input_choice (*args)
    if Input.trigger?(Input::C)
      indx = @choice_window ? @choice_window.index : self.index
      if $game_message.disabled_choices.include? (indx)
        Sound.play_buzzer
      else
        Sound.play_decision
        $game_message.choice_proc.call(indx)
        terminate_message
      end
      return
    end
    modab_ats3_inptchc_7yh2 (*args)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Pause=
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias malabra_ats3_setpause_8uj2 pause= unless (self.method_defined? (:malabra_ats3_setpause_8uj2) || $@)
  def pause= (boolean)
    malabra_ats3_setpause_8uj2 (boolean)
    if boolean
      @max_oy = self.oy
      @face_window.pause
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Z=
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def z= (*args)
    diff = -1*self.z
    super (*args)
    diff += self.z
    ats_gfx = [@face_window, @name_window, @word_window, @speechtag_sprite, 
      @back_sprite, @choice_window, @choicehelp_window]
    ats_gfx.each { |gfx| gfx.z += diff unless gfx.nil? }
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Visible =
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def visible= (boolean)
    super (boolean)
    @face_window.clear if @face_window && !@face_window.disposed? && !boolean
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Close
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def close (*args)
    super (*args)
    if !@face_window.nil? && !@face_window.disposed?
      @face_window.clear
      @face_window.close
    end
    @name_window.close if @name_window && !@name_window.disposed?
  end
end

#==============================================================================
# ** Window_BattleMessage
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Summary of Changes:
#    aliased method - initialize
#    overwritten method - draw_line
#==============================================================================

class Window_BattleMessage
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Object Initialization
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias modrna_ynfl_melatscomp_5yh2 initialize unless $@
  def initialize (*args) # Yanfly Melody compatibility measure
    modrna_ynfl_melatscomp_5yh2 (*args)
    @anti_update = false
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Draw Line
  #    index : the line to draw on
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def draw_line(index)
    return if !@text.nil?
    rect = Rect.new(0, 0, 0, 0)
    rect.x += 4
    rect.y += index * @wlh
    rect.width = contents.width - 8
    rect.height = @wlh
    self.contents.clear_rect(rect)
    self.contents.font.color = normal_color
    @wlh = $game_message.battle_wlh
    @text = @lines[index].dup
    convert_special_characters
    @contents_x = rect.x
    @contents_y = rect.y
    loop do
      c = @text.slice!(/./m)            # Get next text character
      # Stop when text finished
      break if c.nil?     
      draw_message_character (c)
    end
    @text = nil
  end
end

#==============================================================================
# ** Scene_Title
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Summary of Changes:
#      aliased method - create_game_objects
#==============================================================================

class Scene_Title
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Create Game Objects
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias modalg_ats3_gm_obj_create create_game_objects unless $@
  def create_game_objects (*args)
    # Create the object which holds default values for message
    $game_ats = $ats_default = Game_ATS.new
    # Run original method
    modalg_ats3_gm_obj_create (*args)
  end
end

#==============================================================================
# ** Scene_File
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Summary of Changes:
#      aliased methods - write_save_data; read_save_data
#==============================================================================

class Scene_File
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Write Save Data
  #       file : the file being written to
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias modalg_ats3_write_save write_save_data unless $@
  def write_save_data (file, *args)
    # Run Original Method
    modalg_ats3_write_save (file, *args)
    Marshal.dump($game_ats,         file)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Read Save Data
  #       file : the file being read from
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias modalg_ats3_read_save_data read_save_data unless $@
  def read_save_data (file, *args)
    # Run Original Method
    modalg_ats3_read_save_data (file, *args)
    begin
      $game_ats = $ats_default = Marshal.load (file) 
    rescue # Initialize if old save
      $game_ats = $ats_default = Game_ATS.new
      $game_message.clear
    end
  end
end
