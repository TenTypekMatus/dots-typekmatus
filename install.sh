#!/usr/bin/env bash
if [[ ! /usr/bin/figlet ]]; then
	sudo pacman -S --needed figlet --nocomfirm
fi
figlet -w 100 -f slant "MatuusOS"
read -p "Do you want to continue? [y/n] " answer
if [[ $answer = "y" ]]; then
	echo "Continuing"
else
	echo "Exiting"
	exit 1
fi
echo ">>> Backing up .config"
cp -r ~/.config ~/.config.bak
echo ">>> Installing required packages"
pacman -S --needed xorg-xinit xorg-xsel base-devel papirus-icon-theme alacritty exa fish starship neovim nitrogen lxsession xfce4-session --noconfirm
echo ">>> Setting up dotfiles"
git clone --recurse-submodules https://github.com/TenTypekMatus/dots-typekmatus /tmp/dots 
cp -r /tmp/dots/{.config,.walls} ~
echo ">>> Installing MatusWM and MatusMenu"
git clone https://github.com/TenTypekMatus/dwm .dwm
git clone https://github.com/TenTypekMatus/dmenu .dmenu
cd .dwm || exit 
make -j$(nproc) # dwm install
sudo make install
cd ../.dmenu || exit
make -j$(nproc) # dmenu install
sudo make install
echo "Installing MtVim"
git clone https://github.com/TenTypekMatus/MtVim ~/.config/nvim
echo ">>> Copying the rest"
cp -r /tmp/dots/config/* ~
cp /tmp/dots/xinitrc ~
echo ">>> Done"
