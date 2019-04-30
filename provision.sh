#!/bin/bash
input="symlinks"

while IFS= read -r var
do
  IFS=':' read -r  -a results <<< "$var"
  eval src="${results[0]}"
  eval dst="${results[1]}"
  cmp --silent "$src" "$dst" || ln -s "$src" "$dst"
done < "$input"


#Install terminal profile

dlist_append() {
    local key="$1"; shift
    local val="$1"; shift

    local entries="$(
        {
            dconf read "$key" | tr -d '[]' | tr , "\n" | fgrep -v "$val"
            echo "'$val'"
        } | head -c-1 | tr "\n" ,
    )"

    dconf write "$key" "[$entries]"
}

TERMINAL_PATH=/org/gnome/terminal/legacy/profiles:
PROFILE_SLUG=3d15fe59-69d5-40c3-be2a-6da1ed714a55

dconf load $TERMINAL_PATH/ < ~/dotfiles/terminal.conf
dlist_append $TERMINAL_PATH/list "$PROFILE_SLUG"

