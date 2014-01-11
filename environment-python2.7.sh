#!/usr/bin/env bash

# Find python installation prefix
PYTHON_PREFIX=$(pyenv virtualenv-prefix 2>/dev/null || pyenv prefix 2>/dev/null || which python 2>/dev/null)
PYTHON_PREFIX=${PYTHON_PREFIX%%/bin/python}
if [[ -n $PYTHON_PREFIX ]]; then
    echo "Python installation prefix: $PYTHON_PREFIX"
else
    echo 'Error finding python installation prefix.'
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

# Find python library file
PYTHON_DYN_LIB_FILE="$PYTHON_PREFIX/lib/libpython2.7.so" # (pyenv)
PYTHON_DYN_LIB_FILE_TWO="$PYTHON_PREFIX/lib/python2.7/config/libpython2.7.so" # Did this ever work? YEP! (System)
if [[ -e $PYTHON_DYN_LIB_FILE ]]; then
    PYTHON_LIBRARY=$PYTHON_DYN_LIB_FILE
elif [[ -e $PYTHON_DYN_LIB_FILE_TWO ]]; then
    PYTHON_LIBRARY=$PYTHON_DYN_LIB_FILE_TWO
else
    echo 'Error finding python library file.'
    exit 1
fi

echo "Python library file: $PYTHON_LIBRARY"

export PYTHON_INCLUDE_DIR
export PYTHON_LIBRARY