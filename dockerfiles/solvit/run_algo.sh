#!/bin/bash
docker cp $1 space:/workspace/$1
docker run --rm -it --name $1 -v algospace:/workspace -w /workspace/$1 n0madic/alpine-gcc:9.1.0 /bin/bash -c "make && cd .. && rm -rf $1"
