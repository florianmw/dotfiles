#!/bin/bash

for i in dot_* dot_*/* dot_*/*/*
do
  src="$i"
  dst="${HOME}/${i/dot_/.}"

  if test -d "$src"
  then
    if ! test -d "$dst"
    then
      mkdir -vp "$dst"
    fi
  elif test -f  "$src"
  then
    if test -f "$dst"
    then
      if ! cmp -s "$dst" "$src"
      then
        meld "$src" "$dst"
      fi
    else
      cp -v "$src" "$dst"
    fi
  fi
done

