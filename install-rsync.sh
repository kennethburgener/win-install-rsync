#!/bin/bash

# Updated version based on https://scicomp.aalto.fi/scicomp/rsynconwindows/

# We first switch to the home directory-
cd
# create the users bin and lib folders if it doesn't exist
mkdir -p ~/bin
mkdir -p ~/lib
# create a emporary installation folder
mkdir tempinstall
cd tempinstall

# Download zstd
curl --fail -LSs https://github.com/facebook/zstd/releases/download/v1.5.7/zstd-v1.5.7-win64.zip -o zstd.zip
if [ $? -ne 0 ] ; then
  echo "Failed to download zstd 1.5.7"
  exit 1
fi
# Unzip zstd and copy it to an executable folder
unzip zstd.zip
# move zstd to the binary folder and delete the local copy
cp -r zstd-v1.5.7-win64/* ../bin
rm -rf zstd*

# Download rsync
curl -LSs https://repo.msys2.org/msys/x86_64/rsync-3.3.0-1-x86_64.pkg.tar.zst -o rsync.tar.zst
if [ $? -ne 0 ] ; then
  echo "Failed to download rsync 3.4.1"
  exit 1
fi

# Download required libraries for rsync
curl --fail -LSs https://repo.msys2.org/msys/x86_64/rsync-3.4.1-1-x86_64.pkg.tar.zst -o rsync.tar.zst
if [ $? -ne 0 ] ; then
  echo "Failed to download rsync 3.4.1-1"
  exit 1
fi
curl --fail -LSs https://repo.msys2.org/msys/x86_64/libzstd-devel-1.5.7-1-x86_64.pkg.tar.zst -o libzstd.tar.zst
if [ $? -ne 0 ] ; then
  echo "Failed to download libzstd 1.5.7-1"
  exit 1
fi
curl --fail -LSs https://repo.msys2.org/msys/x86_64/libxxhash-0.8.3-1-x86_64.pkg.tar.zst -o libxxhash.tar.zst
if [ $? -ne 0 ] ; then
  echo "Failed to download libxxhash 0.8.3-1"
  exit 1
fi
curl --fail -LSs https://repo.msys2.org/msys/x86_64/libopenssl-3.6.1-1-x86_64.pkg.tar.zst -o libopenssl.tar.zst
if [ $? -ne 0 ] ; then
  echo "Failed to download libopenssl 3.6.1-1"
  exit 1
fi
# Extract downloaded packages
tar -I zstd -xvf rsync.tar.zst
tar -I zstd -xvf libzstd.tar.zst
tar -I zstd -xvf libxxhash.tar.zst
tar -I zstd -xvf libopenssl.tar.zst
cp -r usr/bin/* ~/bin
cp -r usr/lib/* ~/lib
cd ..
rm -rf tempinstall
echo "rsync should now be installed in ~/bin"
