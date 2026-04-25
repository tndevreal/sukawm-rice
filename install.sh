#!/bin/bash

set -e

USER_NAME="$(whoami)"
HOME_DIR="/home/$USER_NAME"

echo "WARNING: This will DELETE your existing configs for:"
echo "dunst, rofi, polybar, suka, picom"
echo "and replace them with new ones."
echo
read -rp "Continue? (Y/N): " confirm

case "$confirm" in
    [Yy]*) ;;
    [Nn]*) echo "Exiting."; exit 0 ;;
    *) echo "Invalid input. Exiting."; exit 1 ;;
esac

if   command -v xbps-install >/dev/null 2>&1; then
    DISTRO="void"
elif command -v pacman >/dev/null 2>&1 && ! command -v artix-help >/dev/null 2>&1; then
    DISTRO="arch"
elif command -v pacman >/dev/null 2>&1 && command -v artix-help >/dev/null 2>&1; then
    DISTRO="artix"
else
    echo "Unsupported distro. Only Void, Arch, and Artix are supported."
    exit 1
fi

echo "Detected distro: $DISTRO"

case "$DISTRO" in
    void)
        doas xbps-install -Sy dunst rofi polybar picom flatpak feh \
            xdg-desktop-portal-gtk kitty polkit-gnome doas
        ;;
    arch)
        doas pacman -Sy --noconfirm dunst rofi polybar picom flatpak feh \
            xdg-desktop-portal-gtk kitty polkit-gnome opendoas
        ;;
    artix)
        doas pacman -Sy --noconfirm dunst rofi polybar picom flatpak feh \
            xdg-desktop-portal-gtk kitty polkit-gnome opendoas
        ;;
esac

echo "Configuring doas..."

DOAS_CONF=$(cat <<EOF
permit :wheel
permit nopass $USER_NAME
permit nopass root
EOF
)

echo "$DOAS_CONF" | doas tee /etc/doas.conf >/dev/null
doas chmod 600 /etc/doas.conf

echo "Removing old configs..."

rm -rf "$HOME_DIR/.config/dunst"
rm -rf "$HOME_DIR/.config/rofi"
rm -rf "$HOME_DIR/.config/polybar"
rm -rf "$HOME_DIR/.config/suka"
rm -rf "$HOME_DIR/.config/picom"

echo "Copying new configs..."

mkdir -p "$HOME_DIR/.config"

doas -r cp -r picom "$HOME_DIR/.config/"
doas -r cp -r rofi "$HOME_DIR/.config/"
doas -r cp -r suka "$HOME_DIR/.config/"
doas -r cp -r polybar "$HOME_DIR/.config/"
doas -r cp -r dunst "$HOME_DIR/.config/"

mkdir -p "$HOME_DIR/Downloads"
cp walp.png "$HOME_DIR/Downloads/walp.png"
echo "default bindings are:"
echo "super+a=rofi"
echo "super+LMB=move window/focus window"
echo "super+RMB=resize window"
echo "super+control+LMB= move full canvas"
echo "super+t(or enter/return)=kitty/terminal"
echo "done."

