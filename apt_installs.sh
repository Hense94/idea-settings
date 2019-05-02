#!/bin/bash

#------------------- MISC. -------------------
DIST_VERSION=$(lsb_release -a 2> /dev/null | grep Release | grep -Po "[0-9\.]+$")
sudo apt install apt-transport-https -y


#------------------- REPOS -------------------
#Albert repo
echo "deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_$DIST_VERSION/ /" | sudo tee /etc/apt/sources.list.d/home:manuelschneid3r.list

#Sublime repo
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

#Update
sudo apt update


#------------------ REMOVAL ------------------
#Remove apport
sudo apt purge apport -y

#Remove dock/dash
sudo apt remove gnome-shell-extension-ubuntu-dock -y


#------------------ INSTALL ------------------
#Install curl
sudo apt install curl -y

#Install git
sudo apt install git -y

#Install tweak-tool
sudo apt install gnome-tweaks -y

#Install gnome-extensions thingy
sudo apt install chrome-gnome-shell -y 

#Install qt5ct
sudo apt install qt5ct -y

#Install numix iconss
sudo apt install numix-icon-theme-circle -y

#Install albert
sudo apt install albert -y

#Install Sublime
sudo apt install sublime-text -y

#------------------ CLEANUP ------------------
sudo update -y
sudo apt autoremove -y

