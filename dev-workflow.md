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

Use one tmux session per project.

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

Use tmux windows to separate Vim from running processes.

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

Use tmux panes sparingly. A good use case may be launching a test runner in `watch` mode.

#### Managing panes

-   Create a pane to the right: `<prefix> %`
-   Next/previous pane: `<prefix> ;`/`<prefix> o`
-   Kill current pane: `<prefix> x`

## Vim

### Vim Splits

Use the ToggleTerm plugin to display a Vim split with an integrated terminal. This is particularly
useful for entering git commands (if not using vim-fugitive) or launching a test runner (if not
using a tmux split).

-   `<leader>tl`: Toggle terminal in a vertical split to the right.
-   `<leader>th`: Toggle terminal in a horizontal split below.
-   `<leader>tu`: Toggle a floating terminal.

Use Vim splits to display more than one buffer in a Vim instance.

-   `:vsp`: Display a vertical split.
-   `:sp`: Display a horizontal split.

### Vim Navigation

Use the Telescope plugin (a fuzzy finder) to find files.

### Debugging

Open Vim, and install debuggers.

```
:DIList
:DIInstall
```

#### JavaScript and TypeScript

Run the Chrome debugger.

```sh
chrome-debug
```

-   `<leader>dc`: Start/continue.
