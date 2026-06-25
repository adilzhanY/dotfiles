# dotfiles

My personal config files, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Layout

Each top-level folder is a **stow package**. Inside it, files are placed at the
path they should occupy relative to `$HOME`:

```
dotfiles/
├── nvim/.config/nvim/         -> ~/.config/nvim
├── i3/.config/i3/             -> ~/.config/i3
├── hypr/.config/hypr/         -> ~/.config/hypr
├── waybar/.config/waybar/     -> ~/.config/waybar
├── kitty/.config/kitty/       -> ~/.config/kitty
└── starship/.config/starship.toml -> ~/.config/starship.toml
```

## Deploy on a fresh Arch install

```bash
# 1. tools
sudo pacman -S git stow

# 2. clone
git clone https://github.com/adilzhanY/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 3. symlink everything into ~/.config (or pick packages individually)
stow nvim i3 hypr waybar kitty starship
```

If a real file/folder already exists at the target (e.g. a default `~/.config/hypr`),
move it out of the way first, then re-run `stow`:

```bash
mv ~/.config/hypr ~/.config/hypr.bak
stow hypr
```

To remove the symlinks again: `stow -D <package>`.
To re-link after editing the repo: `stow -R <package>`.

## Apps these configs expect

Wayland / Hyprland stack (pacman unless noted):

```bash
sudo pacman -S hyprland hyprlock hyprpaper hyprshot xdg-desktop-portal-hyprland \
  hyprpolkitagent qt5-wayland qt6-wayland kitty wofi waybar mako firefox \
  thunar thunar-volman gvfs tumbler code pipewire pipewire-pulse wireplumber \
  playerctl python-gobject brightnessctl bluez bluez-utils networkmanager \
  network-manager-applet curl jq grim slurp starship \
  ttf-jetbrains-mono-nerd ttf-font-awesome ttf-nerd-fonts-symbols
yay -S wl-color-picker bibata-cursor-theme-bin
```

i3 (X11) extras: `sudo pacman -S i3-wm i3blocks i3lock dmenu picom`

Note: Hyprland 0.55+ deprecated the `.conf` format in favour of `hyprland.lua`,
but `.conf` is still loaded for now. Convert later with `yay -S hyprlang2lua`.
