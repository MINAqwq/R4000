#!/bin/sh


TC_FOLDER=$(pwd)/toolchain

TC_BINUTILS_TARGET=mips64el-linux-gnuabi64
TC_BINUTILS_VERSION=2.42
TC_BINUTILS_ARCHIVE=binutils.tgz

TC_GCC_TARGET=mips64el-linux-gnuabi64
TC_GCC_VERSION=13.1.0
TC_GCC_ARCHIVE=gcc.tgz

# create toolchain folder
if [ ! -d "$TC_FOLDER" ]; then
        mkdir -v -p "$TC_FOLDER" || exit
fi

# download binutils
if [ ! -e "$TC_FOLDER/$TC_BINUTILS_ARCHIVE" ]; then
        curl "https://ftp.gnu.org/gnu/binutils/binutils-$TC_BINUTILS_VERSION.tar.bz2" \
        -o "$TC_FOLDER/$TC_BINUTILS_ARCHIVE" || exit
fi


# extract binutils
if [ ! -d "$TC_FOLDER/binutils-$TC_BINUTILS_VERSION" ]; then
        cd $TC_FOLDER
        echo "enter: folder $TC_FOLDER"

        tar xvf "$TC_BINUTILS_ARCHIVE" || (cd -; exit)

        echo "leave: folder $TC_FOLDER"
        cd -
fi

echo "enter: $TC_FOLDER/binutils-$TC_BINUTILS_VERSION"
cd "$TC_FOLDER/binutils-$TC_BINUTILS_VERSION"

# configure binutils
if [ ! -e "Makefile" ]; then
        ./configure --prefix=$TC_FOLDER \
                --target=$TC_BINUTILS_TARGET \
                --disable-nls \
                --disable-werror || (cd -; exit)
fi

# build binutils
make -j4 || (cd -; exit)

# install binutils to prefix
make install || (cd -; exit)

cd -
echo "leave: $TC_FOLDER/binutils-$TC_BINUTILS_VERSION"

# download gcc
if [ ! -e "$TC_FOLDER/$TC_GCC_ARCHIVE" ]; then
        curl "https://ftp.gnu.org/gnu/gcc/gcc-$TC_GCC_VERSION/gcc-$TC_GCC_VERSION.tar.xz" \
        -o "$TC_FOLDER/$TC_GCC_ARCHIVE" || (cd -; exit)
fi

# extract gcc
if [ ! -d "$TC_FOLDER/gcc-$TC_GCC_VERSION" ]; then
             cd $TC_FOLDER
        echo "enter: folder $TC_FOLDER"

        tar xvf "$TC_GCC_ARCHIVE" || (cd -; exit)

        echo "leave: folder $TC_FOLDER"
        cd -   
fi

echo "enter: $TC_FOLDER/gcc-$TC_GCC_VERSION"
cd "$TC_FOLDER/gcc-$TC_GCC_VERSION"

# configure gcc
if [ ! -e "Makefile" ]; then
        ./configure --prefix=$TC_FOLDER \
                --target=$TC_GCC_TARGET \
                --with-gnu-as \
                --with-gnu-ld \
                --enable-languages=c || exit
fi

# build gcc
make -j4 || (cd -; exit)

# install gcc to prefix
make install -j4 || (cd -; exit)

make install-gcc -j4 || (cd -; exit)

cd -
echo "leave: $TC_FOLDER/binutils-$TC_GCC_VERSION"
