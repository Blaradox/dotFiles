#!/usr/bin/env zsh

# Set install location
DIR="${HOME}/dotFiles"

function install_programs() {
  if [[ $OSTYPE == darwin* ]]; then
    cat apps_brew | xargs brew install
    cat apps_cask | xargs brew install
  fi
}

function stow_dots() {
  local configs=()
  if [[ $OSTYPE == darwin* ]]; then
    configs=(git mpd-osx mpv ncmpcpp nvim scripts shell tmux)
    mkdir -p "${HOME}/.mpd/playlists"
  elif [[ $OSTYPE == linux-gnu ]]; then
    configs=(autostart git mpd mpv ncmpcpp nvim rofi scripts shell tmux)
    mkdir -p "${HOME}/.config/mpd/playlists"
  fi

  mkdir -p "${XDG_CONFIG_HOME:=$HOME/.config}"/{autostart,mpv,ncmpcpp,rofi,zsh}
  mkdir -p "${XDG_CONFIG_HOME:=$HOME/.config}"/{tmux,nvim}/plugins
  mkdir -p "${HOME}/.local/bin"

  printf "Stowing Dotfiles...\n"
  for file in "${configs[@]}"; do
    stow --target="$HOME" --dir="${DIR:-$HOME/dotFiles}" "${file}"
    printf "%s stowed.\n" "${file}"
  done

  printf "Done Stowing!\n"
}

function install_config_files() {
  if [[ -f "${DIR:-$HOME/dotFiles}/install.sh" ]]; then
    stow_dots
  else
    printf "Check to make sure that you cloned this repository in your home folder\n"
  fi
}

function main() {
  while [ "$1" != "" ]; do
    case $1 in
      -a | --all)
        install_programs
        install_config_files
        ;;
      -c | --configs )
        install_config_files
        ;;
      -p | --programs )
        install_programs
        ;;
    esac
    shift
  done
}

main "$@"
