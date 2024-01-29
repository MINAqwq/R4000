#!/bin/sh


TC_FOLDER=$(pwd)/toolchain

TC_BINUTILS_TARGET=mips64el-ecoff
TC_BINUTILS_VERSION=2.10.1
TC_BINUTILS_ARCHIVE=binutils.tgz

TC_GCC_HOST=i386
TC_GCC_TARGET=mips64el-ecoff
TC_GCC_VERSION=2.5.8
TC_GCC_ARCHIVE=gcc.tgz

# create toolchain folder
if [ ! -d "$TC_FOLDER" ]; then
        mkdir -v -p "$TC_FOLDER" || exit
fi

# download binutils
if [ ! -e "$TC_FOLDER/$TC_BINUTILS_ARCHIVE" ]; then
        curl "https://ftp.gnu.org/gnu/binutils/binutils-2.10.1a.tar.bz2" \
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
                --with-float=soft \
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
        curl "https://ftp.gnu.org/old-gnu/gcc/gcc-$TC_GCC_VERSION.tar.gz" \
        -o "$TC_FOLDER/$TC_GCC_ARCHIVE" || (cd -; exit)
fi

# extract gcc
if [ ! -d "$TC_FOLDER/binutils-$TC_GCC_VERSION" ]; then
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
                --host=$TC_GCC_HOST \
                --target=$TC_GCC_TARGET \
                --with-gnu-as \
                --with-gnu-ld \
                --with-float=soft \
                --enable-languages=c || exit
fi

# build gcc
make gcc || (cd -; exit)

# install gcc to prefix
make install || (cd -; exit)

cd -
echo "leave: $TC_FOLDER/binutils-$TC_GCC_VERSION"
