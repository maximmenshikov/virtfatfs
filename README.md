# virtfatfs

Mount a file system with given data on Linux. Useful if you need
case-insensitive file system for some purposes (e.g. building using Clang-CL
on Linux).

## Usage

Build image using ``virtfatfs-create``:

	./virtfatfs-create /path/to/folder test.img 2000

where 2000 is the maximum size of the image

Mount the image using ``virtfatfs-mount``:

	./virtfatfs-mount test.img

The script will return two lines:
1. Path to real mounted location.
2. Path to loop device.

## License
MIT