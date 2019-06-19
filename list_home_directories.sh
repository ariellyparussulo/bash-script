#!/bin/bash

FILE_LIST_OF_DIRECTORY_HOME=./list_of_directories_in_home
ZIP_LIST_OF_DIRECTORY_HOME=compressed.zip

function listDirectories {
	ls "$1" | while read file; do
		if [ -d "$1/$file" ]; then
			echo "$1/$file" >> $FILE_LIST_OF_DIRECTORY_HOME
			listDirectories "$1/$file"
		fi
	done
}

echo "Listing directories..."
listDirectories ~

echo "Compressing list of directories..."
zip $ZIP_LIST_OF_DIRECTORY_HOME $FILE_LIST_OF_DIRECTORY_HOME
rm -f $FILE_LIST_OF_DIRECTORY_HOME
echo "Compression finished"

echo "Please, inform an USB flash drive where you want to copy the file: "
read DRIVE_PATH

MOUNTED_PATH=`df $DRIVE_PATH | awk 'NR == 2 { print $6  }'`
echo $MOUNTED_PATH
if [ -d "$MOUNTED_PATH" ]; then
	mv $ZIP_LIST_OF_DIRECTORY_HOME $MOUNTED_PATH
	rm $ZIP_LIST_OF_DIRECTORY_HOME	
else
	echo "Drive doesn't exist."
fi	
