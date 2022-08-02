#!/bin/bash
rm -f *.o *.a
clang -c bar.c
clang -c foo.c
ar rcs libbar.a bar.o
ar rcs libfoo.a foo.o

rustc -v test.rs --test \
      -C debuginfo=2 \
      -l static:+whole-archive=foo -l static:-whole-archive=bar -L. \
      -C link-arg=-Wl,--nonsense  # Add nonsense to the link line so we can investigate it

echo "!!!!"
echo 'Note that both `libfoo.a` and `libbar.a` are wrapped with whole-archive in the link line, despite `-l static:-whole-archive=bar`'
echo "!!!!"
