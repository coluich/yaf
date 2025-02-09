#!/bin/bash
# This script is used to create some cool alias on bashrc file and also to install some cool tools included figlet

sudo apt install lolcat figlet lsd bat nvim cmatrix -y
sudo git clone https://github.com/xero/figlet-fonts /usr/share
sudo mv /usr/share/figlet-fonts/* /usr/share/figlet 
sudo rm -rf /usr/share/figlet-fonts


if [ -n "$BASH_VERSION" ]; then
    CONFIG_FILE="$HOME/.bashrc"
elif [ -n "$ZSH_VERSION" ]; then
    CONFIG_FILE="$HOME/.zshrc"
else
    echo "Unsupported shell"
    exit 1
fi

cat << 'EOF' >> $CONFIG_FILE
alias ls='lsd'
alias cat='batcat'
alias vi='nvim'
alias vim='nvim'
alias catn='/usr/bin/cat'
alias cls="clear"
alias cls="clear && figlet $USER -f larry3d | lolcat"
alias upg="sudo apt update"
alias upd="sudo apt upgrade"
alias zshrc="nano ~/.zshrc"
alias bashrc="nano ~/.bashrc"
alias $USER="figlet $USER -f larry3d | lolcat"
alias sd="sudo su && clear && figlet $USER -f larry3d | lolcat"
alias home="cd ~"
alias cd..="cd .."
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias apt="sudo apt"
alias apti="sudo apt install"
alias rm="rm -rfd"
alias df="df -h"
alias du="du -h"
alias ll="ls -la"
alias l="ls -l"
alias h="history"
alias j="jobs"
alias p="ps aux"
alias e="exit"
alias q="exit"
alias x="exit"
EOF