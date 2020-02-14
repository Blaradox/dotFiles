#!/usr/bin/env zsh

function install_programs() {
  if [[ $OSTYPE == darwin* ]]; then
    brew install - < ./applist
  elif [[ $OSTYPE == linux-gnu ]]; then
    if [[ ! -x /usr/bin/yay ]]; then
      install_yay
    fi
    yay -S --needed - < ./applist
  fi
}

function install_yay() {
  git clone https://aur.archlinux.org/yay.git "${HOME}/yay"
  cd "${HOME}/yay"
  makepkg -si
  cd "${HOME}"
  rm -rf "${HOME}/yay"
}

function install_prezto() {
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  setopt EXTENDED_GLOB
  for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -sf "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  done
  chsh -s "$(which zsh)"
}

function stow_dots() {
  local configs=()
  if [[ $OSTYPE == darwin* ]]; then
    configs=(fonts git karabiner kitty mpd mpv ncmpcpp nvim scripts shell tmux vim)
  elif [[ $OSTYPE == linux-gnu ]]; then
    configs=(autostart fonts git kitty mpd mpv ncmpcpp nvim rofi scripts shell tmux vim)
  fi

  mkdir -p "${XDG_CONFIG_HOME:=$HOME/.config}"/{kitty,mpv,nvim}
  mkdir -p "${XDG_DATA_HOME:=$HOME/.local/share}/fonts"
  mkdir -p "${HOME}/.local/bin"

  printf "Stowing Dotfiles...\n"
  cd "${HOME}/dotFiles"
  for file in "${configs[@]}"; do
    # Only run stow on directories
    stow "${file}"
    printf "${file} stowed.\n"
  done

  # stow by default ignores .gitignore files
  ln -sf "${HOME}/dotFiles/.ignore" "${HOME}/.ignore"

  printf "Done Stowing!\n"
}


function install_config_files() {
  if [[ -d "${HOME}/dotFiles" ]]; then
    rm -f "${HOME}/.zshrc"
    sed --in-place 's/\(zstyle.*\)sorin/\1giddie/' "${HOME}/.zpreztorc"
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
        install_prezto
        install_config_files
        ;;
      -p | --programs )
        install_programs
        ;;
      -z | --prezto )
        install_prezto
        ;;
      -c | --configs )
        install_config_files
        ;;
    esac
    shift
  done
}

main "$@"
