return function(opts)
    return {
        settings = {
            json = {
                schemas = {
                    {
                        fileMatch = {'package.json'},
                        url = 'https://json.schemastore.org/package.json',
                    },
                    {
                        fileMatch = {'tsconfig*.json'},
                        url = 'https://json.schemastore.org/tsconfig.json',
                    },
                    {
                        fileMatch = {'jsconfig*.json'},
                        url = 'https://json.schemastore.org/jsconfig.json',
                    },
                    {
                        fileMatch = {
                            '.prettierrc',
                            '.prettierrc.json',
                            'prettier.config.json',
                            'prettier.config.js',
                        },
                        url = 'https://json.schemastore.org/prettierrc.json',
                    },
                    {
                        fileMatch = {'.eslintrc', '.eslintrc.json'},
                        url = 'https://json.schemastore.org/eslintrc.json',
                    },
                    {
                        fileMatch = {'.babelrc', '.babelrc.json'},
                        url = 'https://json.schemastore.org/babelrc.json',
                    },
                    {
                        fileMatch = {'.stylelintrc', '.stylelintrc.json', 'stylelint.config.json'},
                        url = 'http://json.schemastore.org/stylelintrc',
                    },
                },
            },
        },
        on_attach = opts.on_attach,
        capabilities = opts.capabilities,
    }
end
