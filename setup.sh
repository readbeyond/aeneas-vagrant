#!/bin/bash

# Author: Alberto Pettarin
# Copyright: 2015, Alberto Pettarin (www.albertopettarin.it)
# License: GNU AGPL v3
# Version: 1.3.0
# Email: aeneas@readbeyond.it
# Status: Production

DEB="deb-multimedia-keyring_2015.6.1_all.deb"
DIR="aeneas"

if ! [ -e "$DIR" ]
then
    echo "[INFO] Setting vagrant box up..."

    echo "[INFO] A.1 Adding some popular Debian mirrors to apt sources..."
    #
    # append to /etc/apt/sources.list
    #
    #sudo sh -c 'echo "" >> /etc/apt/sources.list'
    #sudo sh -c 'echo "deb http://debian.ethz.ch/debian/ jessie main" >> /etc/apt/sources.list'
    #sudo sh -c 'echo "deb-src http://debian.ethz.ch/debian/ jessie main" >> /etc/apt/sources.list'
    #sudo sh -c 'echo "" >> /etc/apt/sources.list'
    #sudo sh -c 'echo "deb http://debian.csail.mit.edu/debian/ jessie main" >> /etc/apt/sources.list'
    #sudo sh -c 'echo "deb-src http://debian.csail.mit.edu/debian/ jessie main" >> /etc/apt/sources.list'
    #sudo sh -c 'echo "" >> /etc/apt/sources.list'
    #sudo sh -c 'echo "deb http://mirror.cse.unsw.edu.au/debian/ jessie main" >> /etc/apt/sources.list'
    #sudo sh -c 'echo "deb-src http://mirror.cse.unsw.edu.au/debian/ jessie main" >> /etc/apt/sources.list'
    #sudo sh -c 'echo "" >> /etc/apt/sources.list'
    #
    # create entries in /etc/apt/sources.list.d/
    #
    sudo sh -c 'echo "deb http://debian.ethz.ch/debian/ jessie main" >> /etc/apt/sources.list.d/ethz.list'
    sudo sh -c 'echo "deb-src http://debian.ethz.ch/debian/ jessie main" >> /etc/apt/sources.list.d/ethz.list'
    sudo sh -c 'echo "deb http://debian.csail.mit.edu/debian/ jessie main" >> /etc/apt/sources.list.d/mit.list'
    sudo sh -c 'echo "deb-src http://debian.csail.mit.edu/debian/ jessie main" >> /etc/apt/sources.list.d/mit.list'
    sudo sh -c 'echo "deb http://mirror.cse.unsw.edu.au/debian/ jessie main" >> /etc/apt/sources.list.d/unsw.list'
    sudo sh -c 'echo "deb-src http://mirror.cse.unsw.edu.au/debian/ jessie main" >> /etc/apt/sources.list.d/unsw.list'
    echo "[INFO] A.1 Adding some popular Debian mirrors to apt sources... done"

    echo "[INFO] A.2 Downloading and installing deb-multimedia keyring..."
    wget -t 5 "http://www.deb-multimedia.org/pool/main/d/deb-multimedia-keyring/$DEB"
    if ! [ -e "$DEB" ]
    then
        echo "[ERRO] Cannot download the deb-multimedia keyring."
        echo "[ERRO] This might be due to a temporary network or server problem."
        echo "[ERRO] Please retry installing this Vagrant box later."
        echo "[ERRO] If the problem persists, please send an email to aeneas@readbeyond.it"
        exit 1
    fi
    sudo dpkg -i "$DEB"
    rm "$DEB"
    echo "[INFO] A.2 Downloading and installing deb-multimedia keyring... done"

    echo "[INFO] A.3 Adding deb-multimedia to apt sources..."
    sudo sh -c 'echo "" >> /etc/apt/sources.list'
    sudo sh -c 'echo "deb http://www.deb-multimedia.org jessie main" >> /etc/apt/sources.list'
    sudo sh -c 'echo "" >> /etc/apt/sources.list'
    echo "[INFO] A.3 Adding deb-multimedia to apt sources... done"

    echo "[INFO] A.4 Updating apt..."
    sudo apt-get update
    echo "[INFO] A.4 Updating apt... done"

    echo "[INFO] B.1 Installing ffmpeg (from deb-multimedia)..."
    sudo apt-get install -y ffmpeg
    echo "[INFO] B.1 Installing ffmpeg (from deb-multimedia)... done"

    echo "[INFO] B.2 Installing espeak..."
    sudo apt-get install -y espeak espeak-data libespeak1 libespeak-dev
    echo "[INFO] B.2 Installing espeak... done"

    echo "[INFO] B.3 Installing common libs using apt-get..."
    sudo apt-get install -y build-essential
    sudo apt-get install -y flac libasound2-dev libsndfile1-dev vorbis-tools
    sudo apt-get install -y python-beautifulsoup python-dev python-lxml python-numpy python-pip
    echo "[INFO] B.3 Installing common libs using apt-get... done"
    
    echo "[INFO] C.1 Installing Python modules using pip..."
    sudo pip install BeautifulSoup lxml numpy pafy --upgrade
    echo "[INFO] C.1 Installing Python modules using pip... done"

    echo "[INFO] D.1 Installing common tools..."
    sudo apt-get install -y git
    sudo apt-get install -y file htop screen vim unzip
    echo "[INFO] D.1 Installing common tools... done"

    echo "[INFO] E.1 Cloning aeneas GitHub repo..."
    git clone https://github.com/readbeyond/aeneas.git
    echo "[INFO] E.1 Cloning aeneas GitHub repo... done"

    echo "[INFO] F.1 Running setup.py..."
    cd "$DIR"
    python setup.py build_ext --inplace
    cd ..
    echo "[INFO] F.1 Running setup.py... done"

    echo "[INFO] G.1 Transferring aeneas/ to vagrant user..."
    chown -R vagrant:vagrant "$DIR" 
    echo "[INFO] G.1 Transferring aeneas/ to vagrant user... done"
    
    echo "[INFO] Setting vagrant box up... done"
else
    echo "[INFO] This vagrant box has been already set up, nothing to do here."
fi

echo "[INFO] Congratulations, now you can use aeneas!"
