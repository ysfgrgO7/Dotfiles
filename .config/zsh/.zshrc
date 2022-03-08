### Adding Files ###
source "$ZDOTDIR/zsh-functions"
source "$ZDOTDIR/zsh-autopairs"
source "$ZDOTDIR/zsh-autosuggestions"
source "$ZDOTDIR/zsh-history-substring-search"
source "$ZDOTDIR/zsh-syntax-highlighting"
zsh_add_file "zsh-vimode"
zsh_add_file "zsh-vimode"
zsh_add_file "zsh-prompt"
zsh_add_file "zsh-aliases"
zsh_add_file "zsh-exports"
zsh_add_file "fzf/completion.zsh"
zsh_add_file "fzf/key-bindings.zsh"

### HISTORY ###
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.config/zsh/zsh-history
