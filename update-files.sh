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
echo "$TARGET_DIR/source/CMakeLists.txt (if not exists)"
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
        mkdir -p "$TARGET_DIR/source"
        test -r "$TARGET_DIR/source/CMakeLists.txt" || cp -vf "$SCRIPT_DIR/CMakeLists-template.cmake" "$TARGET_DIR/source/CMakeLists.txt"
        ;;
    *)
        echo "Update canceled."
        ;;
esac
