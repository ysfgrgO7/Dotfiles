### Adding Files ###
source "$ZDOTDIR/zsh-functions"
source "$ZDOTDIR/zsh-autopairs"
zsh_add_file "zsh-vimode"
zsh_add_file "zsh-vimode"
zsh_add_file "zsh-prompt"
zsh_add_file "zsh-aliases"
zsh_add_file "zsh-exports"
zsh_add_file "fzf/completion.zsh"
zsh_add_file "fzf/key-bindings.zsh"

### PLUGINS ###
zsh_install_plugins "zsh-users/zsh-syntax-highlighting"
zsh_install_plugins "zsh-users/zsh-autosuggestions"
zsh_install_plugins "zsh-users/zsh-history-substring-search"

### HISTORY ###
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.config/zsh/zsh-history
