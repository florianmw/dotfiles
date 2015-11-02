#!/bin/bash

for i in dot_* dot_*/* dot_*/*/*;
do
  if test -e  "${HOME}/${i/dot_/.}"
  then
    meld "${HOME}/${i/dot_/.}" "${i}"
  fi
done
