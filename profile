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

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
    exec startx &> /dev/null
fi
