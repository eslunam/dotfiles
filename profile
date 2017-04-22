export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR='nvim'
export BROWSER='firefox'

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
    PS1='[\u \w]$ '
fi

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
    exec startx &> /dev/null
fi
