#!/bin/sh
TARGET_NAME=tomos

#for mkdosfs
rm -f $TARGET_NAME.flp

#create base floppy image
mkdosfs -C $TARGET_NAME.flp 1440 >/dev/null || exit $?

#assemble bootloader
nasm -f bin -o $TARGET_NAME.bin $TARGET_NAME.asm || exit $?

#copy the bootloader to the floppy image
#dd doesn't support status= on OS X, this is GNU dd
gdd status=none conv=notrunc if=$TARGET_NAME.bin of=$TARGET_NAME.flp || exit $?

#run the thing.
qemu-system-i386 -fda $TARGET_NAME.flp || exit $?
