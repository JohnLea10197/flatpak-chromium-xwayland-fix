#!/bin/sh

SCRIPT_DEST_DIR="/usr/bin"
SCRIPT_DEST_DIR_ROOT="/root/.local/share/bin"
SCRIPT_REPO_DIR="$PWD"

ROOT_FLATPAK_DESKTOP_FILE="/var/lib/flatpak/app/org.chromium.Chromium/current/active/export/share/applications/org.chromium.Chromium.desktop"
ROOT_FLATPAK_DESKTOP_DIRECTORY="/var/lib/flatpak/app/org.chromium.Chromium/current/active/export/share/applications"
REPO_BACKUP_DESKTOP_FILE="$PWD/original/org.chromium.Chromium.desktop"

uninstall_script_files()
{
    sudo rm $SCRIPT_DEST_DIR/flatpak-chromium-launcher*
}

revert_desktop_file()
{
    if [ -e $ROOT_FLATPAK_DESKTOP_FILE ]; then
        sudo rm -rf $ROOT_FLATPAK_DESKTOP_FILE
    fi

    sudo desktop-file-install --dir=$ROOT_FLATPAK_DESKTOP_DIRECTORY $REPO_BACKUP_DESKTOP_FILE \
        && echo "reverting .desktop file to original flatpak version"
}

uninstall_script_files

revert_desktop_file

sudo update-desktop-database /var/lib/flatpak/exports/share/applications
sudo update-desktop-database $ROOT_FLATPAK_DESKTOP_DIRECTORY
