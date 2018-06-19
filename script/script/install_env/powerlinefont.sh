
sudo pacman -S zsh-theme-powerlevel9K
sudo pip install powerline-status
cd ~/conf2
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts
