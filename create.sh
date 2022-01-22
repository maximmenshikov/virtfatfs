#!/bin/bash

export TOP_DIR="$(cd "$(dirname "$(which "$0")")" ; pwd -P)"

cd ${TOP_DIR}

function fail()
{
	echo $@ >&2
	exit 1
}

data_dir="$1"
img_file="$2"
img_size="$3"

if [ ! -d ${data_dir} ] ; then
	fail "Directory is missing: ${data_dir}"
fi

if [ "${img_file}" == "" ] ; then
	fail "Image file is not set"
fi

if [ "${img_size}" == "" ] ; then
	fail "Image size is not set"
fi

dd if=/dev/zero "of=${img_file}" "count=${img_size}" bs=1M \
	> /dev/null 2> /dev/null \
	|| fail "Failed to allocate FAT image"
mkfs.fat "${img_file}" \
	> /dev/null \
	|| fail "Failed to create FAT image"

result=$(./mount.sh "${img_file}")
media="$(echo $result | awk '{print $1}')"
loop="$(echo $result | awk '{print $2}')"
echo "Media: $media"
echo "Loop: $loop"
rsync --progress -r "${data_dir}" "${media}/"
sync "${media}/"
./unmount.sh "$loop"