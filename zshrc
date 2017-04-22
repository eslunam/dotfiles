# Lines configured by zsh-newuser-install
HISTFILE=~/.local/zshhist
HISTSIZE=10000
SAVEHIST=100000
setopt appendhistory autocd nomatch notify
unsetopt beep extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Aliases
alias ls='ls --group-directories-first --color=auto -hGNvB'
alias l1='ls -1'
alias ll='ls -g'
alias la='ls -A'
alias lla='ll -A'
alias p='ping archlinux.org'
alias grep='grep --color=auto'

alias mpva='mpv --vid=no'
alias mpvap='mpv --vid=no --loop=inf --shuffle'

alias w3m='w3m -no-cookie'

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]="$terminfo[khome]"
key[End]="$terminfo[kend]"
key[Insert]="$terminfo[kich1]"
key[Backspace]="$terminfo[kbs]"
key[Delete]="$terminfo[kdch1]"
key[Up]="$terminfo[kcuu1]"
key[Down]="$terminfo[kcud1]"
key[Left]="$terminfo[kcub1]"
key[Right]="$terminfo[kcuf1]"
key[PageUp]="$terminfo[kpp]"
key[PageDown]="$terminfo[knp]"

# setup key accordingly
[[ -n "$key[Home]"      ]] && bindkey -- "$key[Home]"      beginning-of-line
[[ -n "$key[End]"       ]] && bindkey -- "$key[End]"       end-of-line
[[ -n "$key[Insert]"    ]] && bindkey -- "$key[Insert]"    overwrite-mode
[[ -n "$key[Backspace]" ]] && bindkey -- "$key[Backspace]" backward-delete-char
[[ -n "$key[Delete]"    ]] && bindkey -- "$key[Delete]"    delete-char
[[ -n "$key[Up]"        ]] && bindkey -- "$key[Up]"        up-line-or-history
[[ -n "$key[Down]"      ]] && bindkey -- "$key[Down]"      down-line-or-history
[[ -n "$key[Left]"      ]] && bindkey -- "$key[Left]"      backward-char
[[ -n "$key[Right]"     ]] && bindkey -- "$key[Right]"     forward-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        echoti smkx
    }
    function zle-line-finish () {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search

source "/usr/share/doc/pkgfile/command-not-found.zsh"
source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$HOME/.config/nvim/plugged/gruvbox/gruvbox_256palette.sh"

ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[path]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=green'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=green'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=green,bold'

export PATH="$PATH:$HOME/bin"

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

add_sudo() {
    BUFFER="sudo $BUFFER"
    zle -w end-of-line
}

zle -N add_sudo
bindkey "^f" add_sudo

PROMPT='[%n %1~]$ '
