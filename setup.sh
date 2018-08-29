#!/bin/bash
#shellcheck disable=SC2046
opts=d
doctest=false
set -- $(getopt "$opts" "$@")
while getopts "$opts" opt
do case "$opt" in
        d) doctest=;; +d) doctest=false;;
        *) echo "Discarding unknown option: $opt";;
esac done
shift $((OPTIND - 1))

src="$(dirname "$0")"
dst="${1:-.}"

files=(makefile compdb.mk)
folders=(src include)
cp "${files[@]/#/$src/}" "$dst"
cp -n "$src/targets.initial.mk"    "$dst/targets.mk"
cp -n "$src/buildflags.initial.mk" "$dst/buildflags.mk"
mkdir -p "${folders[@]}"

docfiles=(src/doctest/main.cpp src/doctest_wrapper/main.cpp)
docfiles+=(include/doctest/wrapper.h)
if $doctest
then
	for file in "${docfiles[@]}"
	do mkdir -p $(dirname "$dst/$file") && cp -n "$src/$file" "$dst/$file"
	done
fi
