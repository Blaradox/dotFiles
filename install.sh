#!/usr/bin/env zsh

function install_programs() {
  local linux_stuff mac_stuff terminal file_stuff multimedia git_stuff utilities fun_stuff game_stuff what_to_install
  linux_stuff=(
    itch # storefront for indie games
    libqalculate # command line calculator
    lutris # for managing wine and games
    nitrogen # set your wallpaper
    rofi # launch programs from keyboard
    steam # THE desktop game storefront
    stow # control file links
    trash-cli # control FreeDesktop trash, GNOME, KDE, XFCE, etc.
    xcape # use capslock as ctrl AND escape
    xclip # linux clipboard manager
  )

  mac_stuff=(
  )

  terminal=(
    alacritty # light cross-platform terminal
    kitty # great featureful cross-platform terminal
    zsh # nearly POSIX compliant shell that's very interacitve
  )

  file_stuff=(
    fzf # fuzzy finder for files and everything else
    neovim # community fork of vim
    nnn # very light and simple file manager
    pandoc # convert between Markdown, HTML, LaTeX, etc.
  )

  multimedia=(
    mpd # music player daemon
    mpc # simple commands to control `mpd`
    mpv # plays any video you throw at it
    ncmpcpp # create playslits for `mpd`, tag music files, etc.
    weechat # irc and instant messaging
    youtube-dl # download youtube vids
  )

  git_stuff=(
    bat # fancy version of `cat`
    diff-so-fancy # fancy version of `diff`
    git # version control
  )

  utilities=(
    ddgr # duck duck go in the command line
    ripgrep # blazing fast replacement for grep
    tmux # terminal multiplexer
  )

  fun_stuff=(
    cowsay # have a cow say something
    doge # much fun .. wow
    figlet # big silly fonts
    fortune-mod # bank of fortunes
    lolcat # RAINBOWS
  )

  what_to_install=(
    ${file_stuff[@]}
    ${fun_stuff[@]}
    ${git_stuff[@]}
    ${multimedia[@]}
    ${network[@]}
    ${terminal[@]}
    ${utilities[@]}
  )

  if [[ $OSTYPE == darwin* ]]; then
    brew install "${what_to_install[@]} ${mac_stuff[@]}"
  elif [[ $OSTYPE == linux-gnu ]]; then
    install_yay
    yay -S "${what_to_install[@]} ${linux_stuff[@]}"
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
    configs=(fonts git kitty mpd mpv ncmpcpp nvim rofi scripts shell tmux vim)
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
