# Commands to run in interactive sessions can go here
if status is-interactive
    # No greeting
    set fish_greeting

    # Use starship
    function starship_transient_prompt_func
        starship module character
    end
    if test "$TERM" != "linux"
        starship init fish | source
        enable_transience
    end
    
    # Smarter cd: `z torq` jumps to ~/dev/torq once visited
    zoxide init fish | source

    # Shell history: Ctrl+R searches, Up arrow left alone (fish's own history is nicer there)
    atuin init fish --disable-up-arrow | source

    # Colors
    if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
        cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    end

    # Aliases
    # kitty doesn't clear properly so we need to do this weird printing
    alias clear "printf '\033[2J\033[3J\033[1;1H'"
    alias celar "printf '\033[2J\033[3J\033[1;1H'"
    alias claer "printf '\033[2J\033[3J\033[1;1H'"
    alias pamcan pacman
    alias q 'qs -c ii'
    alias ssh_connect_wa_vm 'ssh qantr@93.77.188.163'
    alias ssh_connect_wa 'ssh -N -L 5432:127.0.0.1:5432 qantr@93.77.188.163'
    alias c 'claude'
    if test "$TERM" != "linux"
        alias ls 'eza --icons'
    end
    if test "$TERM" = "xterm-kitty"
        alias ssh 'kitten ssh'
    end
end
