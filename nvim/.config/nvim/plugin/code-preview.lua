if IS_VSCODE then
    return
end

-- Intercepts AI coding agent edits (Claude Code, etc.) and shows them as native
-- diffs before they hit disk. To wire it to Claude Code, run once inside Neovim:
--   :CodePreviewInstallClaudeCodeHooks
-- That installs a PreToolUse hook in your Claude Code settings.json.
require('code-preview').setup({
    diff = { layout = 'tab' }, -- 'tab' | 'vsplit' | 'inline'

    -- Use Inklight's diff highlight groups instead of the plugin's hardcoded colors.
    -- Values are passed straight to nvim_set_hl, so linking to the global Diff* groups makes the
    -- preview follow the colorscheme.
    highlights = {
        current = {
            DiffAdd = { link = 'DiffAdd' },
            DiffDelete = { link = 'DiffDelete' },
            DiffChange = { link = 'DiffChange' },
            DiffText = { link = 'DiffText' },
        },
        proposed = {
            DiffAdd = { link = 'DiffAdd' },
            DiffDelete = { link = 'DiffDelete' },
            DiffChange = { link = 'DiffChange' },
            DiffText = { link = 'DiffText' },
        },
        inline = {
            added = { link = 'DiffAdd' },
            removed = { link = 'DiffDelete' },
            added_text = { link = 'DiffTextAdd' },
            removed_text = { link = 'DiffText' },
        },
    },
})
