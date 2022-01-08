#!/bin/sh

SCRIPT_DEST_DIR="/usr/bin"
SCRIPT_REPO_DIR="$PWD"

ROOT_FLATPAK_DESKTOP_FILE="/var/lib/flatpak/app/org.chromium.Chromium/current/active/export/share/applications/org.chromium.Chromium.desktop"
ROOT_FLATPAK_DESKTOP_DIRECTORY="/var/lib/flatpak/app/org.chromium.Chromium/current/active/export/share/applications/"
REPO_FLATPAK_DESKTOP_FILE="$PWD/org.chromium.Chromium.desktop"

check_for_install()
{
    cd $SCRIPT_DEST_DIR
    if test -n "$(find . -maxdepth 1 -name 'flatpak-chromium-launcher*' -print -quit)"
    then
        echo "The install script backs up the .desktop file that the flatpak uses to launch; it can't be overwritten with our fixes."
        echo "Since you already have the fixes installed, please use the uninstall script before running this one again,"
        echo "lest the script makes the original desktop file of the flatpak unrecoverable"
        cd $SCRIPT_REPO_DIR
        exit 1
    fi
}

install_script_files()
{
    cd $SCRIPT_DEST_DIR
    if test -n "$(find . -maxdepth 1 -name 'flatpak-chromium-launcher*' -print -quit)"
    then
        sudo rm $SCRIPT_DEST_DIR/flatpak-chromium-launcher*
    fi
    cd $SCRIPT_REPO_DIR
    
    sudo cp -a $SCRIPT_REPO_DIR/chromium-launcher-scripts/* $SCRIPT_DEST_DIR \
        && echo "Copying repo scripts to the script directory"
}

backup_desktop_file()
{
    mv original/org.chromium.Chromium.desktop original/org.chromium.Chromium.desktop.BAK
    sudo cp $ROOT_FLATPAK_DESKTOP_FILE original/org.chromium.Chromium.desktop
}

install_desktop_file()
{
    if [ -e $ROOT_FLATPAK_DESKTOP_FILE ]; then
        sudo rm -rf $ROOT_FLATPAK_DESKTOP_FILE \
            && echo "Removing the original .desktop file for repo's version to replace"
    fi

    sudo desktop-file-install --dir=$ROOT_FLATPAK_DESKTOP_DIRECTORY $REPO_FLATPAK_DESKTOP_FILE \
        && echo "installing repo desktop file"
}

check_for_install

install_script_files

backup_desktop_file

install_desktop_file

sudo update-desktop-database /var/lib/flatpak/exports/share/applications
sudo update-desktop-database $ROOT_FLATPAK_DESKTOP_DIR
