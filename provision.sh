#!/bin/bash
input="symlinks"

while IFS= read -r var
do
  IFS=':' read -r  -a results <<< "$var"
  eval src="${results[0]}"
  eval dst="${results[1]}"
  cmp --silent "$src" "$dst" || ln -s "$src" "$dst"
done < "$input"
