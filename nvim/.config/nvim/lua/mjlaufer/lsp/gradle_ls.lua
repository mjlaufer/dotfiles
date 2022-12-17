return function(opts)
    local gradle_ls_path = vim.fn.stdpath('data') ..
                               '/mason/packages/gradle-language-server/gradle-language-server'
    return {cmd = {gradle_ls_path}, on_attach = opts.on_attach, capabilities = opts.capabilities}
end
