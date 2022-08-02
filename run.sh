#!/bin/bash
rm *.o *.a
cc bar.c
cc foo.c
ar rcs libbar.a bar.o
ar rcs libfoo.a foo.o
rustc --crate-type=staticlib test.rs -C link-arg=foobar -l static:+whole-archive=foo -l static:-whole-archive=bar -L.
