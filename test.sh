#!/bin/bash
SCRIPT_DIR="$(dirname $(pwd)/$0)"
FILE_NAME=$1

rm -f $FILE_NAME

echo "#ifdef ENABLE_TESTING" >> $FILE_NAME
case "$FILE_NAME" in
*.hpp)
    echo "#include \"../libict-dev-tools/source/test.hpp\"" >> $FILE_NAME
    ;;
*.cpp)
    echo "#include \"../libict-dev-tools/source/test.cpp\"" >> $FILE_NAME
    ;;
*)
    ;;
esac
echo "#endif" >> $FILE_NAME