#! /bin/bash

echo "installation pip"
easy_install pip

echo "installation brew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

#git 
echo "install git"
brew install git
cp ./.gitconfig ~/ 

#zsh
echo "install zsh"
brew install zsh zsh-completions

#zsh by default
chsh -s $(which zsh)

echo "install oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh 
