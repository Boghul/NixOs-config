# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="mikeh"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
 zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
 zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
 COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
# cd into the old directory
alias bd="cd "$OLDPWD""

# Listing
alias ls="ls -lh --color=auto"
alias ll="ls -alh"
alias la="ls -A"
alias l="ls -CF"

# Utilities
alias grep="grep --color=auto"
alias c="clear"
alias h="history"
alias j="jobs -l"
alias pip="pip3"
alias python="python3"
# Remove a directory and all files
alias rmd="/bin/rm  --recursive --force --verbose "

# Calendar
alias jan="cal -m 01"
alias feb="cal -m 02"
alias mar="cal -m 03"
alias apr="cal -m 04"
alias may="cal -m 05"
alias jun="cal -m 06"
alias jul="cal -m 07"
alias aug="cal -m 08"
alias sep="cal -m 09"
alias oct="cal -m 10"
alias nov="cal -m 11"
alias dec="cal -m 12"

# Programs & Co
# fastfetch with gif
alias fastgif="fastfetch --kitty-icat ~/Bilder/grimreaper.gif"
# rebuild nixos
alias rebuild="sudo nixos--rebuild switch --flake ."
# update nixos channels
alias channel="nix-channel --update"
# delete garbage
alias garbage="nix-collect-garbage -d --delete-old"
# CLI musicplayer
alias m="musikcube"
# Cli filemanger
alias r="ranger"
# Show open ports
alias openports="netstat -nape --inet"

fastfetch --kitty-icat ~/Bilder/grimreaper.gif

# for NixOs Home Manager
#source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh

# Add NIX_PATH to the File
export NIX_PATH="nixpkgs=https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz"
export NIX_PATH="nixpkgs=https://github.com/NixOS/nixpkgs/archive/nixos-25.05.tar.gz"


