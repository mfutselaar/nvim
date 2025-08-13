return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "stevearc/conform.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
        "nvimdev/lspsaga.nvim",
    },

    config = function()
        require("conform").setup({
            formatters_by_ft = {
            }
        })
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local luasnip = require("luasnip")
        luasnip.config.setup {}
        require("luasnip.loaders.from_vscode").lazy_load {
            paths = "~/.config/nvim/snippets/"
        }

        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("lspsaga").setup({
            lightbulb = {
                enable = false
            },
            symbol_in_winbar = {
                enable = false
            }
        })

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "intelephense",
            },
            handlers = {
                function(server_name) -- default handler
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                    })
                end,
                ["intelephense"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.intelephense.setup({
                        capabilities = capabilities,
                        root_dir = function()
                            return vim.loop.cwd()
                        end
                    })
                end,
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
            }
        })

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<Up>'] = cmp.mapping.select_prev_item(),
                ['<Down>'] = cmp.mapping.select_next_item(),
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<Tab>'] = cmp.mapping.confirm { select = true },
                ['<Cr>'] = cmp.mapping.confirm { select = true },
                ['<C-Space>'] = cmp.mapping.complete {},
                ['<C-l>'] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, { 'i', 's' }),
                ['<C-h>'] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, { 'i', 's' }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
        })

        -- Updated diagnostic configuration for Neovim 0.11
        vim.diagnostic.config({
            virtual_text = {
                prefix = '●', -- Customize the prefix for virtual text
                source = "if_many", -- Show source only if multiple diagnostics
            },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = '✘',
                    [vim.diagnostic.severity.WARN] = '▲',
                    [vim.diagnostic.severity.INFO] = '»',
                    [vim.diagnostic.severity.HINT] = '»',
                },
            },
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = true, -- Changed to boolean for Neovim 0.11
                header = "",
                prefix = "",
            },
            severity_sort = true, -- Enable severity sorting
            underline = true,
        })

        -- Optional: Set up diagnostic signs explicitly for compatibility
        local signs = {
            Error = '✘',
            Warn = '▲',
            Info = '»',
            Hint = '»',
        }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end
    end
}
