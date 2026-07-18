# dotfiles

My yet another try to maintain my dotfiles online.

Personal configuration for a Linux development environment: shell, prompt, editor, git, and terminal. The goal is a single cloneable source of truth that makes it straightforward to restore a familiar setup on a new machine.

## Contents

| Path | Description |
|------|-------------|
| `zshrc` | Interactive zsh: PATH, history, completion, aliases, fzf, zoxide, plugins, Starship |
| `gitconfig` | Git defaults, aliases, and delta as the pager |
| `gitignore_global` | Global ignore patterns |
| `config/starship.toml` | Starship prompt (Catppuccin Mocha) |
| `config/nvim/` | Neovim (LazyVim), Catppuccin, Go/Java helpers, DAP, Telescope |
| `config/kitty/` | Kitty terminal font, opacity, and Catppuccin Mocha colors |
| `install.sh` | Symlink installer with timestamped backups |

Secrets, credentials, shell history, WakaTime config, and `.env` files are intentionally not tracked.

## Motivation

Reinstalls and spare machines should not require rebuilding aliases, prompt settings, and editor wiring from scratch. Keeping this layer in version control turns that work into a clone and a short install.

## Quick start

```bash
git clone git@github.com:Saumya40-codes/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
exec zsh
```

`install.sh` will:

1. Create parent directories under `$HOME` when needed.
2. Move any existing target to `*.bak.<timestamp>` before linking.
3. Symlink tracked files from this repository into the usual locations.

Review the script before running it if you already manage configs manually, and link only the pieces you want.

## Companion tools

Not all of these are required, but the configs work best when they are available:

- **Shell**: zsh, Starship, zsh-autosuggestions, zsh-syntax-highlighting, zsh-history-substring-search, zsh-completions
- **CLI**: fzf, ripgrep, fd, bat, eza, zoxide, delta (git-delta)
- **Editor**: Neovim 0.11+, LazyVim (bootstrapped on first open via lazy.nvim)
- **Terminal**: Kitty with a Nerd Font (for example JetBrainsMono Nerd Font Mono)
- **Languages** (as needed): Go, JDK, Node, Python, rustup, rbenv

On Ubuntu or Debian:

```bash
sudo apt update
sudo apt install zsh fzf ripgrep fd-find
```

Modern CLI tools can also be installed as release binaries into `~/.local/bin`.

## Neovim

LazyVim-based setup with Catppuccin Mocha, language extras (Java, Docker, JSON, YAML, Python, Rust, and related), `ray-x/go.nvim`, toggleterm, and DAP. After install, open Neovim once and let `:Lazy` finish bootstrapping. Use `:Mason` for language servers and formatters.

Useful keys (see also `config/nvim/README.md`):

- `<leader>fw` live grep, `<leader>fv` find files
- `<leader>db` breakpoint, `<F5>` continue
- `<leader>got` Go test, `<leader>rj` Java scratch run
- `<leader>th` / `<leader>tv` / `<leader>tf` terminals

## Layout

Paths in this repository mirror their install destinations so `install.sh` stays small. This is a personal baseline for shell, prompt, git, and editor configuration, not a full desktop or OS image.

## Safety

If you reuse `gitconfig`, set `user.name` and `user.email` to your own identity before committing. Do not put tokens or private keys in tracked files; keep them in untracked local config or a secret store.

## License

Provided as-is for personal reuse. Adapt as needed.
