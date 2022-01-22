# virtfatfs

Mount a file system with given data on Linux. Useful if you need
case-insensitive file system for some purposes (e.g. building using Clang-CL
on Linux)

## Usage

Build image using ``create.sh``:

	./create.sh /path/to/folder test.img 2000

where 2000 is the maximum size of the image

Mount the image using ``mount.sh``:

	./mount.sh test.img

## License
MIT