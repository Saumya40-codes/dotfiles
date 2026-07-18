# Neovim config (LazyVim)

Stack: **Neovim 0.11+**, **LazyVim**, **lazy.nvim**, **Catppuccin Mocha**.

## Layout

| Path | Purpose |
|------|---------|
| `init.lua` | Bootstraps lazy |
| `lua/config/options.lua` | Editor options |
| `lua/config/keymaps.lua` | Extra keymaps |
| `lua/config/autocmds.lua` | Autocommands |
| `lua/config/lazy.lua` | Plugin manager setup |
| `lua/plugins/*` | Custom plugins / overrides |
| `lazyvim.json` | Enabled LazyVim extras |

## Languages

- **Go**: LazyVim `lang.go` (gopls via Mason) + `ray-x/go.nvim` helpers (`<leader>go*`)
- **Java**: LazyVim `lang.java` extra (jdtls via Mason) + `<leader>rj` scratch run
- **Others**: docker, json, yaml, python, rust, toml, markdown, git, dap extras

Open `:Mason` and install recommended tools (gopls, gofumpt, jdtls, …).

## Useful keys

| Key | Action |
|-----|--------|
| `<leader>fw` | Live grep |
| `<leader>fv` | Find files |
| `<leader>db` | Toggle breakpoint (LazyVim) |
| `<leader>du` | DAP UI (LazyVim) |
| `<F5>` / `<F10>`-`<F12>` | DAP continue / step |
| `<leader>dbg` | Debug Go test |
| `<leader>got` / `gof` / `gor` | Go test / format / run |
| `<leader>th` / `tv` / `tf` | ToggleTerm H/V/float |
| `<C-\>` | ToggleTerm default map |
| `<leader>rj` | Java scratch compile+run |

## Sync

```vim
:Lazy sync
:LazyExtras
```
