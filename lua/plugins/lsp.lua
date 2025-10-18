return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "stevearc/conform.nvim",
        {
            "saghen/blink.cmp",
            version = "1.*"
        },
        "L3MON4D3/LuaSnip",
        "j-hui/fidget.nvim",
        "nvimdev/lspsaga.nvim",
        "seblyng/roslyn.nvim"
    },
    config = function()
        -- Formatter
        require("conform").setup({
            formatters_by_ft = {}
        })

        -- Snippets
        local luasnip = require("luasnip")
        luasnip.config.setup {}
        require("luasnip.loaders.from_vscode").lazy_load {
            paths = "~/.config/nvim/snippets/"
        }

        -- Capabilities (Blink replaces cmp-nvim-lsp)
        local capabilities = vim.lsp.protocol.make_client_capabilities()

        -- UI helpers
        require("lspsaga").setup({
            lightbulb = { enable = false },
            symbol_in_winbar = { enable = false }
        })
        require("fidget").setup({})

        ----------------------------------------------------------------------
        -- LSP CONFIGS (new style: vim.lsp.config only)
        ----------------------------------------------------------------------

        -- Lua
        vim.lsp.config("lua_ls", {
            capabilities = capabilities,
            settings = {
                Lua = {
                    runtime = { version = "Lua 5.1" },
                    diagnostics = {
                        globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                    }
                }
            }
        })
        vim.lsp.enable("lua_ls")

        -- Bash
        vim.lsp.config("bashls", { capabilities = capabilities })
        vim.lsp.enable("bashls")

        -- Intelephense
        vim.lsp.config("intelephense", {
            capabilities = capabilities,
            root_dir = function()
                return vim.loop.cwd()
            end
        })

        -- Clangd
        vim.lsp.config("clangd", { capabilities = capabilities })
        vim.lsp.enable("clangd")

        -- CMake
        vim.lsp.config("cmake", { capabilities = capabilities })
        vim.lsp.enable("cmake")

        -- Docker
        vim.lsp.config("dockerls", { capabilities = capabilities })
        vim.lsp.enable("dockerls")

        -- Go
        vim.lsp.config("gopls", { capabilities = capabilities })
        vim.lsp.enable("gopls")

        -- HTML
        vim.lsp.config("html", { capabilities = capabilities })
        vim.lsp.enable("html")

        -- Laravel
        vim.lsp.config("laravel_ls", { capabilities = capabilities })
        vim.lsp.enable("laravel_ls")

        -- Rust
        vim.lsp.config("rust_analyzer", { capabilities = capabilities })
        vim.lsp.enable("rust_analyzer")


        -- .NET (Roslyn)
        -- vim.env.PATH = vim.env.PATH .. vim.fn.expand(":$HOME/.local/share/roslyn/content/LanguageServer/linux-x64")
        -- vim.lsp.config("roslyn_ls", { capabilities = capabilities })

        ----------------------------------------------------------------------
        -- Blink completion setup
        ----------------------------------------------------------------------
        require("blink-cmp").setup({
            keymap = {
                preset = "default",
                ["<Tab>"] = { "select_next", "fallback" },
                ["<S-Tab>"] = { "select_prev", "fallback" },
                ["<CR>"] = { "accept", "fallback" },
                ["<C-Space>"] = { "show", "fallback" },
            },
            sources = {
                default = { "lsp", "snippets", "path", "buffer" }
            },
            completion = {
                accept = { auto_brackets = { enabled = true } }
            },
            snippets = { preset = 'luasnip' }
        })

        ----------------------------------------------------------------------
        -- Diagnostics
        ----------------------------------------------------------------------
        vim.diagnostic.config({
            virtual_text = { prefix = '●', source = "if_many" },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = '✘',
                    [vim.diagnostic.severity.WARN]  = '▲',
                    [vim.diagnostic.severity.INFO]  = '»',
                    [vim.diagnostic.severity.HINT]  = '»',
                },
            },
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = true,
                header = "",
                prefix = "",
            },
            severity_sort = true,
            underline = true,
        })

        local signs = { Error = '✘', Warn = '▲', Info = '»', Hint = '»' }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end
    end
}
