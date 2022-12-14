# Cheatsheet

## Neovim

[Vim cheatsheet](https://quickref.me/vim)

### Git integration

Prefix for Terminal keymaps: `<leader>t`

Prefix for Git keymaps: `<leader>g`

-   Open floating terminal with [Lazygit](https://github.com/jesseduffield/lazygit): `<leader>tg`
-   Open/close [Diffview](https://github.com/sindrets/diffview.nvim): `<leader>go`/`<leader>gc`
-   [Vim Fugitive](https://github.com/tpope/vim-fugitive): `:G`

## tmux

### Basics

-   Enter scroll mode: `<prefix> [`
-   Exit scroll mode: `q`

### Sessions

A `target-session` may be identified by one of the following:

1.  Session ID prefixed with `$` (e.g., `$1`)
2.  The start of a session name, or the exact session name

-   List sessions: `tmux ls`
-   Create a new session: `tmux new -s session-name [-d] [-n window-name] [-c start-dir] [shell-cmd]`
-   Attach to a session: `tmux attach -t target-session`
-   Detach from current session: `<prefix> d`
-   Next/previous session: `<prefix> (`/`<prefix> )`
-   Alternate session: `<prefix> L`
-   Rename current session: `<prefix> $`
-   Rename target session: `tmux rename [-t target-session] new-name`
-   Kill session: `tmux kill-session -t target-session`
-   Kill tmux server (all sessions): `tmux kill-server`

### tmux Windows

A `target-window` may be identified by one of the following:

1.  Window ID prefixed with `@` (e.g., `@1`)
2.  The start of a window name, or the exact window name

-   List sessions and windows: `<prefix> w`
-   List windows in a session: `tmux lsw -t target-session`
-   Create a new window: `<prefix> c`
-   Create a new window (with args): `tmux neww [-c start-dir] [-n window-name] [shell-cmd]`
-   Select window: `<prefix> window-index`
-   Next/previous window: `<prefix> n`/`<prefix> p`
-   Rename current window: `<prefix> ,`
-   Rename target window: `tmux renamew -t target-window [new-name]`
-   Kill current window: `<prefix> &`
-   Kill target window: `tmux killw -t target-window`

### tmux Panes

Note: tmux split directions are the opposite of Vim split directions.

-   Split window horizontally: `<prefix> %`
-   Split window vertically: `<prefix> "`
-   Navigate panes: `<prefix> h/j/k/l`
-   Next/previous pane: `<prefix> ;`/`<prefix> o`
-   Close current pane: `<prefix> x`
