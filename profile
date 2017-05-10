export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR='nvim'
export BROWSER='firefox'
export PATH="$PATH:$HOME/bin"

export WM_BLACK="#3C3836"
export WM_WHITE="#EBDBB2"
export WM_GREY="#7C6F64"
export WM_GREEN="#B8DD26"
export WM_DARK="#665C54"

alias q='exit'
alias qq='exit'
alias :q='exit'

alias pamcan='pacman'
alias ping='ping -c 4'
alias less='less -S'
alias sync='sync;sync'

if [ "$TERM" = "linux" ]; then
    alias mplayer='mplayer -vo fbdev2'
fi

if [ "$SHELL" = "/bin/ash" ]; then
    PS1='[\u $(current_dir)]$ '
fi

if [[ "$TERM" == "linux" ]]; then
    sudo setfont ter-116b
    echo -e '\033[?17;0;127c'

    echo -en "\e]P032302f" #black    -> this is the background color as well.
    echo -en "\e]P8665c54" #darkgray
    echo -en "\e]P19d0006" #darkred
    echo -en "\e]P9cc241d" #red
    echo -en "\e]P279740e" #darkgreen
    echo -en "\e]PA98971a" #green
    echo -en "\e]P3af3a03" #brown
    echo -en "\e]PBb57614" #yellow
    echo -en "\e]P4076678" #darkblue
    echo -en "\e]PC458588" #blue
    echo -en "\e]P58f3f71" #darkmagenta
    echo -en "\e]PDb16286" #magenta
    echo -en "\e]P6427b58" #darkcyan
    echo -en "\e]PE689d61" #cyan
    echo -en "\e]P7928374" #lightgray
    echo -en "\e]PFebdbb2" #white   -> this is the foreground color as well.
    clear #for background artifacting
fi

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ] && [ "$(whoami)" = "ellis" ]; then
    exec startx &> /dev/null
fi
