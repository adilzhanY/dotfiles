function addanki --description "Claude Code lean Anki vocab session (english/german/kazakh only)"
    # Isolated config dir: only the small CLAUDE.md + the 3 vocab commands.
    # No global CLAUDE.md, no Figma/AXI/other skills, no MCP servers.
    set -lx CLAUDE_CONFIG_DIR "$HOME/.claude-anki"
    cd "$HOME/anki-cards"
    claude --model claude-opus-4-8 --effort low --strict-mcp-config $argv
end
