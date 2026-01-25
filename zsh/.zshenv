# fzf config with Inklight colors
export FZF_DEFAULT_OPTS=" \
  --color=fg:#1b1b1b,bg:#f2f2f2,hl:#007f4e \
  --color=fg+:#1b1b1b,bg+:#e5e5e5,hl+:#007f4e \
  --color=info:#555555,prompt:#1b1b1b,pointer:#c35c88 \
  --color=marker:#c35c88,spinner:#bb0055,header:#555555 \
  --color=border:#d7d7d7,gutter:#e5e5e5 \
  --border=rounded \
  --prompt='❯ ' \
  --pointer='▶'"

. "$HOME/.cargo/env"
