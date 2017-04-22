#!/usr/bin/busybox ash

set -e

res=$(xdpyinfo | awk '/dimensions:/ { print $2 }')
width=$(printf "%s\n" "${res}" | cut -d 'x' -f 1)
height=$(printf "%s\n" "${res}" | cut -d 'x' -f 2)
panel_height=$((height/36))
panel_dimensions="${width}x${panel_height}+0+0"
panel_font="Source Code Pro-9"
icon_font="FontAwesome-12"
panel_bg="#ff3c3836"
panel_fg="#ffebdbb2"
panel_hl="#ff928374"
panel_green="#FFb8dd26"

#if [ $(pgrep -x lemonbar | wc -l) -gt 0 ]; then
    #printf "%s\n" "The panel is already running." >&2
    #exit 1
#fi

bspc config bottom_padding "$panel_height"

trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

fifo="/tmp/panel_fifo"
[ -e "$fifo" ] && rm "$fifo"
mkfifo "$fifo"



desktops() {
    bspc query -T -m | jshon -e desktops -a -e name -u -p -e id | spaces
}

spaces() {
    local current list="desktops|"
    current="$(printf "%d\n" "$(bspc query -D -d)")"
    while {
        read -r name
        read -r id
    }; do
        local output="%{A:bspc desktop -f ${id}:} ${name} %{A}"
        if [ "$id" = "$current" ]; then
            output="%{R}${output}%{R}"
        elif [ "$(bspc query -T -d "$id" | jshon -e root)" = "null" ]; then
            continue
        fi

        list="${list}${output}"
    done

    printf "%s\n" "${list}"
}

windows() {
    bspc query -N -n .window -d focused | nodes
}

nodes() {
    local list="windows|" #active
    active=$(bspc query -N -n)
    while read -r id; do
        if [ ! -z "$id" ]; then
            local name
            name=$(xprop -id "$id" WM_CLASS | awk -F '"' '{ print tolower($4) }')
            name="%{A:bspc node -f ${id}:} ${name} %{A}"
            name="%{A2:xkill -id ${id}:}${name}%{A}"
            [ "$id" = "$active" ] && name="%{R}${name}%{R}"
            list="${list}${name} "
        fi
    done

    printf "%s\n" "${list}  "
}

disk_percent() {
    df -P "$1" | awk '/%/ { print $5 }'
}

disks() {
    local root home
    root="root: $(disk_percent /)"
    home="home: $(disk_percent /home)"

    printf "%s\n" "disks|${root}, ${home}   "
}

address() {
    local addr output="address|"
    addr="${addr}$(ip route | awk '/default/ { print $7 }')"
    [ ! -z "$addr" ] && output="${output}%{F${panel_green}}${addr}%{F-}  "
    printf "%s\n" "$output"
}

battery() {
    local status output="battery|"

    status=$(acpi -b | sed 's/,//g')
    if [ ! -z "$status" ]; then
        local percent charging
        charging=$(printf "%s\n" "$status" | awk '{ print $3 }')
        percent=$(printf "%s\n" "$status" | awk '{ print $4 }')
        [ "$charging" = "Charging" ] && charging='+' || charging='-'

        output="${output}bat: ${percent} (${charging})"
    fi

    printf "%s\n" "$output"
}

vol_toggle="%{A2:pamixer -t:}"
vol_up="%{A4:pamixer -i 1:}"
vol_down="%{A5:pamixer -d 1:}"
vol_label="vol: "
vol_prefix="${vol_toggle}${vol_up}${vol_down}${vol_label}"
vol_suffix="%{A}%{A}%{A}"
volume() {
    local vol
    [ "$(pamixer --get-mute)" = "true" ] && vol="mute" || vol="$(pamixer --get-volume)%"
    printf "%s\n" "volume|${vol_prefix}${vol}${vol_suffix}   "
}

clock() {
    local date
    date=$(date '+%A, %Y/%m/%d %H:%M')
    printf "%s\n" "clock|${date}"
}


while true; do desktops; sleep 0.1s; done > "$fifo" &
while true; do windows; sleep 0.5s; done > "$fifo" &
while true; do disks; sleep 30s; done > "$fifo" &
while true; do address; sleep 10s; done > "$fifo" &
while true; do volume; sleep 0.3s; done > "$fifo" &
while true; do clock; sleep 60s; done > "$fifo" &

while read -r line; do
    case $line in
        "desktops|"*)
            desktops="$(printf "%s\n" "$line" | cut -d '|' -f 2)"
            ;;
        "windows|"*)
            windows="$(printf "%s\n" "$line" | cut -d '|' -f 2)"
            ;;
        "disks|"*)
            disks="$(printf "%s\n" "$line" | cut -d '|' -f 2)"
            ;;
        "address|"*)
            address="$(printf "%s\n" "$line" | cut -d '|' -f 2)"
            ;;
        "volume|"*)
            volume="$(printf "%s\n" "$line" | cut -d '|' -f 2)"
            ;;
        "clock|"*)
            clock="$(printf "%s\n" "$line" | cut -d '|' -f 2)"
            ;;
    esac
    printf "%s\n" "%{l}${desktops}  %{r}${windows}  ${disks}  ${address}  ${volume}  ${clock} "
#done < "$fifo"
done < "$fifo" | lemonbar -p -b -g "$panel_dimensions" -a 99 -f "$panel_font" -f "$icon_font" -B "$panel_bg" -F "$panel_fg" | busybox ash
