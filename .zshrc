# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

autoload -U vcs_info


########################################################
# Configuration
########################################################

COLOR_BLACK="\e[0;30m"
COLOR_BLUE="\e[0;34m"
COLOR_GREEN="\e[0;32m"
COLOR_CYAN="\e[0;36m"
COLOR_PINK="\e[0;35m"
COLOR_RED="\e[0;31m"
COLOR_PURPLE="\e[0;35m"
COLOR_BROWN="\e[0;33m"
COLOR_LIGHTGRAY="\e[0;37m"
COLOR_DARKGRAY="\e[1;30m"
COLOR_LIGHTBLUE="\e[1;34m"
COLOR_LIGHTGREEN="\e[1;32m"
COLOR_LIGHTCYAN="\e[1;36m"
COLOR_LIGHTRED="\e[1;31m"
COLOR_LIGHTPURPLE="\e[1;35m"
COLOR_YELLOW="\e[1;33m"
COLOR_WHITE="\e[1;37m"
COLOR_NONE="\e[0m"



# initialize autocomplete
autoload -U compinit add-zsh-hook
compinit


# Path to your oh-my-zsh installation.
export ZSH="/Users/forrestaustin/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="random"

# Random
# ZSH_THEME_RANDOM_CANDIDATES=(
#	  "robbyrussell"
#	    "agnoster"
#	    "Philthy"
#	    "Lambda"
#	    "Spaceship ZSH"
#    )

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

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
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git tmux knife docker)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"



. /usr/local/opt/asdf/asdf.sh

role_ssh() {
  hostnames=$(knife search "role:$1" -i 2>/dev/null)
  sifi_tmux $hostnames
}

role_ssh_dc() {
  hostnames=$(knife search "role:$1 AND tags:datacenter\:$2" -i 2>/dev/null)
  sifi_tmux $hostnames
}

alias ports='netstat -tulanp'
alias cdev='cd ~/dev/'
alias config='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'

export DATA_BAG_PATH=/Users/forrestaustin/Documents/simplifi_code/chef-repo/data_bags
export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"

git_status() {
    cd -q "$1"
    utils::is_git || return

    vcs_info

    local git_branch="$vcs_info_msg_0_"
    git_branch="${git_branch#heads/}"
    git_branch="${git_branch/.../}"

    [[ -z "$git_branch" ]] && return

    local INDEX git_status=""

    GIT_SYMBOL="\ue725"
    GIT_STATUS_ADDED=$(utils::print '002' '+')
    GIT_STATUS_MODIFIED=$(utils::print '003' '!')
    GIT_STATUS_UNTRACKED=$(utils::print '009' '?')
    GIT_STATUS_RENAMED=$(utils::print '208' '»')
    GIT_STATUS_DELETED=$(utils::print '017' '✘')
    GIT_STATUS_STASHED=$(utils::print '003' '$')
    GIT_STATUS_UNMERGED=$(utils::print '016' '=')
    GIT_STATUS_AHEAD=$(utils::print '012' '⇡')
    GIT_STATUS_BEHIND=$(utils::print '011' '⇣')
    GIT_STATUS_DIVERGED=$(utils::print '012' '⇕')
    GIT_STATUS_CLEAN=$(utils::print '002' '✔')

    INDEX=$(command git status --porcelain -b 2>/dev/null)

    # Check for untracked files
    if $(echo "$INDEX" | command grep -E '^\?\? ' &> /dev/null); then
        git_status="$GIT_STATUS_UNTRACKED$git_status"
    fi

    # Check for staged files
    if $(echo "$INDEX" | command grep '^A[ MDAU] ' &> /dev/null); then
        git_status="$GIT_STATUS_ADDED$git_status"
    elif $(echo "$INDEX" | command grep '^M[ MD] ' &> /dev/null); then
        git_status="$GIT_STATUS_ADDED$git_status"
    elif $(echo "$INDEX" | command grep '^UA' &> /dev/null); then
        git_status="$GIT_STATUS_ADDED$git_status"
    fi

    # Check for modified files
    if $(echo "$INDEX" | command grep '^[ MARC ]M ' &> /dev/null); then
        git_status="$GIT_STATUS_MODIFIED$git_status"
    fi

    # Check for renamed files
    if $(echo "$INDEX" | command grep '^R[ MD] ' &> /dev/null); then
        git_status="$GIT_STATUS_RENAMED$git_status"
    fi

    # Check for deleted files
    if $(echo "$INDEX" | command grep '^[MARCDU ]D ' &> /dev/null); then
        git_status="$GIT_STATUS_DELETED$git_status"
    elif $(echo "$INDEX" | command grep '^D[ UM] ' &> /dev/null); then
        git_status="$GIT_STATUS_DELETED$git_status"
    fi

    # Check for stashes
    if $(command git rev-parse --verify refs/stash >/dev/null 2>&1); then
        git_status="$GIT_STATUS_STASHED$git_status"
    fi

    # Check for unmerged files
    if $(echo "$INDEX" | command grep '^U[UDA] ' &> /dev/null); then
        git_status="$GIT_STATUS_UNMERGED$git_status"
    elif $(echo "$INDEX" | command grep '^AA ' &> /dev/null); then
        git_status="$GIT_STATUS_UNMERGED$git_status"
    elif $(echo "$INDEX" | command grep '^DD ' &> /dev/null); then
        git_status="$GIT_STATUS_UNMERGED$git_status"
    elif $(echo "$INDEX" | command grep '^[DA]U ' &> /dev/null); then
        git_status="$GIT_STATUS_UNMERGED$git_status"
    fi

    # Check whether branch is ahead
    local is_ahead=false
    if $(echo "$INDEX" | command grep '^## [^ ]\+ .*ahead' &> /dev/null); then
        is_ahead=true
    fi

    # Check whether branch is behind
    local is_behind=false
    if $(echo "$INDEX" | command grep '^## [^ ]\+ .*behind' &> /dev/null); then
        is_behind=true
    fi

    # Check wheather branch has diverged
    if [[ "$is_ahead" == true && "$is_behind" == true ]]; then
        git_status="$GIT_STATUS_DIVERGED$git_status"
    else
        [[ "$is_ahead" == true ]] && git_status="$GIT_STATUS_AHEAD$git_status"
        [[ "$is_behind" == true ]] && git_status="$GIT_STATUS_BEHIND$git_status"
    fi

    [[ -n "$git_status" ]] || git_status="$GIT_STATUS_CLEAN"

    utils::bold "$git_status"
    utils::print '241' "$git_branch"
}


utils::exists() {
    command -v "$1" > /dev/null 2>&1
}

utils::is_git() {
    [[ $(command git rev-parse --is-inside-work-tree 2>/dev/null) == true ]]
}

utils::bold() {
    echo -n "%B$1%b"
}

utils::print() {
    local color content bold
    [[ -n "$1" ]] && color="%F{$1}" || color="%f"
    [[ -n "$2" ]] && content="$2" || content=""

    [[ -z "$2" ]] && content="$1"

    echo -n "$color"
    echo -n "$content"
    echo -n "%{%b%f%}"
}

# add color to man pages
export MANROFFOPT='-c'
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2)
export LESS_TERMCAP_md=$(tput bold; tput setaf 6)
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4)
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7)
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_mh=$(tput dim)

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
