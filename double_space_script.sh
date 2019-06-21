#!/bin/bash

FILENAME=$1

if [[ -z "$FILENAME" ]]; then
	echo "Please, pass a filename as a parameter"
	exit 1
fi

if [[ ! -f "$FILENAME" ]]; then
	echo "Please, inform a valid filename"
	exit 1
fi

# copying speficied file
FILENAME_TMP="$1.tmp"
cp -f $FILENAME $FILENAME_TMP

# replace whitespace by tab
sed -i 's/    /\t/g' $FILENAME_TMP

