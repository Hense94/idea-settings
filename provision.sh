#!/bin/bash

#Create symlinks
input="symlinks"

while IFS= read -r var
do
  IFS=':' read -r  -a results <<< "$var"
  eval src="${results[0]}"
  eval dst="${results[1]}"
  cmp --silent "$src" "$dst" || ln -s "$src" "$dst"
done < "$input"

#Disable apport
sudo apt purge apport -y

#Remove dock/dash
sudo apt remove gnome-shell-extension-ubuntu-dock -y

#Install albert
VERSION=$(lsb_release -a 2> /dev/null | grep Release | grep -Po "[0-9\.]+$")

sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_$VERSION/ /' > /etc/apt/sources.list.d/home:manuelschneid3r.list"
sudo apt-get update
sudo apt-get install albert -y

#Update and clean up 
sudo update -y
sudo apt autoremove -y

#Install Monaco font
./install_font.sh

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

