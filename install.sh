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
  echo "Installing yay..."
  git clone https://aur.archlinux.org/yay.git "${HOME}/yay"
  cd "${HOME}/yay"
  makepkg -si
  cd "${HOME}"
  rm -rf "${HOME}/yay"
}

function install_vim_plug() {
  echo "Installing vim_plug..."
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim_plug/master/plug.vim'
}

function stow_dots() {
  local configs=()
  if [[ $OSTYPE == darwin* ]]; then
    configs=(fonts git karabiner kitty mpd mpv ncmpcpp nvim scripts shell tmux vim)
  elif [[ $OSTYPE == linux-gnu ]]; then
    configs=(autostart git kitty mpd mpv ncmpcpp nvim rofi scripts shell tmux vim)
  elif [[ $OSTYPE == linux-android ]]; then
    configs=(git mpd ncmpcpp nvim scripts shell tmux vim)
  fi

  mkdir -p "${XDG_CONFIG_HOME:=$HOME/.config}"/{autostart,bash,kitty,mpd,mpv,ncmpcpp,nvim,rofi,zsh}
  mkdir -p "${HOME}/.local/bin"

  printf "Stowing Dotfiles...\n"
  cd "${HOME}/dotFiles"
  for file in "${configs[@]}"; do
    stow "${file}"
    printf "${file} stowed.\n"
  done

  printf "Done Stowing!\n"
}

function install_config_files() {
  if [[ -d "${HOME}/dotFiles" ]]; then
    rm -f "${HOME}/.zshrc"
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
        install_vim_plug
        install_config_files
        ;;
      -c | --configs )
        install_config_files
        ;;
      -p | --programs )
        install_vim_plug
        install_programs
        ;;
      -v | --vim-plug )
        install_vim_plug
        ;;
      -y | --yay )
        install_yay
        ;;
    esac
    shift
  done
}

main "$@"
