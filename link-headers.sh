#!/bin/bash
SCRIPT_DIR="$(dirname $(pwd)/$0)"
TARGET_DIR=$(realpath $SCRIPT_DIR/..)
INCLUDE_DIR=$TARGET_DIR/include

# Sparwdź czy katalog include istnieje, jeśli nie przerwij skrypt
[ ! -d $INCLUDE_DIR ] &&  { echo "Katalog $INCLUDE_DIR nie istnieje."; exit 1; }

# Przejście po wszystkich katalogach libict-*
for dir in $(find $TARGET_DIR -mindepth 1 -maxdepth 1 -type d -name "libict-*"); do
    # Na podstawie nazwy katalogu utwórz nazwę (usunięcie prefiksu 'libict-')
    libname=$(basename $dir | sed 's/libict-//')
    # Przejście po wszystkich plikach nagłówkowych w katalogu
    for file in $(find $dir/source -name "*.hpp"); do
        header=$(basename $file)
        path=$INCLUDE_DIR/libict/$libname/$header
        mkdir -p $(dirname $path)
        # Jeśli plik nagłówkowy nie istnieje w katalogu include, to utwórz link symboliczny
        if [ ! -L $path ]; then
            ln -svrf $file $path
        fi
    done
done

echo "Gotowe."