set -U fish_greeting
starship init fish | source
alias ls="exa --icons --git -lhi"
alias cat="bat"
# Start X at login
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty
    end
end
