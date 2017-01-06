#!/bin/bash

check_emacs_installed() {
    which emacs &> /dev/null
    if [ $? -eq 0 ] ; then
	echo "Emacs is already installed."
	emacs_installed=true
    else
	emacs_installed=false
    fi
}

find_emacs_version() {
    emacs_version=$(emacs --version | egrep -o "([0-9]{1,}\.)+[0-9]{1,}")
    emacs_version=${emacs_version:0:4}
}

install_emacs() {
    platform=$(uname)
    if [[ $platform == "Darwin" ]]; then
        brew install emacs --with-cocoa --with-gnutls
    elif [[ $platform == "Linux"  ]]; then
	#taken from http://askubuntu.com/a/546050
	mkdir emacs-src && cd emacs-src
	wget http://mirror.team-cymru.org/gnu/emacs/emacs-24.4.tar.gz
        tar xvf emacs-24.4.tar.gz

        sudo apt-get install build-essential
        sudo apt-get build-dep emacs24
        cd emacs-24.4
        ./configure
        make
        sudo make install
	cd ../../
        rm -rf emacs-src
    fi
}

backup_existing_emacs_config() {
    date=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    backup_directory=~/emacs_backup-${date}
    echo ${backup_directory}
    mkdir ${backup_directory}
    cp ~/.emacs ${backup_directory}
    cp -r ~/.emacs.d/ ${backup_directory}/.emacs.d/
}

install_emacs_config() {
    echo "Installing dotfiles"
    cp .emacs ~/.emacs
    cp -r .emacs.d/ ~/emacs.d/
}

check_emacs_installed
if [ $emacs_installed ]; then
    find_emacs_version
    minimum_version="24.4"
    if [ "$emacs_version" > "$minimum_version" ]; then
	backup_existing_emacs_config
	install_emacs_config
    else
	echo "The version of Emacs installed on this system is not supported."
	echo  "Please install Emacs version 24.4 or greater."
    fi
else
    install_emacs
    install_emacs_config
fi
