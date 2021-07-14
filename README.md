# Dotfiles

## Dependencies

```shell
sudo apt install zsh acpi curl vim thefuck htop tree jq neovim exa awesome fonts-roboto rofi compton i3lock xclip qt5-style-plugins materia-gtk-theme lxappearance xbacklight flameshot nautilus xfce4-power-manager pnmixer network-manager-gnome policykit-1-gnome kitty arandr -y
wget -qO- https://git.io/papirus-icon-theme-install | sh
``` 

## Installation

```shell
git clone --bare git@github.com:aboivin/dotfiles.git $HOME/.cfg
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
cfg config --local status.showUntrackedFiles no
cfg checkout
```

## Misc

#### Setup touchpad

Create `/urs/share/X11/xorg.conf.d/20-touchpad.conf`

```shell
Section "InputClass"
    Identifier "Natural Scrolling Touchpads"
    MatchIsTouchpad "on"
    MatchDevicePath "/dev/input/event*"
    Option "Tapping" "on"
    Option "NaturalScrolling" "true"
EndSection
```
