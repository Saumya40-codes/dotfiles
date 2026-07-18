#!/usr/bin/env bash
# install.sh: symlink tracked configs into $HOME
# Safe to re-run. Existing files are backed up with a timestamp suffix.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TS="$(date +%Y%m%d%H%M%S)"

backup_and_link() {
  local src="$1"
  local dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [[ -e "$dest" || -L "$dest" ]]; then
    if [[ -L "$dest" ]] && [[ "$(readlink -f "$dest")" == "$(readlink -f "$src")" ]]; then
      echo "ok  $dest (already linked)"
      return 0
    fi
    mv "$dest" "${dest}.bak.${TS}"
    echo "bak $dest -> ${dest}.bak.${TS}"
  fi
  ln -s "$src" "$dest"
  echo "lnk $dest -> $src"
}

echo "Installing dotfiles from $ROOT"

backup_and_link "$ROOT/zshrc"            "$HOME/.zshrc"
backup_and_link "$ROOT/gitconfig"        "$HOME/.gitconfig"
backup_and_link "$ROOT/gitignore_global" "$HOME/.gitignore_global"
backup_and_link "$ROOT/config/starship.toml" "$HOME/.config/starship.toml"
backup_and_link "$ROOT/config/nvim"      "$HOME/.config/nvim"
backup_and_link "$ROOT/config/kitty"     "$HOME/.config/kitty"

echo
echo "Done. Open a new shell (or run: exec zsh) so changes take effect."
echo "Optional system packages (Ubuntu/Debian):"
echo "  sudo apt install fzf ripgrep fd-find"
echo "Optional modern CLI tools (if not already on PATH):"
echo "  bat, eza, zoxide, git-delta  (install via apt or release binaries into ~/.local/bin)"
