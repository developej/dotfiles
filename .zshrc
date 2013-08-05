# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# aliases
# push and pop directories on directory stack
alias pu="pushd"
alias po="popd"

# basic directory operations
alias ...="cd ../.."
alias -- -="cd -"

# show history
alias history="fc -l 1"

# list all
alias l="ls -alh"
# count all
alias countall="ls | wc -l"
# list files
alias lf="ls -alh | grep ^-"
# count files
alias countfiles="ls -l | grep ^- | wc -l"
# list directories
alias ld="ls -alh | grep ^d"
# count directories
alias countdirs="ls -l | grep ^d | wc -l"
# list symbolic links
alias ll="ls -alh | grep .-\>"
# count symbolic links
alias countsymlinks="ls -l | grep ^l | wc -l"

# pacman aliases
alias syu="sudo pacman -Syu"
alias asyu="yaourt -Sbu --aur"
# system aliases
alias sshn="sudo shutdown -h now"
alias sr="sudo reboot"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git sprunge urltools vi-mode)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

export EDITOR="gvim"

### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

DEFAULT_USER="developej"
CURRENT_BG='NONE'
SEGMENT_SEPARATOR=''

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
    local bg fg
    [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
    [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
    if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
        echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
    else
        echo -n "%{$bg%}%{$fg%} "
    fi
    CURRENT_BG=$1
    [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
    if [[ -n $CURRENT_BG ]]; then
        echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
    else
        echo -n "%{%k%}"
    fi
    echo -n "%{%f%}"
    CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)
prompt_context() {
    local user=`whoami`

    if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
        prompt_segment black default "%(!.%{%F{yellow}%}.)$user@%m"
    fi
}

# Git: branch/detached head, dirty status
prompt_git() {
    local ref dirty
    if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
        dirty=$(parse_git_dirty)
        ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"
        if [[ -n $dirty ]]; then
            prompt_segment yellow black
        else
            prompt_segment green black
        fi

    setopt promptsubst
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' get-revision true
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr '✚'
    zstyle ':vcs_info:git:*' unstagedstr '●'
    zstyle ':vcs_info:*' formats ' %u%c'
    zstyle ':vcs_info:*' actionformats '%u%c'
    vcs_info
    echo -n "${ref/refs\/heads\// }${vcs_info_msg_0_}"
    fi
}

prompt_hg() {
    local rev status
    if $(hg id >/dev/null 2>&1); then
        if $(hg prompt >/dev/null 2>&1); then
            if [[ $(hg prompt "{status|unknown}") = "?" ]]; then
                # if files are not added
                prompt_segment red white
                st='±'
            elif [[ -n $(hg prompt "{status|modified}") ]]; then
                # if any modification
                prompt_segment yellow black
                st='±'
            else
                # if working copy is clean
                prompt_segment green black
            fi
            echo -n $(hg prompt " {rev}@{branch}") $st
        else
            st=""
            rev=$(hg id -n 2>/dev/null | sed 's/[^-0-9]//g')
            branch=$(hg id -b 2>/dev/null)
            if `hg st | grep -Eq "^\?"`; then
                prompt_segment red black
                st='±'
            elif `hg st | grep -Eq "^(M|A)"`; then
                prompt_segment yellow black
                st='±'
            else
                prompt_segment green black
            fi
            echo -n " $rev@$branch" $st
        fi
    fi
}

# Dir: current working directory
prompt_dir() {
    prompt_segment blue black '%~'
}

# Virtualenv: current working virtualenv
prompt_virtualenv() {
    local virtualenv_path="$VIRTUAL_ENV"
    if [[ -n $virtualenv_path ]]; then
        prompt_segment blue black "(`basename $virtualenv_path`)"
    fi
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
    local symbols
    symbols=()
    [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}✘"
    [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡"
    [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙"
    [[ -n "$symbols" ]] && prompt_segment black default "$symbols"
}

## Main prompt
build_prompt() {
    RETVAL=$?
    prompt_status
    prompt_virtualenv
    prompt_context
    prompt_dir
    prompt_git
    prompt_hg
    prompt_end
}

PROMPT='%{%f%b%k%}$(build_prompt) '

#path
export PATH=$PATH:$HOME/resources/scripts
export PATH=$PATH:/opt/android-sdk/tools
