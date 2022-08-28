#@/usr/bin/env bash

   Off='\033[0m'	     # Text Reset

   # Regular Colors
   Black='\033[0;30m'        # Black
   Red='\033[0;31m'          # Red
   Green='\033[0;32m'        # Green
   Yellow='\033[0;33m'       # Yellow
   Blue='\033[0;34m'         # Blue
   Purple='\033[0;35m'       # Purple
   Cyan='\033[0;36m'         # Cyan
   White='\033[0;37m'        # White

   # Bold
   BBlack='\033[1;30m'       # Black
   BRed='\033[1;31m'         # Red
   BGreen='\033[1;32m'       # Green
   BYellow='\033[1;33m'      # Yellow
   BBlue='\033[1;34m'        # Blue
   BPurple='\033[1;35m'      # Purple
   BCyan='\033[1;36m'        # Cyan
   BWhite='\033[1;37m'       # White

list=$(ls --ignore={.git,README.md,Arch-i3-install.sh,Arch-i3-Wallpapers,screenshots})

home=$(echo $HOME)

conf="$home/.config"

syswall="/usr/share/backgrounds"

InstallParu() {
	sudo pacman -S --noconfirm --needed git base base-devel
	git clone https://aur.archlinux.org/paru.git
	cd paru
	makepkg -si --noconfirm --needed
	rm -rf paru
	echo"-----------Paru Installed------------"
}


pkgs=(
'i3-wm'
'polybar'
'rofi'
'fish'
'starship'
'picom'
'alacritty'
'nitrogen'
'flameshot'
'pcmanfm'
'btop'
'htop'
'neofetch'
'libfm'
'brave-bin'
'lxappearance'
'kvantum'
)


if [ $(whoami) != root ]; then

	if [ ! -x /bin/paru*  -o  ! -x /usr/bin/paru* ]; then
	
		InstallParu
	else 
		echo "Paru is already installed"
	fi

for pkg in "${pkgs[@]}"; do

	paru -S "$pkg" --noconfirm --needed
done
	if [ ! -d $conf ]; then
		
		mkdir -p $conf
	fi
		mv user-dirs.locale user-dirs.dirs starship.toml $home
		mv $list $conf

	if [ ! -d $syswall ]; then

		mkdir -p $syswall
	fi
		mv Arch-i3-Wallpapers $syswall
else
	echo "${BRed}\nFatal, Installing as root user."
	echo "\nAbort, root user cannot install this.\n"
	exit 0;
fi
