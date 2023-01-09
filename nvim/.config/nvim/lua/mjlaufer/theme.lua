vim.cmd [[
    " Enable True Color support.
    set termguicolors

    set background=dark
    colorscheme glint

    let g:markdown_fenced_languages = [
        \ 'html',
        \ 'sh', 'bash=sh',
        \ 'java',
        \ 'javascript', 'js=javascript',
        \ 'typescript', 'ts=typescript',
        \ 'go',
        \ 'lua',
        \ 'rust']
]]
