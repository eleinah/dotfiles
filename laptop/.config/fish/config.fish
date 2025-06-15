# If not running interactively, don't do anything
if not status is-interactive
    return
end

# Aliases
alias ls 'ls --color=auto'
alias grep 'grep --color=auto'

# User-specific environment
if not contains $HOME/.local/bin $HOME/bin $PATH
    set PATH $HOME/.local/bin $HOME/bin $PATH
end

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# set -x SYSTEMD_PAGE ""

# Initialize Starship
starship init fish | source

# Generated for envman. Do not edit.
test -s ~/.config/envman/load.fish; and source ~/.config/envman/load.fish

# bun
set --export BUN_INSTALL "$HOME/.local/share/reflex/bun"
set --export PATH $BUN_INSTALL/bin $PATH
