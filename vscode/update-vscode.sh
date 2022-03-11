#!/usr/bin/env bash

# script to update VSCode to latest version when VSCode is installed in portable mode 
#
VS_CODE_INSTAL_FOLDER="vscode"
VS_CODE_INSTALL_LOCATION="/home/anjan/work/apps"

backup_ext=$(date +'%b-%d')

# download latest version - hint VSCode will prompt you if there is new version available
VS_CODE_FILE="code.stable.tar.gz"

# download directory destination 
SW_FOLDER="/home/anjan/work/sw/microsoft"

# direct download link is https://code.visualstudio.com/sha/download?build=stable\&os=linux-x64
# note: we have to escape & sign in url
URL="https://code.visualstudio.com/sha/download?build=stable\&os=linux-x64"

wget  $URL -O "$SW_FOLDER/$VS_CODE_FILE"

# backup existing vscode if it is not running , else prompt to stop VSCode and retun this script

if [ $(pgrep -c code) != "0" ]; then
	echo "VSCode is running.... , please stop VSCode and re-run this script"
	exit -1
else
	# backup existing vscode install
	mv "$VS_CODE_INSTALL_LOCATION/$VS_CODE_INSTAL_FOLDER" "$VS_CODE_INSTALL_LOCATION/$VS_CODE_INSTAL_FOLDER.$backup_ext"

	# extract new vscode to install location 
	tar -xzf "$SW_FOLDER/$VS_CODE_FILE"  -C "$VS_CODE_INSTALL_LOCATION/"

	# it extract as VSCode-linux-x64
	# rename VSCode-linux-x64 to  vscode
	mv "$VS_CODE_INSTALL_LOCATION/VSCode-linux-x64" "$VS_CODE_INSTALL_LOCATION/$VS_CODE_INSTAL_FOLDER"

	# copy data folder from  previous VSCode install  to  this new install

	mv "$VS_CODE_INSTALL_LOCATION/$VS_CODE_INSTAL_FOLDER.$backup_ext/data" "$VS_CODE_INSTALL_LOCATION/$VS_CODE_INSTAL_FOLDER/"
fi