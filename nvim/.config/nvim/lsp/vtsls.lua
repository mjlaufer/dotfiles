local lang_settings = {
    inlayHints = {
        parameterNames = { enabled = 'literals' },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
    },
}

return {
    settings = {
        vtsls = {
            autoUseWorkspaceTsdk = true,
        },
        javascript = lang_settings,
        typescript = lang_settings,
    },
}
