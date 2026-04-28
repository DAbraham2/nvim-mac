local lspconfig = require('lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

-- 1. Global Diagnostic UI (replaces lsp_zero.set_sign_icons)
local signs = { Error = "✘", Warn = "▲", Hint = "⚑", Info = "»" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

require('mason-lspconfig').setup({
    ensure_installed = { 'rust_analyzer', 'pyright', 'ruff', 'yamlls', 'lua_ls' },
    handlers = {
        -- Default setup for all servers
        function(server_name)
            lspconfig[server_name].setup({
                capabilities = lsp_capabilities,
            })
        end,

        -- Targetted overrides
        ["lua_ls"] = function()
            lspconfig.lua_ls.setup({
                capabilities = lsp_capabilities,
                settings = { Lua = { diagnostics = { globals = { 'vim' } } } }
            })
        end,

        ["pyright"] = function()
            lspconfig.pyright.setup({
                capabilities = lsp_capabilities,
                settings = {
                    pyright = { disableOrganizeImports = true },
                    python = { analysis = { ignore = { '*' }, logLevel = "Trace" } },
                }
            })
        end,

        ["ruff"] = function()
            lspconfig.ruff.setup({
                capabilities = lsp_capabilities,
                on_attach = function(client)
                    client.server_capabilities.hoverProvider = false
                end,
                init_options = {
                    settings = {
                        lineLength = 88,
                        format = { ["quote-style"] = "single" }
                    }
                }
            })
        end,

        ["yamlls"] = function()
            lspconfig.yamlls.setup({
                capabilities = lsp_capabilities,
                filetypes = { "yaml", "yaml-jinja" }
            })
        end
    }
})

-- 4. Autocompletion (nvim-cmp)
local cmp = require('cmp')
cmp.setup({
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip', keyword_length = 2 },
        { name = 'buffer',  keyword_length = 3 },
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        ['<Enter>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
})
