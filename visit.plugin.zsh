# Visit a different directory then jump back to the original one
# Origin and visit locations are stored as a symbolic links in the directory $LOCPATH (default $HOME/.loc)
#
# visit FOO: navigate to FOO directory
# back: return to origin location or back to visit location
# origin: list origin and visit locations
#
export LOCPATH=$HOME/.loc

visit() {
  if [[ ( $# == 0 ) ]]; then
    echo "USAGE: visit <path>"
  else
    LOC=$1
    if [[ -d "$LOC" ]]; then
      if [[ -L "$LOCPATH/origin" ]]; then
        rm -rf "$LOCPATH"
      fi
      mkdir -p "$LOCPATH"
      ln -s "$PWD" "$LOCPATH/origin"
      cd "$LOC"
      ln -s "$PWD" "$LOCPATH/loc"
    else
      echo "$LOC is not a valid path."
      return 1
    fi
  fi
}

back() {
  if [[ -L "$LOCPATH/origin" ]]; then
    if [[ $(readlink "$LOCPATH/origin") == "$PWD" ]]; then
      echo "Navigating to visit location. Type 'back' again to return to origin location."
      cd -P "$LOCPATH/loc"
    else
      echo "Navigating to origin. Type 'back' again to return to visit location."
      rm "$LOCPATH/loc"
      ln -s "$PWD" "$LOCPATH/loc"
      cd -P "$LOCPATH/origin"
    fi
  else
    echo "No locations have been set."
    return 1
  fi
}

origin() {
  if [[ -L "$LOCPATH/origin" ]]; then
    printf "$fg[cyan]origin$reset_color -> $fg[blue]$(readlink $LOCPATH/origin)$reset_color\n"
    printf "$fg[cyan]visit$reset_color -> $fg[blue]$(readlink $LOCPATH/loc)$reset_color\n"
  else
    echo "No locations have been set."
    return 1
  fi
}
