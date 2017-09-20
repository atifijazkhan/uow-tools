#!/bin/bash

#==========================
#INIT
#==========================
source ~/workspace/software/bin/env.build
build_init


#==========================
#BASE Installation
#==========================




#==================================
#cudann
#==================================
SRC_FILE=cudnn-8.0-linux-x64-v7.tgz
tar xf $DOWNLOAD_DIR/$SRC_FILE -C $MY_LOCAL
ln -s -r $MY_LOCAL/cuda/lib64/* $MY_LOCAL/lib/
ln -s -r $MY_LOCAL/cuda/include/* $MY_LOCAL/include/
ln -s /usr/local/cuda-8.0/targets/x86_64-linux/lib/libOpenCL.so $MY_LOCAL/lib/

#openjpeg
#============================================
SRC_FILE=openjpeg-v2.2.0-linux-x86_64.tar.gz
tar xf $DOWNLOAD_DIR/$SRC_FILE -C $MY_LOCAL
PKG_BLD_DIR=$MY_LOCAL/openjpeg-v2.2.0-linux-x86_64
ln -s -r $PKG_BLD_DIR/bin/* $MY_LOCAL/bin/
ln -s -r $PKG_BLD_DIR/include/* $MY_LOCAL/include/
ln -s -r $MY_LOCAL/include/openjpeg-2.2/* $MY_LOCAL/include/
ln -s -r $PKG_BLD_DIR/lib/pkgconfig/* $MY_LOCAL/lib/pkgconfig/
ln -s -r $PKG_BLD_DIR/lib/* $MY_LOCAL/lib/


#mysql-connector
#============================================
SRC_FILE=mysql-connector-c-6.1.11-linux-glibc2.12-x86_64.tar.gz
tar xf $DOWNLOAD_DIR/$SRC_FILE -C $MY_LOCAL
PKG_BLD_DIR=$MY_LOCAL/mysql-connector-c-6.1.11-linux-glibc2.12-x86_64
ln -s -r $PKG_BLD_DIR/bin/*     $MY_LOCAL/bin/
ln -s -r $PKG_BLD_DIR/include/* $MY_LOCAL/include/
ln -s -r $PKG_BLD_DIR/lib/*     $MY_LOCAL/lib/


#bzip2
#======================
SRC_FILE=bzip2-1.0.6.tar.gz
PKG_DIR_NAME=`tar -tf $DOWNLOAD_DIR/$SRC_FILE | head -n 1 | cut -d'/' -f1`
PKG_BLD_DIR=$BUILD_DIR/$PKG_DIR_NAME
rm -Rf $PKG_BLD_DIR
tar xf $DOWNLOAD_DIR/$SRC_FILE -C $BUILD_DIR
cd $PKG_BLD_DIR
make -f Makefile-libbz2_so
make clean
sed -i "s/^CC=gcc$/CC=gcc -fPIC/g" Makefile
make
make install PREFIX=$MY_LOCAL
cd -


#OpenBlas
#================
SRC_FILE=v0.2.20.tar.gz
PKG_DIR_NAME=`tar -tf $DOWNLOAD_DIR/$SRC_FILE | head -n 1 | cut -d'/' -f1`
PKG_BLD_DIR=$BUILD_DIR/$PKG_DIR_NAME
rm -Rf $PKG_BLD_DIR
tar xf $DOWNLOAD_DIR/$SRC_FILE -C $BUILD_DIR
cd $PKG_BLD_DIR
make -j32 FC=gfortran
make PREFIX=$MY_LOCAL install
cd -


# Rust
#==============
RUSTUP_HOME=$MY_LOCAL/rustup CARGO_HOME=$MY_LOCAL/cargo bash -c 'curl https://sh.rustup.rs -sSf | sh -s -- -y'
ln -s -r $MY_LOCAL/cargo/bin/* $MY_LOCAL/bin/



#================================================================================================
# The order of install is important.
#================================================================================================
export MAKE_PARAMS=-j32 
std_make readline-7.0.tar.gz
std_make curl-7.55.1.tar.gz
std_make xz-5.2.3.tar.bz2
std_make zlib-1.2.11.tar.gz
std_make jpegsrc.v9b.tar.gz
std_make texinfo-6.5.tar.xz
std_make gnuplot-5.2.0.tar.gz
std_make glpk-4.63.tar.gz
std_make hdf5-1.10.1.tar.bz2
std_make pixman-0.34.0.tar.gz
std_make cairo-1.14.10.tar.xz
std_make gsl-2.4.tar.gz
std_make poppler-0.59.0.tar.xz
MAKE_PARAMS=-j32  CONFIG_PARAMS="--enable-pcre16 --enable-pcre32 --enable-pcregrep-libz --enable-pcregrep-libbz2 --enable-jit --enable-utf --enable-unicode-properties" std_make pcre-8.41.tar.gz
std_make libxml2-sources-2.9.5.tar.gz
std_make libxslt-1.1.30.tar.gz
std_make tiff-4.0.8.tar.gz
std_make harfbuzz-1.5.1.tar.bz2
std_make libcroco-0.6.12.tar.xz
std_make pango-1.40.12.tar.xz
CONFIG_PARAMS="--disable-libmount" std_make glib-2.54.0.tar.xz
std_make gobject-introspection-1.54.0.tar.xz
std_make gdk-pixbuf-2.36.10.tar.xz
RUSTUP_HOME=$MY_LOCAL/rustup CARGO_HOME=$MY_LOCAL/cargo std_make librsvg-2.41.0.tar.xz
std_make ImageMagick.tar.gz

unset MAKE_PARAMS

#==========================
#OCTAVE Installation
#==========================

#ARPACK
cd $BUILD_DIR
git clone https://github.com/opencollab/arpack-ng.git
cd arpack-ng/
sh bootstrap 
./configure --prefix=$MY_LOCAL --with-blas=$MY_LOCAL/lib/libopenblas.so
make -j32
make install

#FFTW, GLPK, FLTK, HDF5, GraphicsMagic
MAKE_PARAMS=-j32 CONFIG_PARAMS="--enable-float --enable-shared" std_make fftw-3.3.6-pl2.tar.gz
MAKE_PARAMS=-j32 std_make glpk-4.63.tar.gz
MAKE_PARAMS=-j32 CONFIG_PARAMS="--enable-shared --enable-localjpeg" std_make fltk1.3_1.3.4.orig.tar.gz
#MAKE_PARAMS=-j32 std_make hdf5-1.10.1.tar.bz2
MAKE_PARAMS=-j32 CONFIG_PARAMS="--with-quantum-depth=16 --enable-shared --disable-static --with-magick-plus-plus=yes" std_make GraphicsMagick-1.3.26.tar.xz

#Qhull
cd ~/tools/build
tar xf ../downloads/qhull-2015-src-7.2.0.tgz
cd qhull-2015.2/build/
cmake -DCMAKE_INSTALL_PREFIX=$MY_LOCAL ..
make -j32
make install
cd -

#QRUPDATE
cd ~/tools/build
tar xf ~/tools/downloads/qrupdate-1.1.2.tar.gz
cd ~/tools/build/qrupdate-1.1.2
sed -i -e "s/-lblas/\/home\/a78khan\/tools\/local\/lib\/libopenblas.so/g" Makeconf -e "s/-llapack/\/home\/a78khan\/tools\/local\/lib\/libopenblas.so/g" -e "s/PREFIX=\/usr\/local/PREFIX=\/home\/a78khan\/tools\/local/g"
make -j32 solib
make install
cd -

#Sparse Suite
cd ~/tools/build/
tar xf ~/tools/downloads/SuiteSparse-4.5.5.tar.gz
cd SuiteSparse
make -j32 BLAS=$MY_LOCAL/lib/libopenblas.so LAPACK=/usr/lib/liblapack.so.3 library 
make INSTALL=$MY_LOCAL BLAS=$MY_LOCAL/lib/libopenblas.so LAPACK=/usr/lib/liblapack.so.3 install
cd -


#======================
#Octave
#	x = -10:0.1:10;
#	plot (x, sin (x));
#======================
MAKE_PARAMS=-j32 CONFIG_PARAMS="F77=gfortran --without-opengl --without-qt" std_make octave-4.2.1.tar.xz 

#================
# R
#================
MAKE_PARAMS=-j32 CONFIG_PARAMS="--enable-R-shlib --with-cairo --with-jpeglib --with-jpeglib --with-readline --with-tcltk --with-blas=$MY_LOCAL/lib/libopenblas.so --with-lapack --enable-R-shlib --enable-java" std_make R-3.4.1.tar.gz

R --no-save --no-restore
wget -P /tmp https://raw.githubusercontent.com/atifijazkhan/uow-tools/master/install-packages.R
