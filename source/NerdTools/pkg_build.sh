#!/bin/bash
DIR="$(dirname "$(readlink -f ${BASH_SOURCE[0]})")"
NAME=$(basename ${DIR})
tmpdir=/tmp/tmp.$(( $RANDOM * 19318203981230 + 40 ))
ARCHIVE_DIR="$(dirname $(dirname ${DIR}))/archive"
VERSION=$(date +"%Y.%m.%d")$1

PACKAGE_NAME="${NAME}-${VERSION}-x86_64-1"
PACKAGE_FILE="${ARCHIVE_DIR}/${PACKAGE_NAME}.txz"
MD5_PATH="${ARCHIVE_DIR}/${PACKAGE_NAME}.md5"

echo $DIR
echo $tmpdir
echo $plugin
echo $ARCHIVE_DIR
echo $VERSION

mkdir -p $tmpdir
cp --parents -f $(find . -type f ! \( -iname "pkg_build.sh" -o -iname "sftp-config.json"  \) ) $tmpdir/
cd $tmpdir

makepkg $PACKAGE_FILE
md5sum $PACKAGE_FILE >$MD5_PATH

chown 1000:1000 $PACKAGE_FILE
chown 1000:1000 $MD5_PATH


R_HASH=$(cat $MD5_PATH)
TR_HASH="${R_HASH%% *}"

C_HASH=$(md5sum $PACKAGE_FILE)
TC_HASH="${C_HASH%% *}"

echo "Hash in .md5: $TR_HASH"
echo "Hash of .txz: $TC_HASH"

if [ "${TR_HASH}" != "${TC_HASH}" ]; then
    echo "Checksum mismatched."
    exit 1
else
    echo "Checksum matched."
fi