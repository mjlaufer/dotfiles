return {
    cmd = { vim.fn.stdpath('data') .. '/mason/bin/gradle-language-server' },
    filetypes = { 'groovy', 'kotlin' },
    root_markers = {
        'settings.gradle',
        'settings.gradle.kts',
        'build.gradle',
        'build.gradle.kts',
    },
}
