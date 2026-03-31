if IS_VSCODE then
    return
end

vim.opt.background = 'light'
vim.cmd.colorscheme('inklight')

vim.g.markdown_fenced_languages = {
    'sh',
    'bash=sh',
    'c',
    'go',
    'html',
    'java',
    'javascript',
    'js=javascript',
    'lua',
    'rust',
    'typescript',
    'ts=typescript',
}
