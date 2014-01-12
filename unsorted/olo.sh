## .bashrc

    # \W is the basename of the working directory
    # \e[33;1m is yellow
    # the PS variables are already marked for export so export is not needed
    PS1='\[\e[33;1m\]\W\[\e[m\] ' SUDO_PS1='# ' PS2='> ' SUDO_PS2='> '

    # this is not needed in iTerm 2 or Terminal if setting locale variables automatically has not been disabled
    # the LC_ variables are not set by default so LC_ALL doesn't have to be set
    export LANG=en_US.UTF-8

    # don't replace HISTFILE with the history list of a shell when closing a shell
    # append entries in the history list to HISTFILE before displaying the prompt
    shopt -s histappend
    export PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

    # don't limit the length of HISTFILE or the length of the history lists of interactive shells
    # ~/.bash_history would get truncated when closing an interactive shell that didn't read ~/.bashrc
    export HISTFILESIZE= HISTSIZE= HISTFILE=~/.bash4_history

    # store multi-line commands as a single line
    shopt -s cmdhist

    # nocaseglob is useful with \eg (glob-complete-word)
    shopt -s extglob nocaseglob
    [[ $BASH_VERSION = 4* ]] && shopt -s globstar

    # disable completion command names when pressing tab at the start of a line
    shopt -s no_empty_cmd_completion

    # same as ignoredups:ignorespace
    export HISTCONTROL=ignoreboth

    # -j .5 changes the jump target for actions like searching to the middle of the screen
    # -c changes the way the screen is scrolled so that it is cleared and redrawn instead of scrolled one line at a time
    # -~ removes the tildes that are displayed above and below files by default
    export LESS='-j .5 -c -~'

    # LSCOLORS is used by BSD ls, which also requires CLICOLOR to be set
    # GNU ls uses LS_COLORS which has a different format
    export CLICOLOR= LSCOLORS=dxfxcxdxbxegedabagacad

    # md = mode doublebright (bold), us = underline start, so = standout
    # so is used for the line at the bottom and search highlights
    export LESS_TERMCAP_md=$'\e[31m'
    export LESS_TERMCAP_us=$'\e[32m'
    export LESS_TERMCAP_so=$'\e[44;33m'
    export LESS_TERMCAP_me=$'\e[0m'
    export LESS_TERMCAP_ue=$'\e[0m'
    export LESS_TERMCAP_se=$'\e[0m'

    # make the time builtin print only real time
    export TIMEFORMAT=%R

    # show differing lines side by side
    alias ydiff='diff -y --suppress-common-lines'

    # use prompts like >> and enable tab completion for method names
    alias irb='irb --simple-prompt -r irb/completion'

    # setting COPYFILE_DISABLE removes extended attributes, ACLs, resource forks, and file flags instead of creating ._ files
    # `COPYFILE_DISABLE= tar -x` would keep ._ files instead of converting the metadata back to native formats
    alias tarc='COPYFILE_DISABLE= tar --exclude .DS_Store -c'

    # -l prints process names in addition to pids
    # OS X's pgrep doesn't include ancestor processes (like iTerm or launchd) without -a
    alias pg='pgrep -lia'

    # `rm ~/.Trash/*` could result in an argument list too long error
    # this is faster than `osascript -e 'tell app "Finder" to empty trash` and doesn't result in an error if a file is in use
    alias et='sudo rm -rf ~/.Trash/;mkdir -p ~/.Trash/'

    # eject all removable disks
    alias eject="osascript -e 'tell app \"Finder\" to eject disks'"

    alias ll='ls -lAh'
    alias ..='c ..'
    alias ...='c ../..'
    alias ....='c ../../..'
    alias dt='c ~/Desktop'
    alias keyremap=/Applications/KeyRemap4MacBook.app/Contents/Applications/KeyRemap4MacBook_cli.app/Contents/MacOS/KeyRemap4MacBook_cli
    alias rpx='keyremap reloadxml'
    alias epx='open ~/Library/Application\ Support/KeyRemap4MacBook/private.xml'
    alias lkr='launchctl load /Library/LaunchAgents/org.pqrs.KeyRemap4MacBook.server.plist'
    alias ukr='launchctl unload /Library/LaunchAgents/org.pqrs.KeyRemap4MacBook.server.plist'
    alias ctm='cd "$(tmutil machinedirectory)"'
    alias cmtm='cd /Volumes/MobileBackups/Backups.backupdb/*/*/*/Users/$USER/'
    alias ql='qlmanage -p &> /dev/null'
    alias dkb='open ~/Library/KeyBindings/DefaultKeyBinding.dict'
    alias ssource='osascript -e "tell app \"Safari\" to source of document 1"'
    alias json='python -m json.tool|pygmentize -l javascript'
    alias tawk="awk -F$'\t' -vOFS=$'\t'"
    alias .r='. ~/.bashrc'
    alias print='printf %s\\n'
    alias python=python3 pip=pip3
    alias rd='rm -r ~/Desktop/*'
    alias resize='convert -filter lanczos2 -resize'
    alias pp=pbpaste
    alias pc=pbcopy

    c() { cd "$@"&&{ local f=(*);[[ ${#f[@]} -le 100 ]]; }&&ls; }
    mc() { mkdir "$1"&&cd "$1"; }

    # copy the last entry from the history list
    cl() { history -p '!!'|tr -d \\n|pbcopy; }

    # `tail -r` is a BSD alternative to tac
    h() { { [[ $@ ]]&&history|grep -iF -- "$@"|tail -r|awk '!a[$0]++'|tail -r||history 32; }|LC_ALL=C sed 's/ *[^ ]* *//;/^h[ $]/d'; }

    javar() { for f;do javac "$f"&&java "${f%.*}";done; }

    # without !b[$0]++ lines repeated in the file of the second argument would be printed multiple times
    only1() { awk 'NR==FNR{a[$0];next}!b[$0]++&&!($0 in a)' "$2" "$1"; }
    only2() { awk 'NR==FNR{a[$0];next}!b[$0]++&&!($0 in a)' "$1" "$2"; }
    only3() { awk 'NR==FNR{a[$0];next}!b[$0]++&&$0 in a' "$1" "$2"; }

    unfold() { awk '{if(length(x$0)>'${1-80}'){print x;x=$0}else{if(!x){x=$0}else{x=x" "$0}}}END{if(x!=$0)print x}'; }

    iuniq() { for f;do ruby -i -e 'puts readlines.uniq' "$f";done; }

    exe() { awk 'NR==1&&!/^#!/{print "#!/usr/bin/env bash\n"}1'>"$1";chmod +x "$1"; }

    # -h disables showing filename headers when multiple files are specified as arguments
    yg() { grep -hFi -- "$*" ~/Notes/{p,}study.txt; }
    sg() { grep -Fi -- "$*" ~/Sites/me/shell1.txt; }
    rg() { grep -Fi -- "$*" ~/Notes/ruby.txt; }
    bmg() { grep -hFi -- "$*" ~/Notes/{bookmarks,readinglist}.txt; }
    asg() { grep -hFi -- "$@" ~/Notes/as1line.txt ~/dir/osx/applescript.md;grep -rFi -- "$@" ~/code/applescript; }

    cf() { c "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')"; }

    # -Ib = --mime --brief
    dataurl() { echo "data:$(file -Ib "$1"|sed 's/ //g;s/;charset=binary$//');base64,$(base64 "$1")"; }

    # -C includes the cursor
    screencaps() { while :;do screencapture -C ~/Desktop/$(date +%y%m%d%H%M%S).png;sleep ${1-1};done; }

    #imagesnap saves images from a webcam
    imagesnaps() { while :;do i=1;n=~/Desktop/$(date +%y%m%d%H%M%S)-$i.png;while [[ -e $n ]];do n=${n%-*}-$((i++)).png;done;imagesnap $n;sleep ${1-0};done; }

    # search for passwords and other identity information in i.txt and copy the last field of the last matching line
    i() { grep -Ei "^$*" ~/notes/i.txt|tee >(awk 'END{print $NF}'|pbcopy); }

    bid() { osascript -e 'on run {a}' -e 'id of app a' -e end -- "${1-$(cat)}"; }

    iread() { open $(gshuf -n${1-8}) ~/notes/bookmarks.txt; }

    opl() { for f;do plutil -convert xml1 "$f";open "$f";done; }

    # `yes|hdiutil attach` bypasses license agreements
    # unar is a command line version of The Unarchiver
    x() { for f;do case "$f" in *.dmg)yes|hdiutil attach "$f";;*.mpkg|*.pkg)sudo installer -pkg "$f" -target /;;*)unar "$f">/dev/null;;esac;done;ls; }

    # I have saved `pkill -xia "$@"` as ~/bin/k so that it can be used with sudo
    q() { osascript -e 'on run args' -e 'repeat with a in args' -e 'quit app a' -e end -e end -- "$@"; }
    qo() { osascript -e 'on run {a}' -e 'quit app a' - end "$@";open -a "$@"; }

    # OS X's ps prints the absolute paths of commands without -c
    # quotes disable pattern matching on the right side of =~, like methods for escaping regex in other languages
    # `eval printf %s` removes escape sequences and quotes
    # -o filenames escapes characters like spaces
    _complete_kill() { local cword=$(eval printf %s "${COMP_WORDS[COMP_CWORD]}");IFS=$'\n' COMPREPLY=($(ps -eco comm=|while read l;do [[ $l =~ ^"$cword" ]]&&echo "$l";done)); }
    complete -o filenames -F _complete_kill killall pkill k ko pk
    _complete_quit() { local cword=$(eval printf %s "${COMP_WORDS[COMP_CWORD]}");IFS=$'\n' COMPREPLY=($(osascript -e 'set text item delimiters to linefeed' -e 'tell app "System Events" to (name of processes where background only is false) as text'|while read l;do [[ $l =~ ^"$cword" ]]&&echo "$l";done)); }
    complete -o nospace -o filenames -F _complete_quit q qo

    # print the codepoint and Unicode name of each character in $* or STDIN
    # UnicodeData.txt is from unicode.org/Public/UNIDATA/UnicodeData.txt
    # printf %x "'$char" is not supported by bash 3.2
    uni() { echo "${*-$(cat)}"|while IFS= read -r -n1 x;do awk -v "v=$(printf %04X "'$x")" -v "x=$x" -F\; '$1==""v{print x,v,$2}' ~/dir/unicode/UnicodeData.txt;done; }

    # support for \u1234 and \U12345678 was added in bash 4.2
    unig() { grep -iF -- "$*" ~/dir/unicode/UnicodeData.txt|while read l;do cp=$(printf %08x 0x${l%%;*});printf '%b;%s\n' "\U$cp" "$l";done; }

    r() { ruby -e 'def f;eval ARGV[0];end;puts f' -- "$@"; }

    # bin/f contains functions that take text as input and produce text as output
    # I also use the functions in Emacs and in OS X text views
    . ~/bin/f

## .inputrc

    # ignore case for tab completion
    set completion-ignore-case on

    # show all suggestions after pressing tab once instead of twice
    set show-all-if-ambiguous on

    # don't ask about displaying all results and don't use a pager
    set completion-query-items 0
    set page-completions off

    # don't modify the history list after editing a command selected with previous-history
    # commands selected with history-search-backward are not modified by default
    set revert-all-at-newline on

    # complete fi|l to file.txt instead of file.txtl
    # fi|.txt is still completed to file.txt.txt
    # skip-completed-text was added in bash 4.1
    set skip-completed-text on

    # don't include files that start with a period
    set match-hidden-files off

    # make option-up and option-down cycle through commands that match the start of the line
    "\e\e[A": history-search-backward
    "\e\e[B": history-search-forward

    # make option-tab and shift-tab cycle through completions
    # menu-complete-backward was added in bash 4.1
    "\e\t": menu-complete
    "\e[Z": menu-complete-backward

    # the Emacs equivalents of cut and copy
    # kill-region is bound to C-w in Emacs
    "\eq": kill-region
    "\ew": copy-region-as-kill

    # option-left and option-right
    "\e\e[C": forward-word
    "\e\e[D": backward-word

    # shell-expand-line performs shell expansions, alias expansion, and history expansion
    # I mostly use it to expand command substitutions
    # it is bound to \e\C-e by default
    "\ee": shell-expand-line

    # glob-expand-word inserts the results of a glob expression
    # it is bound to \C-x* by default
    # \eg (glob-complete-word) completes globs
    "\C-g": glob-expand-word

    # history-expand-line expands history designators like !* and !-1
    # it is bound to \e^ by default
    "\eh": history-expand-line

    # insert the zeroth and first argument
    "\em": "\e0\e."
    "\e,": "\e1\e."

    # run the previous command again and insert its output
    # \e\C-e (shell-expand-line) is used to expand the command substitution
    "\eo": "$(!!)\e\C-e"

    # replace the current line with output
    "\er": "\C-a$(\C-e)\e\C-e"

    # complete words from the history list
    # dabbrev-expand was added in bash 4.0
    "\e/": dabbrev-expand

## bitsnoop.sh

    curl -s http://www.albumoftheyear.org/ratings/27-resident-advisor-highest-rated/20{09..13}/{1..2}|sed -En 's/.*<h2.*>([^<]*)<\/a>.*/\1/p'|while read l;do curl -s http://bitsnoop.com/search/audio/$(printf %s "$l"|xxd -p|tr -d '\n'|sed 's/../%&/g')|grep torInfo|grep -v '0 / '|grep -o '/[^"]*.html' -m1;done|while read l;do curl -Ls http://bitsnoop.com$l|grep -o 'magnet:[^"]*' -m1;done|parallel open -g

## convertmusic.sh

    find ~/Music \( -name \*.pls -o -name \*.m3u \) -delete;find ~/Music -name \*.flac -o -name \*.ogg|parallel ffmpeg -y -i {} -acodec libfaac -q 250 {.}.m4a\;rm {}

## dictionarydefinitions.sh

    api=http://www.google.com/dictionary/json?callback=dict_api.callbacks.id100
    for word in aardvark zymurgy; do
      printf "$word "
      curl -s "$api&q=$word&sl=en&tl=en&restrict=pr,de" |
      sed 's/[^{]*//;s/[^}]*$//;s/\\x/\\u00/g' |
      jq -r '.primaries[0].entries|map(select(.type=="meaning"))[0].terms[0].text' 2> /dev/null
    done

    # `jq -r` uses a raw output format instead of printing the output as JSON

## f

    s() { in=$(cat);for((i=1;i<=$#;i+=2));do x=${!i};j=$((i+1));y=${!j};in=${in//"$x"/$y};done;echo "$in"; }
    r() { ruby -e 'input=STDIN.read;ARGV.each_slice(2){|x,y|input.gsub!(Regexp.new(x),y||"")};puts input' "$@"; }
    p() { while IFS= read -r l||[[ $l ]];do echo "$*$l";done; }
    a() { while IFS= read -r l||[[ $l ]];do echo "$l$*";done; }
    i() { while IFS= read -r l||[[ $l ]];do printf %${1-4}s%s\\n '' "$l";done; }
    o() { while IFS= read -r l||[[ $l ]];do echo "${l:${1-4}}";done; }
    st() { s "$(printf %${1-4}s%s\\n '')" $'\t'; }
    ts() { s $'\t' "$(printf %${1-4}s%s\\n '')"; }
    sl() { sed $'s/^[ \t]*//'; }
    sr() { sed $'s/[ \t]*$//'; }
    sb() { sed $'s/^[ \t]*//;s/[ \t]*$//'; }
    u() { awk '!x[$0]++'; }
    sortw() { tr ' \t' '\n'|grep .|sort -fn|paste -sd ' ' -;  }
    uniqw() { tr ' \t' '\n'|grep .|awk '!x[$0]++'|paste -sd ' ' -; }
    shufw() { tr ' \t' '\n'|grep .|gshuf|paste -sd ' ' -; }
    revw() { tr ' \t' '\n'|grep .|sort -r|paste -sd ' ' -; }
    sortc() { grep -o .|sort -f|tr -d \\n; }
    uniqc() { grep -o .|awk '!a[$0]++'||tr -d \\n; }
    shuf() { grep -o .|gshuf|tr -d \\n; }
    ascii() { tr -cd '\0-\177'; }
    nascii() { tr -d '\0-\177'; }
    char() { ruby -e 'puts gets(nil).scan(/[[:xdigit:]]+/).map{|c|[c.hex].pack("U")}.join("")'; }
    hexen() { ruby -e 'puts gets(nil).chars.map{|c|"&#x"+c.unpack("U*")[0].to_s(16)+";"}.join'; }
    eu() { ruby -rcgi -e 'puts CGI.escape STDIN.read'; }
    uu() { ruby -rcgi -e 'puts CGI.unescape STDIN.read'; }
    ex() { ruby -rcgi -e 'puts CGI.escapeHTML STDIN.read'; }
    ux() { ruby -rcgi -e 'puts CGI.unescapeHTML STDIN.read'; }
    amp() { sed 's/&/\&amp;/g;s/</\&lt;/g;s/>/\&gt;/g;s/"/\&quot;/g'; }
    pre() { printf '<pre>%s</pre>\n' "$(amp)"; }
    code() { printf '<code>%s</code>\n' "$(amp)"; }
    ulli() { printf '<ul>\n%s\n</ul>\n' "$(amp|sed $'s|^|<li>|;s|$|</li>|')"; }
    olli() { printf '<ol>\n%s\n</ol>\n' "$(amp|sed $'s|^|<li>|;s|$|</li>|')"; }
    href() { sed 's|.*|<a href="&">&</a>|'; }
    tabtr() { amp|sed $'s|^|<tr><td>|;s|$|</td></tr>|;s|\t|</td><td>|g'; }
    trtab() { sed $'s|^<tr[^>]*><t[dh][^>]*>||;s|</t[dh]></tr>$||;s|</t[dh]><t[dh][^>]*>|\t|'g; }
    q() { sed 's/^/> /'; }
    ul() { sed 's/^/- /'; }
    ol() { awk '{print NR". "$0}'; }
    nums() { grep -oE -- '-?[0-9]+[.,]?[0-9]*'; }
    sum() { grep -oE -- '-?[0-9]+[.,]?[0-9]*'|paste -sd + -|bc; }
    ave() { grep -oE -- '-?[0-9]+[.,]?[0-9]*'|awk '{s+=$0}END{print s/NR}'; }
    prod() { grep -oE -- '-?[0-9]+[.,]?[0-9]*'|paste -sd \* -|bc; }
    nr() { awk '{print NR,$0}'; }
    unfold() { awk '{if(length(x$0)>'${1-80}'){print x;x=$0}else{if(!x){x=$0}else{x=x" "$0}}}END{if(x!=$0)print x}'; }
    umore() { awk '{a[$0]++}END{for(i in a)if(a[i]>='$1')print i}'; }
    sbl() { awk '{print length(),$0}'|sort -nk1,1|cut -d' ' -f2-; }
    counts() { gawk '{a[$0]+=1}END{PROCINFO["sorted_in"]="@val_num_asc";for(i in a)print a[i],i}'; }
    si() { s $'\n ' $'\1'|sort -f|s $'\1' $'\n '; }
    sbfl() { ruby -e 'puts STDIN.read.split("\n\n").sort_by{|x|x.lines[0].downcase}.join("\n\n")'; }
    ns() { ruby -rnatural_sort -e 'puts NaturalSort.naturalsort(gets(nil).chomp.split("\n"))'; }
    lf() { ruby -pe '$_.sub! /\r\n?/,"\n"'; }
    base() { ruby -e 'puts STDIN.read.split.map{|n|n.to_i(ARGV[0].to_i).to_s(ARGV[1]?ARGV[1].to_i: 10)}' "$@"; }
    csv2tsv() { ruby -rcsv -e 'puts CSV.read(STDIN.read).map{|row|row.join("\t")}.join'; }
    l() { while IFS= read -r l||[[ $l ]];do curl -sG --data-urlencode q="$l" http://ajax.googleapis.com/ajax/services/search/web?v=1.0|grep -Fv '"results":[]'|sed 's/"unescapedUrl":"\([^"]*\).*/\1/;s/.*GwebSearch",//';done; }
    lin() { while IFS= read -r l||[[ $l ]];do echo "[$l]($(l<<<"$l"))";done; }
    dumb() { s “ \" ” \" ‘ \' ’ \' – - — - … ...; }
    smart() { smartypants|sed 's/&#8216;/‘/g;s/&#8217;/’/g;s/&#8220;/“/g;s/&#8221;/”/g;s/&#2013;/–/g;s/&#2014;/—/g'; }
    uc() { tr '[[:lower:]]' '[[:upper:]]'; }
    lc() { tr '[[:upper:]]' '[[:lower:]]'; }
    lcfirst() { while IFS= read -r l||[[ $l ]];do echo "${l,}";done; }
    ucfirst() { while IFS= read -r l||[[ $l ]];do echo "${l^}";done; }
    titlecase() { ruby -rtitlecase -pe '$_.titlecase!'; }
    md() { pandoc --strict|sed 's|<pre><code>|<pre>|g;s|</code></pre>|</pre>|g'|awk 'END{if(NR==1){sub(/^<p>/,"");sub(/<\/p>$/,"")};print}'; }
    hmd() { pandoc -f html -t markdown --no-wrap --atx-headers; }
    ds() { tr -d ' \t\n'; }
    promp() { sl|grep '^\$'|cut -c3-; }
    tidyx() { tidy -xml -i -wrap 0; }
    plx() { plutil -convert xml1 - -o -; }
    striptags() { php -r 'echo strip_tags(file_get_contents("/dev/stdin"));'; }
    resolve() { while read l||[[ $l ]];do curl -ILso /dev/null -w '%{url_effective}\n' "$l";done; }

## gi

    { echo '<style>img{max-width:700px;max-height:600px}</style>';seq 1 8 60|parallel -P8 curl -s -G --data-urlencode "q=${1// /+}" "https://ajax.googleapis.com/ajax/services/search/images?v=1.0\\&safe=off\\&imgsz=xlarge\\|xxlarge\\|huge\\&start="{}\|jq -r '.responseData.results[].unescapedUrl'|awk -F / '!a[$NF]++{print "<img src="$0">"}'; }>/tmp/gi.html;open /tmp/gi.html

    # the API only returns 60 results
    # `parallel -P8` runs 8 processes in parallel
    # `curl -G` sends a GET instead of a POST request
    # `awk -F / '!a[$NF]++'` prints lines where the part after the last slash has not been seen before

## lastfmsimilar.sh

    echo $'artist 1\nartist 2'|while read artist;do curl --data-urlencode "artist=$artist" -s "http://ws.audioscrobbler.com/2.0/?api_key=6bde9a7ac42b8eee41910b6e69a78062&method=artist.getsimilar"|xml sel -t -v '//name'|xml unesc;done|awk '!a[$0]++'

## lastfmtags.sh

    osascript -e 'set text item delimiters to linefeed' -e 'tell app "iTunes" to (artist of tracks of playlist "SXSW_2013_Showcasing_Artists_Part2") as text'|while read l;do curl --data-urlencode "artist=$l" -s "http://ws.audioscrobbler.com/2.0/?api_key=6bde9a7ac42b8eee41910b6e69a78062&method=artist.getTopTags"|xml sel -t -v //name|head -n4|grep -qExi 'ignored tag 1|ignored tag 2'||echo "$l";done

## osxnotes

    #!/usr/bin/env bash

    template="<!doctype html>
    <meta charset=\"utf-8\">
    <style>
    $(sed 's/&/\&amp;/g;s/</\&lt;/g;s/>/\&gt;/g' ~/dir/osx/osx.css)
    </style>
    "

    rm -f ~/sites/osx/*.html

    for f in ~/dir/osx/*.txt; do
      base=${f##*/}
      title=$(head -n1 $f|cut -c3-)
      { echo "$template<title>$title</title>"; /usr/local/bin/pandoc --strict $f; } > ~/sites/osx/${base%txt}html
      pages+="<a href=\"${base%txt}html\">$title</a><br>"$'\n'
    done

    echo "$template<title>OS X notes</title>
    $(sort -ft '>' -k2 <<< "$pages")" > ~/sites/osx/index.html

    [[ $1 = -l ]] && sleep 10; exit 0

    # this script is ran by launchd when files in ~/dir/osx/ are modified
    # launchd adds a message to system.log if a watched file is modified within 10 seconds from the last invocation
    # `pandoc --strict` acts like Markdown.pl, or for example it doesn't add IDs for headings or code spans for <> links

## readinglist.txt

    #applescript
    http://www.cs.utexas.edu/~wcook/papers/AppleScript/AppleScript95.pdf
    http://www.cs.utexas.edu/~wcook/Drafts/2006/ashopl.pdf
    http://dl.acm.org/ft_gateway.cfm?id=1238845&type=pdf&path=%2F1240000%2F1238845%2Fsupp%2FAppleScript%2Epdf&supp=1&dwn=1&CFID=334275816&CFTOKEN=16694215
    http://www.apeth.net/matt/downloads/ASTDG2Scripts.txt
    http://developer.apple.com/library/mac/#technotes/tn2065/_index.html
    http://appscript.sourceforge.net/osascript.html
    http://www.leancrew.com/all-this/2012/06/the-first-nail-in-the-coffin-of-python-appscript/
    http://developer.apple.com/library/mac/#releasenotes/AppleScript/RN-AppleScript/RN-10_5/RN-10_5.html
    http://macscripter.net/viewtopic.php?id=24737
    http://macscripter.net/viewtopic.php?id=24587
    http://stackoverflow.com/questions/13973347/how-applescript-can-get-stdin-inside-the-code
    http://support.apple.com/kb/HT5914
    http://macosxautomation.com/mavericks/guiscripting/index.html
    https://developer.apple.com/library/mac/releasenotes/AppleScript/RN-AppleScript/RN-10_9/RN-10_9.html#//apple_ref/doc/uid/TP40000982-CH109-SW1
    http://macscripter.net/viewtopic.php?id=39019

    #osx
    http://support.apple.com/kb/ht2674
    http://refit.sourceforge.net/myths
    http://superuser.com/questions/357159/osx-terminal-showing-incorrect-hostname
    http://superuser.com/questions/594023/what-does-the-default-etc-profile-on-mac-os-x-10-8-look-like
    http://apple.stackexchange.com/questions/12387/how-to-send-an-email-from-command-line/40142#40142
    http://apple.stackexchange.com/questions/6278/how-to-securely-erase-an-ssd-drive
    http://www.insanelymac.com/forum/topic/99891-osx-flags-list-for-darwin-bootloader-kernel-level/
    https://github.com/mxcl/homebrew/wiki
    http://superuser.com/questions/295151/mac-os-x-is-there-a-straightforward-way-to-color-ls-output-according-to-finder
    http://superuser.com/questions/370622/how-is-load-average-calculated-on-osx-it-seems-too-high-and-how-do-i-analyze
    http://superuser.com/questions/279891/list-all-members-of-a-group-mac-os-x
    http://help.bombich.com/kb/advanced-strategies/the-disk-center
    http://images.apple.com/osx/preview/docs/OSX_Mavericks_Core_Technology_Overview.pdf
    http://support.apple.com/kb/HT5606
    https://developer.apple.com/library/mac/#technotes/tn2083/_index.html
    http://superuser.com/questions/302754/increase-the-maximum-number-of-open-file-descriptors-in-snow-leopard
    http://apple.stackexchange.com/questions/61901/is-t-there-a-way-to-load-a-launchagent-as-another-user
    https://developer.apple.com/releasenotes/MacOSX/WhatsNewInOSX/Articles/MacOSX10_8.html
    http://blog.macromates.com/2012/nested-replacements/
    http://ridiculousfish.com/blog/posts/The-app-that-was-fixed-by-a-crash.html
    http://code.google.com/p/iterm2/wiki/Keybindings
    http://developer.apple.com/library/mac/#documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/CreatingLaunchdJobs.html
    http://web.archive.org/web/20061017080159/http://developer.apple.com/macosx/launchd.html
    https://dl.dropbox.com/u/46870715/s/m10lmac8.html
    http://lists.apple.com/archives/darwin-dev/2011/Mar/msg00036.html
    http://arstechnica.com/apple/2005/04/macosx-10-4/6/
    http://sourceforge.net/apps/mediawiki/skim-app/index.php?title=FAQ
    http://support.apple.com/kb/ht1379
    http://cansecwest.com/csw09/csw09-daizovi-miller.pdf
    http://www.frameloss.org/2011/09/05/cracking-macos-lion-passwords/
    https://github.com/mxcl/homebrew/wiki/FAQ
    http://www.hcs.harvard.edu/~jrus/Site/Cocoa%20Text%20System.html
    http://wiki.freegeek.org/index.php/Mac_Commandline_Tools
    http://stevelosh.com/blog/2012/10/a-modern-space-cadet/
    http://aplawrence.com/MacOSX/acl.html
    http://triviaware.com/macprocess/all
    http://training.apple.com/pdf/wp_osx_security.pdf
    http://support.apple.com/kb/ht5394
    http://rixstep.com/2/2/20070718,00.shtml
    http://www.wsanchez.net/papers/USENIX_2000/
    https://docs.google.com/spreadsheet/ccc?key=0AkBdGlxJhW-ydDlxVUxWUVU0dXVzMzUxRzh2b2ZzaFE
    http://apple.stackexchange.com/questions/5165
    http://superuser.com/questions/202814/what-is-an-equivalent-of-the-adduser-command-on-mac-os-x
    http://onlyinhopesofdreaming.blogspot.fi/2013/07/command-line-favorites-1.html
    http://en.wikipedia.org/wiki/HFS_Plus
    http://apple.stackexchange.com/questions/98389/in-disk-utility-what-advantages-do-read-write-disk-images-have-over-sparse-b
    https://github.com/osxfuse/osxfuse/wiki/FAQ
    http://apple.stackexchange.com/questions/87282/in-mountain-lion-how-do-i-set-the-path-environment-variable-unified-for-all-newl
    https://developer.apple.com/legacy/library/technotes/tn/tn1150.html#//apple_ref/doc/uid/DTS10002989
    http://derflounder.wordpress.com/2012/07/25/using-fdesetup-with-mountain-lions-filevault-2/
    http://superuser.com/questions/134864/log-of-cron-actions-on-os-x
    http://apple.stackexchange.com/questions/46253/what-is-the-best-way-to-clone-a-disk-between-two-macs
    http://lists.apple.com/archives/filesystem-dev/2012/Feb/msg00015.html
    http://filexray.com/fileXray.pdf
    http://osxbook.com/blog/
    http://dubeiko.com/development/FileSystems/HFSPLUS/tn1150.html
    http://superuser.com/questions/176361/mount-external-usb-drive-in-single-user-mode
    http://hea-www.harvard.edu/~fine/OSX/path_helper.html
    http://apple.stackexchange.com/a/104099
    http://support.apple.com/kb/HT1757
    http://arstechnica.com/apple/2011/07/mac-os-x-10-7/12/#hfs-problems
    http://hints.macworld.com/article.php?story=20090902223042255
    http://ilostmynotes.blogspot.de/2012/06/gatekeeper-xprotect-and-quarantine.html
    http://arcticmac.home.comcast.net/~arcticmac/tutorials/gdbFindingPrefs.html
    http://api.stackexchange.com/2.1/users/427/answers?pagesize=100&order=desc&sort=activity&site=apple&filter=!bFN2MqFu-JdrhV
    http://osxbook.com/blog/2009/03/02/why-macfuse-installation-recommends-a-reboot/
    http://furbo.org/2013/10/17/code-signing-and-mavericks/
    http://www.onthelambda.com/2013/10/14/the-state-of-package-management-on-mac-os-x/
    https://developer.apple.com/library/mac/documentation/carbon/conceptual/spotlightquery/concepts/queryformat.html
    http://superuser.com/questions/509990/how-do-i-revert-to-having-sudo-ask-for-a-password-again
    http://stackoverflow.com/questions/1715580/how-to-discover-number-of-cores-on-mac-os-x
    https://gist.github.com/cobyism/6839439
    http://arstechnica.com/apple/2013/10/os-x-10-9/15/
    http://apple.stackexchange.com/a/106942
    http://apple.stackexchange.com/questions/107292/adding-apps-to-security-privacy-settings-automatically
    http://c-command.com/dropdmg/manual-ah/format
    http://www.tonymacx86.com/374-unibeast-install-os-x-mavericks-any-supported-intel-based-pc.html
    http://www.rodsbooks.com/ubuntu-efi/
    https://developer.apple.com/library/mac/releasenotes/MacOSX/WhatsNewInOSX/Articles/MacOSX10_9.html#//apple_ref/doc/uid/TP40013207-SW14
    http://ntk.me/2012/09/07/os-x-on-os-x/
    http://hints.macworld.com/article.php?story=20130908042828630
    http://apple.stackexchange.com/questions/107292/adding-apps-to-security-privacy-settings-automatically/107293#107293
    http://stackoverflow.com/questions/4892555/how-to-capture-frames-from-apple-isight-using-python-and-pyobjc
    http://apple.stackexchange.com/questions/55780/how-can-i-tell-which-application-is-using-the-network
    https://developer.apple.com/library/mac/documentation/performance/conceptual/managingmemory/articles/aboutmemory.html

    #other
    http://throwingfire.com/storing-passwords-securely
    http://ridiculousfish.com/blog/posts/colors.html
    http://ridiculousfish.com/blog/posts/float.html
    http://lucumr.pocoo.org/2012/10/18/such-a-little-thing/
    http://www.cs.utexas.edu/users/EWD/ewd08xx/EWD831.PDF
    http://chrisdone.com/z/
    http://matt.might.net/articles/grammars-bnf-ebnf/
    http://jeremykun.com/2013/01/22/depth-and-breadth-first-search/
    http://www.openwall.com/presentations/Passwords12-The-Future-Of-Hashing/
    http://www.gnu.org/software/emacs/tour/
    http://blog.zorinaq.com/?e=74
    http://www.wall.org/%7Elarry/natural.html
    http://en.wikipedia.org/wiki/Perl_Compatible_Regular_Expressions
    http://www.cl.cam.ac.uk/~mgk25/unicode.html
    http://unicode.org/reports/tr15/
    http://www.unicode.org/faq/normalization.html
    http://blog.macromates.com/2005/handling-encodings-utf-8/
    https://github.com/jgm/pandoc/wiki/Pandoc-vs-Multimarkdown
    http://johnmacfarlane.net/pandoc/README.html
    http://docs.python.org/2/tutorial/stdlib2.html
    http://norvig.com/mayzner.html
    http://books.google.com/ngrams/info
    http://www.cambridgeincolour.com/tutorials/color-space-conversion.htm
    http://cameratico.com/guides/web-browser-color-management-guide/
    https://trac.handbrake.fr/wiki/Containers
    https://trac.handbrake.fr/wiki/Encoders
    http://www-formal.stanford.edu/jmc/recursive.pdf
    http://calculus.seas.upenn.edu/
    http://en.wikipedia.org/wiki/C0_and_C1_control_codes
    http://unix.stackexchange.com/questions/36841/why-is-number-of-open-files-limited-in-linux
    http://cm.bell-labs.com/cm/cs/who/dmr/retro.html
    http://www.pathname.com/fhs/pub/fhs-2.3.html
    http://www.textfiles.com/programming/25th_ann.uni
    http://www.freebsd.org/doc/en/articles/explaining-bsd/article.html
    http://csapp.cs.cmu.edu/public/docs/chistory.html
    http://www.norvig.com/python-lisp.html
    http://www.i2p2.de/how_intro
    http://en.wikipedia.org/wiki/Inverse_trigonometric_functions
    http://slhck.info/video-encoding.html
    https://en.wikipedia.org/wiki/Berkeley_Software_Distribution
    http://pubs.opengroup.org/onlinepubs/9699919799/frontmatter/preface.html
    http://stackoverflow.com/questions/1911022/what-are-all-the-html-escaping-contexts
    https://en.wikipedia.org/wiki/XML
    http://pubs.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap03.html
    http://tools.ietf.org/html/rfc20
    https://en.wikipedia.org/wiki/Cryptographic_hash_function
    http://www.unicode.org/faq/utf_bom.html
    http://www.w3schools.com/xpath/xpath_syntax.asp
    http://ejohn.org/blog/xpath-css-selectors/
    https://en.wikipedia.org/wiki/Mathematical_logic
    http://serverfault.com/questions/282555/zeroing-ssd-drives
    http://static.usenix.org/events/fast11/tech/full_papers/Wei.pdf
    http://www.opengroup.org/austin/docs/austin_236.txt
    http://www.validlab.com/goldberg/paper.pdf
    http://www.gnu.org/licenses/rms-why-gplv3.html
    http://publicbt.com/
    https://hsivonen.fi/Unicode.pdf
    http://www.cl.cam.ac.uk/~mgk25/ucs/wcwidth.c
    http://www.cl.cam.ac.uk/~mgk25/metric-typo/
    http://www.cl.cam.ac.uk/~mgk25/iso-paper.html
    https://en.wikipedia.org/wiki/ISO_216

    #ruby
    https://github.com/styleguide/ruby
    http://benoithamelin.tumblr.com/ruby1line
    http://benoithamelin.tumblr.com/post/10945200630/text-processing-1liners-ruby-vs-awk
    http://tomayko.com/writings/awkward-ruby
    http://blog.grayproductions.net/articles/the_kcode_variable_and_jcode_library
    http://blog.grayproductions.net/articles/ruby_19s_string
    http://furious-waterfall-55.heroku.com/ruby-guide/internals/gc.html
    http://www.rubyinside.com/21-ruby-tricks-902.html
    http://www.geocities.jp/kosako3/oniguruma/doc/RE.txt
    https://gist.github.com/matsadler/4001581
    https://raw.github.com/k-takata/Onigmo/master/doc/RE
    http://stackoverflow.com/questions/1352120/how-to-break-outer-cycle-in-ruby

    #shell
    https://ffmpeg.org/trac/ffmpeg/wiki/x264EncodingGuide
    http://superuser.com/questions/578321/how-to-flip-a-video-180-vertical-upside-down-with-ffmpeg/578329#578329
    http://www.brendangregg.com/dtrace.html
    http://pubs.opengroup.org/onlinepubs/009696799/utilities/echo.html
    http://unix.stackexchange.com/questions/78990/what-are-the-readline-word-separators
    http://code.google.com/p/gnups/wiki/WhypsSucks
    http://www.imagemagick.org/Usage/resize/
    http://unix.stackexchange.com/questions/65803/why-is-printf-better-than-echo
    http://www.catonmat.net/blog/set-operations-in-unix-shell/
    http://briancarper.net/blog/248/
    http://code.dogmap.org/lintsh/
    http://psychiatry.igm.jhmi.edu/wiki/index.php/AWK
    http://mywiki.wooledge.org/Bashism
    http://pubs.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html
    http://www.leancrew.com/all-this/2012/11/ssh-tunneling-redux/
    http://www.drbunsen.org/explorations-in-unix.html
    http://unix.stackexchange.com/questions/74197/how-to-unset-range-of-array-in-bash
    http://ridiculousfish.com/shell/faq.html
    http://ridiculousfish.com/shell/user_doc/html/
    http://victorquinn.com/blog/2011/06/20/tmux/
    http://mywiki.wooledge.org/NullGlob
    http://www.veen.com/jeff/archives/000573.html
    http://zagaeski.devio.us/0006.html
    http://www.gnu.org/software/wget/manual/wget.html
    http://www.etalabs.net/sh_tricks.html
    http://mywiki.wooledge.org/BashPitfalls
    http://mywiki.wooledge.org/BashGuide/Practices
    http://blog.macromates.com/2008/working-with-history-in-bash/
    http://blog.macromates.com/2005/shell-variables/
    http://matt.might.net/articles/sculpting-text/
    http://matt.might.net/articles/ssh-hacks/
    http://www.grymoire.com/Unix/Sed.html
    http://www.greenwoodsoftware.com/less/faq.html
    http://cnswww.cns.cwru.edu/php/chet/readline/rluserman.html
    http://www.opengroup.org/austin/papers/posix_faq.html
    https://wiki.ubuntu.com/DashAsBinSh
    http://tiswww.case.edu/php/chet/bash/FAQ
    http://tldp.org/LDP/abs/html/bashver4.html
    http://ss64.com/bash/syntax-inputrc.html
    http://anonscm.debian.org/gitweb/?p=bash-completion/bash-completion.git;a=blob_plain;f=README
    http://www.catonmat.net/blog/the-definitive-guide-to-bash-command-line-history/
    http://www.catonmat.net/blog/bash-one-liners-explained-part-three/
    http://ss64.com/bash/shopt.html
    http://mywiki.wooledge.org/Quotes
    http://www.cybertux.nl/diversen/gnuplot/basic_gnuplot.html
    http://www.pantz.org/software/cron/croninfo.html
    http://www.norbauer.com/rails-consulting/notes/ls-colors-and-terminal-app.html
    http://www.in-ulm.de/~mascheck/various/echo+printf/
    http://martin.kleppmann.com/2013/05/24/improving-security-of-ssh-private-keys.html
    http://ffmpeg.org/faq.html
    http://blog.superuser.com/2011/11/07/video-conversion-done-right-codecs-and-software/
    http://blog.superuser.com/2012/02/24/ffmpeg-the-ultimate-video-and-audio-manipulation-tool/
    http://wiki.bluewallmedia.com/index.php?title=FFMPEG_command_strings
    http://www.in-ulm.de/~mascheck/various/argmax/
    http://yash.sourceforge.jp/doc/posix.html
    http://www.gnu.org/software/coreutils/faq/coreutils-faq.html
    http://partmaps.org/era/unix/shell.html
    http://unix.stackexchange.com/questions/78408/which-is-more-idiomatic-in-a-bash-script-true-or
    http://www.gnu.org/software/bash/manual/html_node/Bash-POSIX-Mode.html
    http://zsh.sourceforge.net/FAQ/zshfaq02.html#l9
    http://apple.stackexchange.com/questions/24261
    http://en.wikipedia.org/wiki/Caret_notation
    http://mywiki.wooledge.org/BashFAQ/026
    http://unix.stackexchange.com/questions/86270/how-do-you-use-the-command-coproc-in-bash
    https://raw.github.com/lhunath/scripts/master/bash/bashlib/bashlib
    http://mywiki.wooledge.org/BashFAQ/035
    http://mywiki.wooledge.org/BashFAQ/031
    http://pubs.opengroup.org/onlinepubs/009695399/utilities/test.html
    http://en.wikipedia.org/wiki/Unix_signal
    http://unix.stackexchange.com/questions/85249/why-not-use-which-what-to-use-then/85250#85250
    http://www.gnu.org/software/gawk/manual/gawk.html
    http://xmlstar.sourceforge.net/doc/xmlstarlet.txt
    http://mywiki.wooledge.org/DotFiles
    https://rvm.io/support/faq#what-shell-login-means-bash-l
    https://github.com/janmoesen/tilde/blob/master/.wgetrc
    http://stackoverflow.com/questions/6973088/longest-common-prefix-of-two-strings-in-bash
    http://unix.stackexchange.com/questions/87445/changing-column-separators-in-a-file/87447#87447
    http://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
    http://superuser.com/questions/218340/how-to-generate-a-valid-random-mac-address-with-bash-shell
    http://unix.stackexchange.com/questions/44836/when-sh-is-a-symlink-to-bash-or-dash-bash-limits-itself-to-posix-compliance-so/48925#48925
    http://www.unix.org/whitepapers/shdiffs.html
    http://pubs.opengroup.org/onlinepubs/009695399/utilities/awk.html
    http://unix.stackexchange.com/questions/73750/difference-between-function-foo-and-foo/73854#73854
    https://trac.ffmpeg.org/wiki/GuidelinesHighQualityAudio
    http://www.gnu.org/software/coreutils/manual/html_node/sort-invocation.html
    http://wiki.bash-hackers.org/scripting/bashchanges
    http://tiswww.case.edu/php/chet/bash/CHANGES
    http://wiki.bash-hackers.org/bash4
    http://git.savannah.gnu.org/cgit/bash.git/tree/CHANGES?id=bash-4.3-beta2
    http://tiswww.case.edu/php/chet/bash/COMPAT
    http://api.stackexchange.com/2.1/users/22565/answers?pagesize=100&order=desc&sort=activity&site=unix&filter=!bFN2MqFu-JdrhV
    http://unix.stackexchange.com/a/90884
    http://stackoverflow.com/questions/4336035/performance-profiling-tools-for-shell-scripts
    http://lists.freebsd.org/pipermail/freebsd-current/2010-August/019310.html
    http://git.savannah.gnu.org/cgit/grep.git/tree/NEWS
    http://en.wikipedia.org/wiki/ANSI_escape_code
    http://pubs.opengroup.org/onlinepubs/9699919799/utilities/stty.html
    http://www.gnu.org/software/coreutils/manual/coreutils.html
    http://mywiki.wooledge.org/BashFAQ/071
    http://mywiki.wooledge.org/BashFAQ/085
    http://cfajohnson.com/shell/articles/dynamically-loadable/
    http://mywiki.wooledge.org/BashFAQ/091
    http://mywiki.wooledge.org/BashFAQ/105
    http://unix.stackexchange.com/questions/76049/what-is-the-difference-between-sort-u-and-sort-uniq
    http://www.pdflabs.com/docs/pdftk-cli-examples/
    http://www.itbroadcastanddigitalcinema.com/ffmpeg_howto.html
    https://trac.ffmpeg.org/wiki/EncodeforYouTube
    http://invisible-island.net/xterm/ctlseqs/ctlseqs.html
    http://pubs.opengroup.org/onlinepubs/9699919799/utilities/xargs.html
    http://www.johndcook.com/blog/2010/07/14/bc-math-library/
    http://www.pement.org/sed/sedfaq.txt
    http://www.pement.org/awk/awkuse.txt
    http://www.pement.org/awk/awktail.txt
    http://explainshell.com/explain?cmd=iptables%20-A%20INPUT%20-i%20eth0%20-s%20ip-to-block%20-j%20DROP
    http://stedolan.github.io/jq/tutorial/
    http://www.vt100.net/docs/vt100-ug/chapter3.html#ED

    #web
    http://developers.whatwg.org/introduction.html
    http://www.internoetics.com/2012/07/18/retrieve-images-from-the-depreciated-google-images-api/
    http://www.mnot.net/cache_docs/
    http://www.imperialviolet.org/2012/07/19/hope9talk.html
    http://www.w3.org/html/wg/drafts/html/master/text-level-semantics.html#the-kbd-element
    https://tech.dropbox.com/2012/10/caching-in-theory-and-practice/
    http://calendar.perfplanet.com/2011/why-inlining-everything-is-not-the-answer/
    http://www.igvita.com/2012/12/18/deploying-new-image-formats-on-the-web/
    http://www.igvita.com/posa/high-performance-networking-in-google-chrome/
    https://developers.google.com/speed/docs/insights/rules
    http://dev.chromium.org/spdy/spdy-whitepaper
    http://www.igvita.com/2012/07/19/latency-the-new-web-performance-bottleneck/
    https://developers.google.com/speed/articles/
    http://www.w3.org/TR/html5/text-level-semantics.html#the-i-element
    https://github.com/csswizardry/CSS-Guidelines/blob/master/CSS%20Guidelines.md
    http://nthmaster.com/
    http://mathiasbynens.be/notes/inline-vs-separate-file
    http://snook.ca/archives/html_and_css/font-size-with-rem
    http://nicolasgallagher.com/micro-clearfix-hack/
    http://trac.webkit.org/browser/trunk/Source/WebCore/css/html.css
    http://meyerweb.com/eric/thoughts/2006/02/08/unitless-line-heights/
    http://quirksmode.org/css/css2/tables.html
    http://www.ecma-international.org/ecma-262/5.1/
    https://tools.ietf.org/rfc/rfc1945.txt
    http://www.ietf.org/rfc/rfc1738.txt
    https://rawgithub.com/whatwg/html-differences/master/Overview.html
    http://stackoverflow.com/questions/2526033/why-specify-charset-utf-8-in-your-css-file/2526487#2526487
    https://raw.github.com/ntkme/markdown.css/master/markdown.css
    http://stackoverflow.com/questions/11006812/html5-boilerplate-meta-viewport-and-width-device-width
    https://docs.google.com/present/view?id=dkx3qtm_22dxsrgcf4
    https://developer.mozilla.org/en-US/docs/Mozilla/Mobile/Viewport_meta_tag

## ruby.txt

    n = [0, 2]; [7, 8, 9].values_at(*n) # [7, 9]
    Array.new(2, Array.new(2)) # [[nil, nil], [nil, nil]]
    Array.new(2, Hash.new) # [{}, {}]
    puts %w(A C G T).repeated_permutation(4).map(&:join)
    [1, 2, 3].repeated_combination(2).to_a # [[1, 1], [1, 2], [1, 3], [2, 2], [2, 3], [3, 3]]
    [[1, 2], [3, 4], [5, 6]].transpose[0] # [1, 3, 5]
    [1, 2] & [1] # [1]
    [3, 1] | [1, 2] # [3, 1, 2]
    [1, 2, 3, 4, 5].each_slice(2).to_a # [[1, 2], [3, 4], [5]]
    a = [1, 2, 3, 4, 5]; a.shift(2); a # [3, 4, 5]
    a = [1, 2]; a.unshift(0); a # [0, 1, 2]
    [1, nil].compact # [1]
    [[0, 0], [0, 1], [1, 2]].uniq { |e| e[0] } # [[0, 0], [1, 2]]
    [8, 9] * 2 # [8, 9, 8, 9]
    [8, 9] * ", " # an alternative to [8, 9].join(", ")
    a = [54, -2, 23]; a.inject(:+).to_f / a.size # 25.0
    a = [4, 5, 6]; a.delete_at(1); p a # [4, 6]
    [[3], [1, 2]].flatten # [3, 1, 2]
    ["aa", "bb"].grep(/^a/) # ["aa"]
    [1.2, "three", 4].grep(Fixnum) # [4]
    require "csv"; CSV.read("input.csv").map { |row| row.join("\t") }.join("\n")
    CSV.parse("1,2\n3,4").map { |row| row.to_csv(:col_sep => ";") }.join
    IO.readlines("input.tsv").map { |l| l.split("\t").values_at(2, 3) }
    CSV.parse("field1,field2\n001,aa\n002,bb\n", headers: true).each { |r| print r["field2"] }
    Time.now.to_i # seconds since epoch
    "%.3f" % Time.now # time with milliseconds
    Time.at(123467890)
    require "date"; Date.parse("2013-09-07").month # 9
    require "time"; Time.parse("2013-01-13 15:55:13 +0200")
    Date.new(2012).leap? # true
    File.write("file", "text\n") # 1.9.3 and later
    IO.open("file", "w") { |f| f.puts("text") } # 1.8
    File.open("file", "a") { |f| f.puts("text") } # append
    File.write("file", "") # make a file empty (1.9.3 and later)
    f = File.open("file", "w"); f.truncate(0); f.close # make a file empty
    Dir.home # alternative to ENV['HOME'] in 1.9 and later
    FileUtils.rm(Dir["*.html"])
    FileUtils.mkdir_p("a/b")
    File.basename("/folder/file.txt", ".txt") # "file"
    File.basename("file.txt", ".*") # "file"
    IO.open("utf16.txt", "r:UTF-16:UTF-8")
    Dir["*.txt"].map { |f| File.size(f) }.inject(:+)
    Dir["#{Dir.home}/dir/**/*.txt"].each { |f| IO.write(f, IO.read(f).gsub("aa", "bb")) }
    Dir.chdir(File.dirname(__FILE__)) # cd to the directory of a script
    Dir.chdir(__dir__) # 2.0 and later
    IO.open("file", "w") # make a file empty
    File.mtime(".").strftime("%F") # "2013-09-07"
    require "pathname"; Pathname.new(".").realpath # absolute path
    puts Dir["*"].sort_by { |f| File.mtime(f) }[0]
    File.open("file.txt").gets # first line
    require "pp"; pp hash # pretty print a hash
    {a: 1}.key(1) # :a
    {a: 1}.invert # {1=>:a}
    Hash[1, 2, 3, 4] # {1=>2, 3=>4}
    Hash[IO.readlines("input.tsv").map { |l| l.split("\t").values_at(0, 5) }]
    a = [1, 2, 3, 4]; Hash[*a] # {1=>2, 3=>4}
    h = {a: 11, b: 1, c: 2}; Hash[h.sort_by { |k, v| v.to_i }] # {:b=>1, :c=>2, :a=>11}
    {"a"=>1}.merge({"b"=>2}) # {"a"=>1, "b"=>2}
    h = Hash.new(0); h["a"] += 5; h # {"a"=>5}
    h = Hash.new { |x, k| x[k] = [] }; h["k"] << "aa"; h["k"] << "bb"; h # {"k"=>["aa", "bb"]}
    a = [2, 2, 3, 4, 4]; h = Hash.new(0); a.each { |v| h[v] += 1 }; h.select { |v, c| c == 2 }.keys # [2, 4]
    h = {}; %w(aa bb).each { |v| (h["k"] ||= []) << v }; h # {"k"=>["aa", "bb"]}
    h = {}; %w(aa bb).each { |v| (h["k"] ||= []) << v }; h # {"k"=>"aabb"}
    {"x"=>1,"y"=>2}.flatten # ["x", 1, "y", 2]
    {"x":1}.has_value?(1) # true
    {"x"=>1,"y"=>2,"z"=>2}.assoc(2) # nil
    {"x"=>1,"y"=>2,"z"=>2}.rassoc(2) # ["y", 2]
    Hash[[:x, :y].zip([1, 2])] # {:x=>1, :y=>2}
    require "json"; JSON.load('{"a":[1,2],"b":"c"}')
    JSON.parse("\\u003Cp\\u003E") # "<p>"
    JSON.pretty_generate(json) # pretty print JSON
    Nokogiri.XML("<a type='2'><b>c</b></a>").css("a[type='2'] b").to_s # "<b>c</b>"
    x = Nokogiri::XML::DocumentFragment.parse("<a>1</a><b>2</b>"); x.at_css("a").content = "3"; x.to_xml
    Math.log(Math::E**3) # 3.0
    [2, -3.abs].min
    (1..n).inject(:*) || 1 # factorial
    a.inject(:+).to_f / a.size # arithmetic mean
    a.inject(:*).to_f ** (1.0 / a.size) # geometric mean
    a.size.to_f / a.map { |n| 1.0 / n }.inject(:+) # harmonic mean
    (a.map { |n| n ** 2 }.inject(:+).to_f / a.size) ** 0.5 # RMS
    (32768 ** (1.0 / 3)).round # 32 (cube root)
    (32768 ** (1.0 / 3)) # 31.999999999999993
    Integer::natural.select { |x| x**2 % 5 == 0 }.take(10).inject(:+) # 275
    rand(6) + 1 # random number between 1 and 6
    [1, 2, 3].sample(2) # two random elements in random order
    rand 2 # 0 or 1
    4.times.map { rand(1000) } # 4 random numbers between 0 and 999
    ("a"..."c") === "b" # true
    ("a".."c").cover?("bb") # true (bb is sorted between a and c)
    ("a".."e").step(2).to_a # ["a", "c", "e"]
    1.upto(10) { |i| print i if (i == 4)..(i == 6) } # 456
    [*0..2] # [0, 1, 2]
    /(?<=<b>).*(?=<\/b>)/ # lookbehind is one character longer than lookahead
    "aabc" =~ /b/; $` # "aa"
    /b/.match("aabc").pre_match # "aa"
    "11 11".gsub(/^| /, "2") # 211211 ([ ^] can't be used)
    "aa,bb,cc".gsub(/(?<=,|^)(.*?)(?=,|$)/, "a") # a,a,a
    gsub(/^\s+|\s+$/, "") # strip all lines
    "string to convert to titlecase".gsub(/\b\w/) { $&.upcase }
    Regexp.new(Regexp.escape("pattern"), "i")
    "xyz".gsub(/[xyz]/, "x" => 1, "z" => 2) # "1y2"
    system("echo", "a")
    IO.popen(["echo", "a"]).read
    IO.popen("tr y z", "w") { |io| io.puts "xyz" }
    IO.popen(["tr", "y", "z"], "w") { |io| io.puts "xyz" }
    IO.popen("tr y z", "r+") { |io| io.puts("xyz"); io.close_write; io.read }
    "\u{1234}".size # 1 in 1.9 and 2 in 1.8
    ["1234".hex].pack("U").scan(/./mu).size # 1 in both 1.9 and 1.8
    "z".ord.to_s(16) # "7a" (1.9)
    "%04x" % "z".unpack("U*")[0] # "7a" (1.8)
    "abb".index("b") # 1
    "abb".rindex("b") # 2
    s = "abb"; s["bb"] = "c"; s # "ac"
    s = "ab"; s["cd"] # nil
    "xxy".count("x") # 2
    "aa".rjust(4) # "  aa"
    "aa".center(5, "-") # "-aa--"
    "az".next # "ba"
    "a\t".split("\t") # ["a"]
    "a\t".split("\t", 2) # ["a", ""]
    "xaxbxx".split("x") # ["", "a", "b"]
    "xaxbxx".scan(/(?<=(?:x|^))[^x]*/) # ["", "a", "b", "", ""]
    "\ta\n  b".split # ["a", "b"]
    "a\u{5b57}".codepoints.to_a # [97, 23383]
    "abc".tr("ac", "AC") # "AbC"
    "a\nb\n".lines.map(&:chomp) # ["a", "b"]
    "<b>aa</b>"[/<b>(.*?)<\/b>/, 1] # "aa"
    [1, 2, 3, 4, 5].take(2) # [1, 2]
    [1, 2, 3, 4, 5].last(2) # [4, 5]
    [1, 2, 3, 4, 5].drop(2) # [3, 4, 5] (shift returns the removed elements)
    [1, 2].map(&:to_s) # ["1", "2"]
    [2, 3, 4].inject(:+) # 9 (1.9 and later)
    [2, 3, 4].inject(:*) # 24 (1.9 and later)
    [2, 3, 4].inject { |sum, x| sum + x } # 9
    [2, 3, 4].inject(1) { |prod, x| prod * x } # 24
    [1, 3].all? { |x| x.odd? } # true
    enum = [1, 2].each; p enum.next # 1
    enum = Enumerator.new { |y| y << 1 }; p enum.next # 1
    enum = "x".enum_for(:each_byte); enum.each { |b| p b } # 120
    p [1, 2].cycle.take(5) # [1, 2, 1, 2, 1]
    3.times.map { |n| "file_#{n}" } # ["file_0", "file_1", "file_2"]
    %w(x y z).select.with_index { |e, i| i.even? } # ["x", "z"]
    (1..6).group_by { |i| i % 3 } # {0=>[3, 6], 1=>[1, 4], 2=>[2, 5]}
    (0.2..0.6).step(0.2).to_a # [0.2, 0.4, 0.6]
    ["aa", "bb"].inject(0) { |sum, e| sum + e.length } # 4
    [11, 2, "b", "a"].partition { |x| x.is_a? String }.map(&:sort).flatten # ["a", "b", 2, 11]
    chars = [*"a".."z", *"0".."9"]; Array.new(6).map { chars.sample }.join
    "%3i" % 9 # "  9"
    "%-3s" % "a" # "  a"
    "%03i" % 9 # "009"
    "%02x" % 10 # "0a"
    "%b" % 6 # 110 (%b is binary, not backslash-escape)
    ["11 a", "2 b"].sort_by { |s| s[/^\d+/].to_i }
    raise ArgumentError, "Invalid argument"
    raise IndexError, "Out of range"
    $: # $LOAD_PATH
    abort "error" # STDERR.puts "error"; exit 1
    input = STDIN.read if STDIN.stat.size > 0
    sub(/\A\n*/m, "").sub(/\n*\Z/m, "\n")
    gsub(/[^\0-\177]/, "")
    puts "\033[1mbold\033[mnormal"
    !(a && b) == (!a || !b) && !(a || b) == (!a && !b) # de Morgan's laws
    p x # puts x.inspect
    Array.instance_methods.sort - Array.ancestors.map { |a| a == Array ? [] : a.instance_methods }.flatten
    Symbol.all_symbols
    Kernel.is_a?(Module) # true
    answer = `read -n1 -p "Continue? (y/n) " a; printf %s "$a"`; puts; exit unless answer == "y"
    trap('EXIT') { exit 0 }
    require "sqlite3"; SQLite3.Database.new("file.db").execute("SELECT * FROM data")
    require "securerandom"; SecureRandom.uuid
    [8, 4, 4, 4, 14].map { |n| rand(16**n).to_s(16) }.join("-") # faster than actually generating UUIDs
    __END__ # use the rest of the file for the DATA IO object or ignore the rest of the file
    __FILE__ == $0 # test if the script is run directly
    "a\nb\n".lines # ["a\n", "b\n"] (was an enumerator before 2.0)
    %i(a b) # [:a, :b]
    loop.size # Float::INFINITY in 2.0
    __dir__ # a shorter alternative to File.dirname(__FILE__) in 2.0
    (1..100).bsearch { |i| i > 38 }
    [1, 2].lazy.cycle.map { |x| x * 10 }.take(3).to_a # [10, 20, 10]
    "a\nb\rc\v".gsub(/\R/, "") # "abc" (\R is linebreak)
    IO.foreach("input.tsv").map { |l| l[/[^\t]+/] }
    "a".encoding.name # "UTF-8"
    Encoding.list # encoding names
    IO.read("input.md").scan(/^## (.*?)\n\n(.*?)(?=\n\n\#\#)/m).each { |s| IO.write(s[0] + ".md", s[1] + "\n") }
    require "google-search"; Google::Search::Image.new(:query => "query", :safety_level => :none, :image_size => :xxlarge)
    IO.readlines("file.tsv").sort_by{|l|l.split("\t")[2]}

## setags.rb

    require "json"

    api = "https://api.stackexchange.com/2.1/"
    output = "<link rel=stylesheet href=seusers.css>"

    query = "search?sort=votes&tagged=css&site=stackoverflow&pagesize=100&page=1&filter=!--btTLjK5ZsZ"
    ids = JSON.parse(`curl -s --compressed '#{api}#{query}'`)["items"].map { |q| q["question_id"] }

    query = "questions/#{ids.join(";")}/answers?sort=votes&site=stackoverflow&pagesize=100&filter=!--btTLjIVxsJ"
    JSON.parse(`curl -s --compressed '#{api}#{query}'`)["items"].each { |answer|
      output << "<h2><a href=\"#{answer["link"]}\">#{answer["title"]}</a></h2>#{answer["body"]}\n"
    }

    IO.write("se.html", output)
    `open se.html`

## seusers.rb

    require "json"

    api = "https://api.stackexchange.com/2.1/"
    output = "<style>*{word-wrap:break-word}</style>"

    query = "users/427/answers?site=apple&page=1&pagesize=100&filter=!-.mgWMP7sO7J\"
    JSON.parse(`curl -s --compressed \"#{api}#{query}`)["items"].each { |answer|
      output << "<h2><a href=\"#{post["link"]}\">#{answer["title"]}</a></h2>#{answer["body"]}"
    }

    IO.write("/tmp/se.html", output)
    `open /tmp/se.html`

## tumblroriginalimages.rb

    require "json"
    require "open-uri"

    apikey = ""
    tumblr = "example"
    base = "http://api.tumblr.com/v2/blog/#{tumblr}.tumblr.com/"

    output = ""
    1.upto(50).each { |offset|
      source = open(base + "posts?type=photo&offset=#{offset * 20}&api_key=#{apikey}").read
      JSON.parse(source)["response"]["posts"].each { |post|
        photo = post["photos"][0] || next
        next unless photo["original_size"]["width"] * photo["original_size"]["height"] >= 500000
        output << "<a href=\"#{photo["original_size"]["url"]}\"><img src=\"#{photo["alt_sizes"][1]["url"]}\"></a>\n"
      }
    }

    f = "/tmp/tumblr.html"
    IO.write(f, output)
    system("open", f)

## tumblroriginalimages.sh

    tumblr=example
    key='get from tumblr.com/api'
    api="http://api.tumblr.com/v2/blog/$tumblr.tumblr.com/posts?type=photo&api_key=$key"
    total=$(curl -s $api|jq .response.total_posts)
    seq 0 20 $total|while read $n;do curl -s "$api&offset=$n"|jq -r '.response.posts[].photos|map(select(.original_size.width*.original_size.height>5e5))[].original_size.url';done|awk '!a[$0]++'|parallel wget -qP /tmp/tumblr

    # {0..$total..20} wouldn't work
    # jq -r uses a raw output format instead of printing the output as json
    # posts[].photos is like posts|map(.photos) but it doesn't return a nested array
    # -P specifies a target prefix in wget

## twitter.rb

    require "twitter"
    require "cgi"

    client = Twitter::REST::Client.new { |config|
      config.consumer_key = ""
      config.consumer_secret = ""
      config.oauth_token = ""
      config.oauth_token_secret = ""
    }

    max = client.user_timeline("climagic").first.id
    while true
      timeline = client.user_timeline("climagic", options = {:count => 200, :max_id => max, :include_rts => false})
      break if timeline.empty?
      timeline.each { |tweet| puts CGI.unescapeHTML(tweet.text.gsub(/\r?\n/, " ")) }
      max = timeline.last.id - 1
    end

    # client.favorites("username")
    # client.retweeted_by("username")
    # client.friend_ids("username")

## urlalias

    #!/usr/bin/env bash

    urlencode() {
      ruby -pe '$_.gsub!(/[^A-Za-z0-9]/){"%%%02x"%$&.ord}'
    }

    lucky() {
      curl -s -G -m5 --data-urlencode q="$1" http://ajax.googleapis.com/ajax/services/search/web?v=1.0 |
      sed 's/"unescapedUrl":"\([^"]*\).*/\1/;s/.*GwebSearch",//'
    }

    q="$@"
    if [[ -z $q ]]; then
      touch ${TMPDIR}urlalias
      q=$(osascript -e 'on run {a}
    text returned of (display dialog "" default answer a)
    end' -- "$(<${TMPDIR}urlalias)" | tr \\r \\n)
      [[ -z $q ]] && exit
    fi
    printf %s "$q" > ${TMPDIR}urlalias

    if [[ ${q:0:1} = " " ]]; then
      url=http://www.google.com/search?q=$(printf %s "${q:1}" | urlencode)
    elif [[ ${q:0:1} = . ]]; then
      url=$(lucky "${q:1}")
      [[ -z $url ]] && url=http://www.google.com/search?q=$(printf %s "${q:1}" | urlencode)
    else
      q1=${q%% *}
      q2=${q#"$q1"}
      q2=${q2# }
      while read -r l; do
        [[ $l = "$q1 "* ]] && { found=$l; break; }
      done < ~/Notes/urls.txt
      if [[ $found ]]; then
        url=${found#* }
        url=${url//%s/$(printf %s "$q2" | urlencode)}
      else
        url="http://www.google.com/search?q=$(printf %s "$q" | urlencode)"
      fi
    fi
    if [[ -z $url ]]; then
      exit
    elif [[ $url = file* ]]; then
      open "$url" -a "$(VERSIONER_PERL_PREFER_32_BIT=1 perl -MMac::InternetConfig -le 'print +(GetICHelper "http")[1]')"
    else
      open "$url"
    fi

    # use `tell app (path to frontmost application as text) to display dialog` in 10.8 and earlier
    # `set 'a  b';q=$@` sets q to `a  b` in bash 4.3 but `a b` in bash 4.2

    # urls.txt contains lines like this:
    # b http://bitsnoop.com/search/all/%s/c/d/1/
    # it itunes://ax.search.itunes.apple.com/WebObjects/MZSearch.woa/wa/search?term=%s
    # kat http://kickass.to/usearch/%s
    # tr http://translate.google.com/#auto/auto/%s
    # tru http://translate.google.com/translate?sl=auto&tl=en&u=%s
    # wao http://web.archive.org/web/*/%s

## wikipedia.css

    /*
    Save this file as vector.css in http://en.wikipedia.org/wiki/Special:Preferences#mw-prefsection-rendering

    Use vector.js to remove the default stylesheets:

    all=document.querySelectorAll("link[rel=stylesheet]:not([href*='&user='])");for(i=0;e=all[i];i++){e.parentNode.removeChild(e)}

    Access keys:

    - e: edit
    - h: history
    - j: what links here
    - s: save
    - t: talk page
    */

    /* general */

    * {
      line-height: 1.15;
      word-wrap: break-word;
    }

    /* elements */

    body {
      font: 20px 'Times New Roman', serif;
    }
    h1 {
      color: black !important;
    }
    a {
      color: black;
    }
    pre, code, tt, .mw-geshi, #wpTextbox1 {
      font: 16px Menlo, 'DejaVu Sans Mono', 'Bitstream Vera Sans Mono', monospace !important;
    }
    td {
      padding: 2px 4px;
    }
    table {
      margin: 0.5em 0;
    }
    sup { /* sup and sub elements affect line spacing when using the default HTML styles */
      vertical-align: 0;
      position: relative;
      bottom: 1.1ex;
    }
    sub {
      vertical-align: 0;
      position: relative;
      top: 0.8ex;
    }
    kbd {
      font: 13px sans-serif !important;
      padding: 2px 4px !important;
    }

    /* top */

    #contentSub { /* redirected from */
      margin: 0.5em 0 0.9em 0;
    }
    .dablink { /* disambiguation links */
      margin: 0.5em 0;
    }
    #toc {
      margin-top: -0.8em;
    }
    #toc ul {
      margin-left: 1.3em;
    }
    .toctoggle {
      display: none;
    }

    /* content */

    .reference {
      margin: 0 3px;
      font-size: 0.7em;
    }
    .reference a, .mw-cite-backlink a {
      text-decoration: none;
    }
    .reference span { /* angle brackets around references */
      display: none;
    }
    .rellink { /* main article, see also, further information */
      margin: 0.5em 0 0 0;
    }
    .wikitable {
      margin: 0.5em 0;
    }
    .tleft {
      float: left;
      padding: 0.8em 0.8em 0.8em 0;
    }
    .tright {
      float: right;
      padding: 0.8em 0 0.8em 0.8em;
    }
    .thumbcaption {
      font-size: 0.8em;
      margin-top: 0.25em;
      line-height: 1.3em;
    }
    .infobox caption {
      margin: 0 0 0.5em 0;
    }
    .floatnone img, .tex { /* some pages have wide images */
      max-width: 43em;
    }
    .citation-needed-content {
      background: none !important;
      color: black !important;
      border: none !important;
    }
    .Template-Clarify {
      display: none;
    }
    .clarify-content {
      background: none !important;
      color: black !important;
      border: none !important;
    }

    /* remove the blue quotation marks in some blockquotes */

    .cquote tr:first-child td:first-child, .cquote tr:first-child td:last-child, .cquote2 tr:first-child td:first-child, .cquote2 tr:first-child td:last-child {
      visibility: hidden;
      width: 0;
    }
    .cquote td, .cquote2 td {
      padding: 0 !important;
    }
    .cquote, .cquote2 {
      margin-left: 2.5em;
    }

    /* edit pages */

    #wpTextbox1 {
      width: 100%;
      height: 600px;
      margin: 0.5em 0;
    }
    .mw-editTools,
    #editpage-copywarn,
    #editpage-copywarn2,
    .editpage-head-copywarn,
    #mw-wikimedia-editpage-tos-summary,
    #wpSummaryLabel,
    #minoredit_helplink,
    .purgelink,
    .previewnote,
    .templatesUsed,
    #jswarning,
    #mw-script-doc,
    #clearprefcache,
    #usercssjsyoucanpreview {
      display: none !important;
    }

    /* search pages */

    .search-createlink,
    .mw-search-result-data,
    .mw-search-formheader {
      display: none !important;
    }

    /* @media print */

    @media print {
      body {
        zoom: 80%;
        margin-top: 0.8em;
      }
      h2, h3, h4, h5 {
        page-break-after: avoid;
      }
    }

    /* hide elements */

    .noprint,
    #siteNotice, /* banners for fundraisers and other notifications */
    #mw-articlefeedback, /* help improve this article */
    .articleFeedbackv5,
    #column-one, /* sidebar */
    #siteSub, /* from Wikipedia, the free encyclopedia */
    .metadata, /* stub, wikisource, wikiquote */
    .tmbox, /* this article needs more references */
    #jump-to-nav, /* Jump to */
    #footer,
    .printfooter,
    .navbox, /* collapsible tables for categories and related articles */
    .vertical-navbox,
    #catlinks, /* links for categories at the bottom */
    .hiddencats, /* categories that are hidden by default */
    .editsection, /* edit links next to section headings */
    .Template-Fact, /* citation needed, etc */
    #section_SpokenWikipedia, /* listen to this article */
    .portal, /* floating boxes for portals */
    .magnify, /* magnifying glass icons */
    #noarticletext_technical, /* help text on article not found pages */
    #warningOverlay_mwe_player_0, /* For a better video playback experience we recommend a html5 video browser. */
    #sisterproject,
    #articlefeedbackv5-article-feedback-link, /* reader comments */
    .mw-editsection,
    #mw-navigation {
      display: none !important;
    }