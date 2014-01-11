#!/bin/sh
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

