#!/bin/bash
TARGET_DIR=$(pwd)

if ! command -v git &> /dev/null; then
    echo "git could not be found!"
    exit 1
fi

# Sprawdzenie, czy katalog $TARGET_DIR (lub nadrzędny) jest monitorowany przez Git
if git status 2&> /dev/null ;then
    echo "Directory $TARGET_DIR is already a Git repository."
    exit 2
fi

# Inicjalizacja nowego repozytorium Git
echo "Initializing new Git repository in $TARGET_DIR"
echo "Do you want to continue? [y/N]"
read -r response
case "$response" in
    [yY]* | [tT]* )
        git init
        ;;
    *)
        echo "Initialization canceled."
        exit 3
        ;;
esac

# Dodanie submodułu libict-dev-tools
echo "Do you want to add libict-dev-tools as a Git submodule? [y/N]"
read -r response
case "$response" in
    [yY]* | [tT]* )
        git submodule add https://github.com/ict-project/libict-dev-tools.git
        ./libict-dev-tools/update-files.sh
        ;;
    *)
        echo "Adding submodule canceled."
        exit 4
        ;;
esac