set fish_greeting
fish_vi_key_bindings
set -U fish_color_command green
set -U fish_color_autosuggestion brblack
set -U fish_color_command green
set -U fish_color_param white
set -U fish_color_error red
set -U fish_color_quote yellow
set -U fish_color_comment brblack

# Git
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_color_branch magenta
set __fish_git_prompt_color_dirtystate red
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red
set __fish_git_prompt_char_dirtystate 'U'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_untrackedfiles '☡'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '+'
set __fish_git_prompt_char_upstream_behind '-'

# Prompt
function fish_prompt
    set -l last_status $status
    set -l stat
    set -l pwd
    set pwd (prompt_pwd)
    if test $last_status -ne 0
        set stat (set_color red)" ➜ "(set_color --reset)
    else
        set stat (set_color green)" ➜ "(set_color green)
    end

    string join '' (set_color blue)'['(set_color white)(whoami)(set_color red)'@'(set_color white)(prompt_hostname)(set_color blue)']' -- (set_color --reset) $stat (set_color blue) $pwd (set_color --reset)(__fish_git_prompt) " " 
end

# Aliases
alias v nvim
alias cp "cp -ri"
alias rm "rm -ri"
alias ls "exa --group-directories-first --icons -la"
alias up "sudo pacman -Syyu"
alias orphans "sudo pacman -Qtdq | sudo pacman -Rns -"
alias yay paru
alias ranger yazi

# Env vars
set -Ux PF_INFO "os pkgs memory wm shell editor palette"
set -Ux LC_ALL "en_US.UTF-8"
set -Ux TZ Africa/Cairo
set -Ux HARDWARECLOCK localtime
set -Ux EDITOR nvim # (you had typo: nvoid)
set -Ux TERMINAL kitty
set -Ux BROWSER helium
set -Ux XDG_CONFIG_HOME $HOME/.config
set -Ux XDG_CACHE_HOME $HOME/.cache
set -Ux XDG_DATA_HOME $HOME/.local/share

fish_add_path ~/.local/share/bin
fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin
