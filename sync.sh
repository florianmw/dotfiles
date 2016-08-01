#!/bin/sh

case "$(uname -s)" in
  Linux)  DIFFTOOL=meld;;
  Darwin) DIFFTOOL=/Applications/Meld.app/Contents/MacOS/Meld;;
esac

setupSuffix=".setup.sh"

for i in dot_* dot_*/* dot_*/*/*
do
  src="$i"
  dst="${HOME}/${i/dot_/.}"

  if test "$src" != "${src%*${setupSuffix}}"
  then
    continue
  fi

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
        $DIFFTOOL "$src" "$dst"
      fi
    else
      setupScript="${src}${setupSuffix}"
      if test -e "$setupScript"
      then
        "./$setupScript"
      fi
      cp -v "$src" "$dst"
    fi
  fi
done

