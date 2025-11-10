if status is-interactive
    # Commands to run in interactive sessions can go here
    alias gcm='git commit -m'
    alias gl='git log'
    alias gc='git checkout'
    alias crgi='echo -e "target\nnode_modules\n.env\n.next\n.idea\n.vscode\ncache\ndist\nbuild\ncoverage\n__pycache__\n*.pyc\nvenv\n.DS_Store\ndb.sqlite3\n.mypy_cache\npytest_cache\n.svelte-kit\n.expo\n.packager\n*.log\nnpm-debug.log*\nyarn-debug.log*\nyarn-error.log*\n" > .gitignore'
		alias sdc='sudo systemctl poweroff'
		alias ffn='firefox -p normal & disown'
		alias ffh='firefox -p another_me & disown'
		alias rldwaybar='killall waybar && waybar & disown'
		alias brs='mkdir backend && cargo init'
		alias nmtc='~/clean_dev_folders.sh'
		alias tg='/usr/bin/Telegram & disown'
		alias ga='git add .'
		alias gp='git push'
		alias rnenw4='git clone --depth 1 https://github.com/adilzhanY/react-native-expo-nativewind_v4-template.git ./ && rm -rf .git'
    alias hypreload='killall waybar && waybar & disown && pkill hyprpaper && hyprpaper -c ~/.config/hypr/hyprpaper.conf & disown && hyprctl reload'
    alias blc='bluetoothctl connect B4:84:D5:99:5F:AB'
    alias bld='bluetoothctl disconnect B4:84:D5:99:5F:AB'

  
		starship init fish | source
    set fish_greeting
		function zip
	    if test (count $argv) -lt 1
  	      echo "Usage: zip <task-number> [optional-name]"
    	    return 1
    	end

    	set tasknum $argv[1]
    	set optname ""
    	if test (count $argv) -ge 2
       	 set optname -$argv[2]
    	end

    	set filename ../task$tasknum$optname-(date "+%Y%m%d").tar.gz

    	tar -czf $filename \
       	 --show-omitted-dirs \
       	 --preserve-permissions \
       	 --exclude target \
       	 --exclude node_modules \
       	 --exclude .next \
       	 --exclude .idea \
       	 .
		end


end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
set -gx PATH ~/.npm-global/bin $PATH
