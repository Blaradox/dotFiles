#!/usr/bin/env zsh

# Set install location
DIR="${HOME}/dotFiles"

function install_programs() {
  if [[ $OSTYPE == darwin* ]]; then
    cat apps_brew | xargs brew install
    cat apps_cask | xargs brew install
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
  cd "${HOME}/yay" || return
  makepkg -si
  cd "${HOME}" || return
  rm -rf "${HOME}/yay"
}

function install_vim_plug() {
  echo "Installing vim_plug..."
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
}

function stow_dots() {
  local configs=()
  if [[ $OSTYPE == darwin* ]]; then
    configs=(git kitty mpd mpv ncmpcpp nvim scripts shell tmux)
  elif [[ $OSTYPE == linux-gnu ]]; then
    configs=(autostart git kitty mpd mpv ncmpcpp nvim rofi scripts shell tmux)
  elif [[ $OSTYPE == linux-android ]]; then
    configs=(git nvim scripts shell tmux)
  fi

  mkdir -p "${XDG_CONFIG_HOME:=$HOME/.config}"/{autostart,bash,kitty,mpd,mpv,ncmpcpp,nvim,rofi,zsh}
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
