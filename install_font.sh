#!/bin/sh

FONT_INSTALL_PATH="$HOME/.local/share/fonts"

if [ ! -d "$FONT_INSTALL_PATH" ]; then
    echo "Unable to detect the install directory path '$FONT_INSTALL_PATH'.  Please create this path and execute the script again."
    exit 1
fi


URL="http://www.gringod.com/wp-upload/software/Fonts/Monaco_Linux.ttf"
HACK_ARCHIVE_PATH="Hack-$HACK_VERSION-ttf.tar.gz"

# pull user requested fonts from the Hack repository releases & unpack
echo " "
echo "Downloading font..."
curl -L -O "$URL"

# install
echo " "
echo "Installing font..."

# move fonts to install directory
mv Monaco_Linux.ttf "$FONT_INSTALL_PATH/Monaco_Linux.ttf"

# clear and regenerate font cache
echo " "
echo "Clearing and regenerating the font cache..."
echo " "
fc-cache -f

if fc-list | grep -i --quiet "monaco"; then
    echo "Installed font succesfully"
    exit 0
else
    echo "Install failed."
    exit 1
fi
