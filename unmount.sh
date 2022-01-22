#!/bin/bash

export TOP_DIR="$(cd "$(dirname "$(which "$0")")"/.. ; pwd -P)"

cd ${TOP_DIR}

loop="$1"

function fail()
{
	echo $@ >&2
	exit 1
}

if [ "${loop}" == "" ] ; then
	fail "Loop device is not set"
fi

env LC_ALL=C.UTF-8 udisksctl unmount --block-device "${loop}" \
	|| fail "Failed to unmount image"
env LC_ALL=C.UTF-8 udisksctl loop-delete --block-device "${loop}" \
	|| fail "Failed to delete loop"
