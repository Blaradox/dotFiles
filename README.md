# ~/dotFiles

![alt text](screenshot.png)

## How to

To configure everything but Zsh use the `install.sh` script. Make sure to make it executable with:
```
chmod +x ~/dotFiles/install.sh
```
To use this script you will need GNU Stow, which can be installed with your package manager of choice. With Mac OS X I prefer to use [homebrew](https://brew.sh).
```
brew install stow
```

## Zsh
I like to use zsh as my shell, and [Prezto](https://github.com/sorin-ionescu/prezto) to configure it. I agree with most defaults, but I change the theme in `.zpreztorc` to:
```
zstyle ':prezto:module:prompt' theme 'pure'
```
and I add:
```
source ~/.funcs.sh
```
to the end of my `.zshrc`.

## Vim

For my vim setup I use the [vim-plug](https://github.com/junegunn/vim-plug) package manager which can be setup using:
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

## Favorite terminal programs

Here is a list of the terminal applications I use the most often:
```
tmux                # Terminal multiplexer
fzf                 # Fuzzy finder, for files, etc.
ddgr                # DuckDuckGo from the terminal
ranger              # For the best file browser
ripgrep             # Very fast regex file search
mpd mpc ncmpcpp mpv # For playing music, videos
ffmpeg              # Video and audio tools
neofetch            # For displaying sys info
git vim python      # Mac versions are old....
coreutils           # GNU versions of less, etc.
bat                 # `cat` w/ syntax highlighting
prettyping          # `ping` w/ a TUI
htop                # A better version of `top`
diff-so-fancy       # `diff` w/ syntax highlighting
ncdu                # `du` w/ a TUI and more features
tldr                # When `man` is too long
jq                  # A commandline JSON processor
```

## Colors

For the most part I prefer to use base16 colors, so the terminal colors you use in iTerm, or your terminal of choice, will largely determine the appearance of the packages installed.
I have recently been using the [OneDark](https://github.com/joshdick/onedark.vim) theme, which is reminiscent of Atom's default color scheme.
To load these colors into iTerm, you will need this [file](https://github.com/joshdick/onedark.vim/blob/master/term/One%20Dark.itermcolors).

## Font

I use the Fira font family, which can be installed with `brew` on Mac:
```
brew tap caskroom/fonts
brew cask install \
  font-fira-code \
  font-fira-mono \
  font-fira-mono-for-powerline \
  font-fira-sans
```
Personally I prefer fira-mono, as I am not a huge fan of programming ligatures, but that's entirely subjective.

