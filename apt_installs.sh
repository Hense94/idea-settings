#!/bin/bash

DIST_VERSION=$(lsb_release -a 2> /dev/null | grep Release | grep -Po "[0-9\.]+$")

#Misc
sudo apt install apt-transport-https -y

#Albert repo
echo "deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_$DIST_VERSION/ /" | sudo tee /etc/apt/sources.list.d/home:manuelschneid3r.list

#Sublime repo
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

#Update
sudo apt update

#Remove apport
sudo apt purge apport -y

#Remove dock/dash
sudo apt remove gnome-shell-extension-ubuntu-dock -y

#Install albert
sudo apt install albert -y

#Install Sublime
sudo apt install sublime-text -y

#Install Chrome
curl -L -O "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
sudo dpkg --install google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

#Update and clean up 
sudo update -y
sudo apt autoremove -y

