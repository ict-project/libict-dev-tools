#!/bin/bash
SCRIPT_DIR="$(dirname $(pwd)/$0)"
TARGET_DIR=$(realpath $SCRIPT_DIR/..)
FILE_LIST="LICENSE configure.sh .gitignore Makefile do-all.sh"
FILE_OPT="README.md"

echo "You are about to update the following files:"
for file in $FILE_LIST; do
  echo "$TARGET_DIR/$file"
done
for file in $FILE_OPT; do
  echo "$TARGET_DIR/$file (if not exists)"
done
echo "Do you want to continue? [y/N]"
read -r response

case "$response" in
    [yY]* | [tT]* )
        for file in $FILE_LIST; do
            cp -vf "$SCRIPT_DIR/$file" "$TARGET_DIR/$file"
        done
        for file in $FILE_OPT; do
            test -r "$TARGET_DIR/$file" || cp -vf "$SCRIPT_DIR/$file" "$TARGET_DIR/$file"
        done
        ;;
    *)
        echo "Update canceled."
        ;;
esac
