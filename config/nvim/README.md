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

- **Go**: `ray-x/go.nvim` (`<leader>gt/gi/gf/gr`, DAP via `<leader>db`, `<F5>`)
- **Java**: LazyVim `lang.java` extra (jdtls via Mason) + `<leader>rj` run file
- **Others**: docker, json, yaml, python, rust, toml, markdown, git extras

Open `:Mason` and install recommended tools (gopls, gofumpt, jdtls, …).

## Useful keys

| Key | Action |
|-----|--------|
| `<leader>fw` | Live grep |
| `<leader>fv` | Find files |
| `<leader>db` | Toggle breakpoint |
| `<leader>du` | DAP UI |
| `<leader>tt/tv/tf` | ToggleTerm H/V/float |
| `<C-\>` | ToggleTerm default map |
| `<leader>gt` | Go test |

## Sync

```vim
:Lazy sync
:LazyExtras
```
