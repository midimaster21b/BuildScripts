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

export PREFIX=~/pyside
export PYTHON_INCLUDE_DIR
export PYTHON_INCLUDE_DIRS=PYTHON_INCLUDE_DIR
export PYTHON_LIBRARY

# TODO: Allow debug build type... 'export BUILD_TYPE=Debug'
export BUILD_TYPE=Release

# TODO: Implement support for python 3
export PYTHONXY='python2.7'

# Required environment variables
export PATH=$PREFIX/bin:$PATH
export PYTHONPATH=$PREFIX/lib/$PYTHONXY/site-packages:$PREFIX/lib64/$PYTHONXY/site-packages:$PYTHONPATH
export LD_LIBRARY_PATH=$PREFIX/lib:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH
export DYLD_LIBRARY_PATH=$PREFIX/lib:$DYLD_LIBRARY_PATH

# If you want to use Qt Simulator, uncomment following line and set the
# enviroment variable $QT_SDK_HOME to the directory that contains the Qt
# tools for the Simulator platform (for example $HOME/qtsdk/Simulator/Qt/gcc/bin")

#Q_WS_SIMULATOR="yes"

# If you want to use Qt SDK, uncomment the following line, or set the
# environment variable $QT_SDK_HOME in something like your ~/.profile

#QT_SDK_HOME="$HOME/qtsdk/Desktop/Qt/474/gcc"

if [ "$QT_SDK_HOME" != "" ]; then
  export PATH=$QT_SDK_HOME/bin:$QT_SDK_HOME/qt/bin:$PATH
  export LD_LIBRARY_PATH=$QT_SDK_HOME/lib:$LD_LIBRARY_PATH
  export QTDIR=$QT_SDK_HOME:$QT_SDK_HOME/qt:$QTDIR
fi

