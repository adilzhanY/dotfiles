# Only source the cargo env if Rust is actually installed on this machine.
# Prevents "No such file or directory" errors on machines without rustup.
test -f "$HOME/.cargo/env.fish"; and source "$HOME/.cargo/env.fish"
