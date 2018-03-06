# ~/dotFiles

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
and of course I change the key mapping style to `vi`:
```
zstyle ':prezto:module:editor' key-bindings 'vi'
```
finally I add:
```
source ~/.funcs.sh
```
to the end of my `.zshrc`.

## Vim

For my vim setup I use the [Vundle](https://github.com/VundleVim/Vundle.vim) package manager which can be setup using:
```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

## Favorite terminal programs

Here is a list of the terminal applications I use the most often:
```
ranger                # For the best file browser
tmux                  # Terminal multiplexer
fzf                   # Fuzzy finder, for files, etc.
mpd mpc ncmpcpp mpv   # For playing music, videos
git vim python        # Mac versions are old....
coreutils             # GNU versions of less, etc.
neofetch              # For displaying sys info
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

