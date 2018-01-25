autoload colors && colors

# Display information about suspended jobs.
suspended_jobs() {
    JOB_COUNT=$(jobs | wc -l | xargs)

    if [[ $JOB_COUNT > 0 ]]; then
        echo " %F{246}with %F{251}$JOB_COUNT background job$((( ${JOB_COUNT:-0} == 1 )) || echo "s")"
    fi
}

# Display information about the current prompt.
precmd() {
    print -P "\n%F{004}%n %F{246}on %F{004}%m%F{246} in %F{251}${PWD/#$HOME/~}`suspended_jobs`"
}

export PROMPT="%F{241}$%f "
