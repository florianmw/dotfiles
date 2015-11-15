#!/bin/bash

for i in dot_* dot_*/* dot_*/*/*;
do
  if test -f  "${HOME}/${i/dot_/.}"
  then
    if ! cmp -s "${HOME}/${i/dot_/.}" "${i}"
    then
      meld "${HOME}/${i/dot_/.}" "${i}"
    fi
  fi
done
