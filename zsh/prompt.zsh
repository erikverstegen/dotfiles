# Inspired by: https://github.com/nicknisi/dotfiles/blob/master/zsh/prompt.zsh

# Load the colors.
autoload colors && colors

# Display information about suspended jobs.
suspended_jobs() {
    JOB_COUNT=$(jobs | wc -l | xargs)
    PLURAL=$((( ${JOB_COUNT:-0} == 1 )) || echo "s")

    if [[ $JOB_COUNT > 0 ]]; then
        echo " %F{246}with %F{251}$JOB_COUNT background job$PLURAL"
    fi
}

# Display the pre command information.
precmd() {
    print -P "\n%F{004}%n %F{246}on %F{004}%m%F{246} in %F{251}${PWD/#$HOME/~}`suspended_jobs`"
}

export PROMPT="%F{241}$%f "
