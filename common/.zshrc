# main zsh settings. env in ~/.zprofile
# read second

# source global shell alias & variables files
[ -f "$XDG_CONFIG_HOME/shell/alias" ] && source "$XDG_CONFIG_HOME/shell/alias"
[ -f "$XDG_CONFIG_HOME/shell/vars" ] && source "$XDG_CONFIG_HOME/shell/vars"

# load modules
zmodload zsh/complist
autoload -U compinit && compinit
autoload -U colors && colors
# autoload -U tetris # main attraction of zsh, obviously


# cmp opts
zstyle ':completion:*' menu select # tab opens cmp menu
zstyle ':completion:*' special-dirs true # force . and .. to show in cmp menu
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;33 # colorize cmp menu
# zstyle ':completion:*' file-list true # more detailed list
zstyle ':completion:*' squeeze-slashes false # explicit disable to allow /*/ expansion

# main opts
setopt append_history inc_append_history share_history # better history
# on exit, history appends rather than overwrites; history is appended as soon as cmds executed; history shared across sessions
setopt auto_menu menu_complete # autocmp first menu match
setopt autocd # type a dir to cd
setopt auto_param_slash # when a dir is completed, add a / instead of a trailing space
setopt no_case_glob no_case_match # make cmp case insensitive
setopt globdots # include dotfiles
setopt extended_glob # match ~ # ^
setopt interactive_comments # allow comments in shell
unsetopt prompt_sp # don't autoclean blanklines
stty stop undef # disable accidental ctrl s

# history opts
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE="$XDG_CACHE_HOME/zsh_history" # move histfile to cache
HISTCONTROL=ignoreboth # consecutive duplicates & commands starting with space are not saved

# set up prompt
NEWLINE=$'\n'
PROMPT="${NEWLINE}%K{#1e1e2e}%F{#cdd6f4}$(date +%_I:%M%P) %K{#313244}%F{#f5e0dc} %n %K{#45475a}%F{#cba6f7} %~ %f%k ❯ "
# PROMPT="${NEWLINE}%K{#282828}%F{#ebdbb2}$(date +%_I:%M%P) %K{#3c3836}%F{#fbf1c7} %n %K{#504945} %~ %f%k ❯ " # gruvbox dark theme

echo -e "${NEWLINE}\033[48;2;30;30;46;38;2;205;214;244m $0 \033[0m\033[48;2;49;50;68;38;2;205;214;244m $(uptime -p | cut -c 4-) \033[0m\033[48;2;69;71;90;38;2;205;214;244m $(uname -r) \033[0m"
# echo -e "${NEWLINE}\033[48;2;60;56;54;38;2;235;219;178m $0 \033[0m\033[48;2;80;73;69;38;2;235;219;178m $(uptime -p | cut -c 4-) \033[0m\033[48;2;40;40;40;38;2;235;219;178m $(uname -r) \033[0m" # gruvbox dark theme

# autosuggestions
# requires zsh-autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# syntax highlighting
# requires zsh-syntax-highlighting package
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# autocompletions
# requires zsh-autocomplete
source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# Initialize Starship
eval "$(starship init zsh)"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
