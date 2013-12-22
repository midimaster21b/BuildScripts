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
    return
fi

# Find python library file
PYTHON_STATIC_LIB_FILE="$PYTHON_PREFIX/lib/python2.7/config/libpython2.7.a"
PYTHON_DYN_LIB_FILE="$PYTHON_PREFIX/lib/python2.7/config/libpython2.7.so"
if [[ -e $PYTHON_DYN_LIB_FILE ]]; then
    echo "Python library file: $PYTHON_DYN_LIB_FILE"
    PYTHON_LIBRARY_FILE=$PYTHON_DYN_LIB_FILE
elif [[ -e $PYTHON_STATIC_LIB_FILE ]]; then
    echo "Python library file: $PYTHON_STATIC_LIB_FILE (Warning: static library)"
    PYTHON_LIBRARY_FILE=$PYTHON_STATIC_LIB_FILE
else
    echo "Error finding python library file."
    return
fi

# Find python include directory
PYTHON_INCLUDE_DIR="$PYTHON_PREFIX/include/python2.7"
if [[ -e $PYTHON_INCLUDE_DIR ]]; then
    echo "Python include directory: $PYTHON_INCLUDE_DIR"
else
    echo 'Error finding python include directory.'
    return
fi

echo 'Done.'

# [1]> cd /usr/
#  - | No Repository. | No branch. | /usr 
# [2]> sudo find . -name "libpython*.so"
# ./lib/libpeas-1.0/loaders/libpythonloader.so
# ./lib/python2.7/config/libpython2.7.so