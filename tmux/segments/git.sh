#!/usr/bin/env bash

# Test if the current directory is set to the current directory in tmux.
TMUX_DIR=$(tmux display-message -p -F "#{pane_current_path}")

if [ $(pwd) != $TMUX_DIR ]; then
    cd $TMUX_DIR
fi

# Test if the directory we're in is a Git repository.
if ! $(git rev-parse --is-inside-work-tree &>/dev/null); then
    exit 0
fi

# Change the color of the branch name according to the "dirtiness" of the
# branch.
#  * If the branch is dirty, set the color to red.
#  * If the branch is clean, set the color to green.
branch_color() {
    # Test if the current Git branch is dirty or not.
    command git diff --quiet --ignore-submodules HEAD &>/dev/null

    (( $? == 1 )) && echo "#[fg=colour001]" || echo "#[fg=colour002]"
}

# Display status arrow for the current Git repository.
#  * If there are changes upstream, display a ⇣ (needs pulling).
#  * If there are changes that have been committed but not yet pushed, display a
#    ⇡ (needs pushing).
#
# In order to have the "needs pulling" working correctly, it's necessary to
# periodically check the remote status of the repository. This can be achieved
# using the following command: `watch -n 60 git remote -v update &>/dev/null &`.
branch_status() {
    # Test if there is an upstream configured.
    command git rev-parse --abbrev-ref @'{u}' &>/dev/null || return

    ARROW_STATUS="$(command git rev-list --left-right --count HEAD...@'{u}' 2>/dev/null)"

    # Test if the command above failed.
    (( ! $? )) || return

    LEFT=$(echo $ARROW_STATUS | awk '{print $1}')
    RIGHT=$(echo $ARROW_STATUS | awk '{print $2}')

    (( ${LEFT:-0} > 0 && ${RIGHT:-0} > 0 )) && echo " #[fg=colour003,bold]⇣#[fg=colour004,bold]⇡" && return
    (( ${RIGHT:-0} > 0 )) && echo " #[fg=colour003,bold]⇣"
    (( ${LEFT:-0} > 0 )) && echo " #[fg=colour004,bold]⇡"
}

echo "`branch_color`$(git symbolic-ref --short HEAD)`branch_status` "
