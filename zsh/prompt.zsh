# Inspired by: https://github.com/nicknisi/dotfiles/blob/master/zsh/prompt.zsh

# Needed for getting information of the Git repository.
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' use-simple true
zstyle ':vcs_info:git*' max-exports 2
zstyle ':vcs_info:git*' formats ' %b' 'x%R'
zstyle ':vcs_info:git*' actionformats ' %b|%a' 'x%R'

# Load the colors.
autoload colors && colors

# Display a tag if the current Git branch is dirty or not.
git_dirty() {
    # Test if the current Git branch is dirty or not.
    command git diff --quiet --ignore-submodules HEAD &>/dev/null;

    (( $? == 1 )) && echo "%F{001}✗" || echo "%F{002}✔"
}

# Display status arrow for the current Git repository.
#  * If there are changes upstream, display a ⇣ (needs pulling).
#  * If there are changes that have been committed but not yet pushed, display a
#    ⇡ (needs pushing).
git_arrows() {
    # Test if there is an upstream configured.
    command git rev-parse --abbrev-ref @'{u}' &>/dev/null || return

    arrow_status="$(command git rev-list --left-right --count HEAD...@'{u}' 2>/dev/null)"

    # Do nothing if the command failed.
    (( ! $? )) || return

    # Split on tab characters.
    arrow_status=(${(ps:\t:)arrow_status})

    local right=${arrow_status[2]}
    local left=${arrow_status[1]}

    (( ${left:-0} > 0 && ${right:-0} > 0 )) && echo " %F{003}⇣ %F{004}⇡" && return
    (( ${right:-0} > 0 )) && echo " %F{003}⇣"
    (( ${left:-0} > 0 )) && echo " %F{004}⇡"
}

# Display information about the current Git repository.
git_info() {
    # Test if we are in a Git repository.
    command git rev-parse --is-inside-work-tree &>/dev/null || return

    echo " %F{238}on `git_dirty`%F{007}$vcs_info_msg_0_%F{238}`git_arrows`"
}

# Display information about suspended jobs.
suspended_jobs() {
    if [[ ! "$(jobs 2>/dev/null | tail -n 1)" == "" ]]; then
        echo " %F{005}✱"
    fi
}

# Display the pre command information.
precmd() {
    vcs_info

    # Make the macOS terminal remember the current directory when opening a new
    # tab.
    print -Pn "\e]2; %~/ \a"

    # Display the information.
    print -P "\n%F{075}%n@%m%F{238} in%F{007} ${PWD/#$HOME/~}`git_info``suspended_jobs`"
}

export PROMPT="%F{234}$%f "
