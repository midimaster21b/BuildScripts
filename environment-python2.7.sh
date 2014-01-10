#!/usr/bin/env bash

PYENV_SHIMS=$(expr `which python` : '.*\(.pyenv/shims\).*')

if [[ $PYENV_SHIMS == '.pyenv/shims' ]]; then
    echo "pyenv is used."
    PYTHON_EXECUTABLE=`pyenv which python`
else
    echo "pyenv not present."
    PYTHON_EXECUTABLE=`which python`
fi

echo "Python executable file: $PYTHON_EXECUTABLE"

# Find python installation prefix
PYTHON_EXECUTABLE_ENDING='/bin/python'
PYTHON_PREFIX=`expr "$PYTHON_EXECUTABLE" : "\(.*\)$PYTHON_EXECUTABLE_ENDING"`
if [[ -e $PYTHON_PREFIX ]]; then
    echo "Python installation prefix: $PYTHON_PREFIX"
else
    echo 'Python installation prefix not found.'
    exit 1
fi

# Find python include directory
PYTHON_INCLUDE_DIR="$PYTHON_PREFIX/include/python2.7"
if [[ -d $PYTHON_INCLUDE_DIR ]]; then
    echo "Python include directory: $PYTHON_INCLUDE_DIR"
else
    echo 'Error finding python include directory.'
    exit 1
fi

# -L vs. -h ?
# If is a symbolic link
if [[ -L $PYTHON_INCLUDE_DIR ]]; then
    PYTHON_LIBRARY_PREFIX=`readlink -f $PYTHON_INCLUDE_DIR/../..`
else
    PYTHON_LIBRARY_PREFIX=$PYTHON_PREFIX
fi

echo "Library prefix is: $PYTHON_LIBRARY_PREFIX"

PYTHON_DYN_LIB_FILE="$PYTHON_LIBRARY_PREFIX/lib/libpython2.7.so" # (pyenv)
PYTHON_DYN_LIB_FILE_TWO="$PYTHON_LIBRARY_PREFIX/lib/python2.7/config/libpython2.7.so" # Did this ever work? YEP! (System)

# Find python library file
if [[ -e $PYTHON_DYN_LIB_FILE ]]; then
    PYTHON_LIBRARY_FILE=$PYTHON_DYN_LIB_FILE
elif [[ -e $PYTHON_DYN_LIB_FILE_TWO ]]; then
    PYTHON_LIBRARY_FILE=$PYTHON_DYN_LIB_FILE_TWO
else
    echo "Error finding python library file."
    exit 1
fi

echo "Python library file: $PYTHON_LIBRARY_FILE"

echo 'Done.'

# [1]> cd /usr/
#  - | No Repository. | No branch. | /usr 
# [2]> sudo find . -name "libpython*.so"
# ./lib/libpeas-1.0/loaders/libpythonloader.so
# ./lib/python2.7/config/libpython2.7.so