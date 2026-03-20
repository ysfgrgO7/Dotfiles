## Install & source Zap
if [ -d "$HOME/.local/share/zap" ]; then
else
	git clone https://github.com/zap-zsh/zap.git ~/.local/share/zap
fi
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

## Plugins
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zap-zsh/exa"
plug "zap-zsh/vim"
plug "zsh-users/zsh-syntax-highlighting"
plug "zap-zsh/atmachine-prompt"
plug "Aloxaf/fzf-tab"
plug "zap-zsh/fzf"
plug "Freed-Wu/fzf-tab-source"
plug "zsh-users/zsh-history-substring-search"
plug "hlissner/zsh-autopair"
autoload -Uz compinit
compinit
HISTSIZE=100000000
SAVEHIST=100000000
HISTFILE=~/.zsh_history

## Aliases
alias v="nvim"
alias cp="cp -ri"
alias rm="rm -ri"
alias ls='exa --group-directories-first --icons -la'
alias up='sudo pacman -Syyu'
alias orphans='sudo pacman -Qtdq | sudo pacman -Rns -'
alias yay='paru'
alias ranger='yazi'

## Defaults
export PF_INFO="os pkgs memory wm shell editor palette"
export LC_ALL="en_US.UTF-8"
export TZ="Africa/Cairo"
export HARDWARECLOCK=localtime
export EDITOR="nvoid"
export TERMINAL="kitty"
export BROWSER="brave"
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

## Pathes
if [ -d "$HOME/.local/share/bin" ]; then
	PATH="$HOME/.local/share/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ]; then
	PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "$HOME/.cargo/bin" ]; then
	PATH="$HOME/.cargo/bin:$PATH"
fi

lfetch
