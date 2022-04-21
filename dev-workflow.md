# Dev Workflow

## Window Tiling with Yabai

-   Focus window: `Opt-h/j/k/l`
-   Move window: `Ctrl-Opt-h/j/k/l`
-   Rotate counter-clockwise: `Ctrl-Opt-o`
-   Rotate clockwise: `Ctrl-Opt-p`
-   Mirror y-axis: `Ctrl-Opt-i`
-   Mirror x-axis: `Ctrl-Opt-u`
-   Resize: `Shift-Opt-h/j/k/l`

## tmux

### tmux Sessions

A `target-session` may be identified by one of the following:

-   Session ID prefixed with `$` (e.g., `$1`)
-   The start of a session name, or the exact session name

#### Managing sessions

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

-   Window ID prefixed with `@` (e.g., `@1`)
-   The start of a window name, or the exact window name

#### Managing windows

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

## Vim

[Vim cheatsheet](https://quickref.me/vim)

### Vim Buffers

-   Alternate buffer: `C-6`
-   List open buffers: `:ls`
-   Go to next buffer: `:bn` or `]b` (with vim-unimpaired)
-   Go to previous buffer: `:bp` or `[b` (with vim-unimpaired)
-   Delete buffer from buffer list: `:bd`

### Vim Splits

-   Split window vertically: `<C-w>v` or `:vsp`
-   Split window horizontally: `<C-w>s` or `:sp`
-   Close all but current split: `<C-w>o`
-   Maximize the current split: `<C-w>|` (horizontal) or `<C-w>_` (vertical)
-   Swap split with neighbor: `<C-w>x`
-   Move split: `<C-w>H/J/K/L`
-   Prefix for Neovim terminal keymaps: `<leader>t`

### Git

-   Prefix for Git keymaps: `<leader>g`

#### [Diff View](https://github.com/sindrets/diffview.nvim)

-   Stage/unstage the selected entry: `-`
-   Stage all entries: `S`
-   Unstage all entries: `U`
-   Restore entry: `X`
-   Refresh file list: `R`

#### [Vim Fugitive](https://github.com/tpope/vim-fugitive)

### Debugging

Prefix for debugger keymaps: `<leader>i`

#### Chrome

-   Install and build [vscode-chrome-debug](https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#javascript-chrome) in `$HOME/.local/share/nvim/dap/`.
-   Run Chrome with remote debugging enabled:

```sh
chrome-debug
```

-   Start the Chrome debugger: `<leader> ic`

#### Node.js

-   Install and build [node-debug2](https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#javascript) in `$HOME/.local/share/nvim/dap/`.
-   Start the Node debugger: `<leader> isn`
