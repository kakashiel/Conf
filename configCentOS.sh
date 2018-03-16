#/bin/sh
yum update -y

#intall zsh 
yum install -y zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s $(which zsh)

#installer vim all user + best conf
yum install -y vim
git clone --depth=1 https://github.com/amix/vimrc.git /opt/vim_runtime
sh ~/.vim_runtime/install_awesome_parameterized.sh /opt/vim_runtime user0 user1 user2
# to install for all users with home directories
sh ~/.vim_runtime/install_awesome_parameterized.sh /opt/vim_runtime --all
