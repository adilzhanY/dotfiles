# Only source the uv env if uv is actually installed on this machine.
# Prevents "No such file or directory" errors on machines without uv.
test -f "$HOME/.local/bin/env.fish"; and source "$HOME/.local/bin/env.fish"
