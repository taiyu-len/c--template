#!/bin/bash
src="$(dirname "$0")"
dst="${1:-.}"

files=(makefile compdb.mk)
folders=(src include)
cp "${files[@]/#/$src/}" "$dst"
cp -n "$src/targets.initial.mk"    "$dst/targets.mk"
cp -n "$src/buildflags.initial.mk" "$dst/buildflags.mk"
mkdir "${folders[@]}"
