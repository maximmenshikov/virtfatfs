#!/bin/bash

export TOP_DIR="$(cd "$(dirname "$(which "$0")")"/.. ; pwd -P)"

cd ${TOP_DIR}

img_file="$1"

function fail()
{
	echo $@ >&2
	exit 1
}

if [ "${img_file}" == "" ] ; then
	fail "Image file is not set"
fi

result="$(env LC_ALL=C.UTF-8 udisksctl loop-setup -f "${img_file}" \
		  --no-user-interaction)"
loop="$(echo $result | sed -E "s/.*(\/dev\/.*)\./\1/")"
if [ "$loop" == "" ] ; then
	fail "Failed to make a loop out of image file"
fi

result="$(env LC_ALL=C.UTF-8 udisksctl mount --block-device "$loop")"
media="$(echo $result | sed -E "s/.*(\/media\/.*)\./\1/")"
if [ ! -d "${media}" ] ; then
	fail "Failed to mount image"
fi
echo "$media"
echo "$loop"
