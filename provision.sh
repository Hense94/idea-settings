#!/bin/bash

#Create symlinks
input="symlinks"

while IFS= read -r var
do
  IFS=':' read -r  -a results <<< "$var"
  eval src="${results[0]}"
  eval dst="${results[1]}"
  DSTDIR=$(dirname "$dst")
  #Create dst dir if not present
  [ -d $DSTDIR ] || mkdir -p $DSTDIR 
  cmp --silent "$src" "$dst" || ln -s "$src" "$dst"
done < "$input"

exit 0

#Run apt installs (required because of curl)
./apt_installs.sh

#NVM and node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
nvm install node

#Chrome
curl -L -O "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
sudo dpkg --install google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

#Monaco font
curl -L -O "http://www.gringod.com/wp-upload/software/Fonts/Monaco_Linux.ttf"
mv Monaco_Linux.ttf ~/.local/share/fonts/Monaco_Linux.ttf
fc-cache -f

#Use numix circle and monaco font
dconf write /org/gnome/desktop/interface/icon-theme "'Numix-Circle'"
dconf write /org/gnome/desktop/interface/monospace-font-name= "'Monaco 13'"

#Keyboard shortcuts
dconf load /org/gnome/settings-daemon/plugins/media-keys/ < ~/dotfiles/keys.conf

#Terminal profile
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

