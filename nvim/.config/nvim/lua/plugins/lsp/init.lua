return {
    {
        "https://github.com/williamboman/mason-lspconfig.nvim",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "https://github.com/williamboman/mason.nvim",
            "https://github.com/neovim/nvim-lspconfig",
        },
        config = function()
            require("plugins.lsp.handlers").setup()
            local servers = {
                "ansiblels",
                "bashls",
                "cssls",
                "dockerls",
                "gopls",
                "html",
                "jsonls",
                "pyright",
                "pylsp",
                "rnix",
                "lua_ls",
                "marksman",
                "sqlls",
                "terraformls",
                "tflint",
                "yamlls",
            }
            local settings = {
                ui = {
                    border = "none",
                    icons = {
                        package_installed = "◍",
                        package_pending = "◍",
                        package_uninstalled = "◍",
                    },
                },
                log_level = vim.log.levels.INFO,
                max_concurrent_installers = 4,
            }
            require("mason").setup(settings)
            require("mason-lspconfig").setup({
                ensure_installed = servers,
                automatic_installation = true,
            })
            
            
            local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
            if not lspconfig_status_ok then
                    return
            end
            
            
            for _, server in pairs(servers) do
                opts = {
                    on_attach = require("plugins.lsp.handlers").on_attach,
                    capabilities = require("plugins.lsp.handlers").capabilities,
                }
            
                server = vim.split(server, "@")[1]
            
                local require_ok, conf_opts = pcall(require, "plugins.lsp.settings." .. server)
                if require_ok then
                    opts = vim.tbl_deep_extend("force", conf_opts, opts)
                end
            
                lspconfig[server].setup(opts)
            end
        end
    },
    {
        "https://github.com/jose-elias-alvarez/null-ls.nvim",
        lazy = true,
        event = { "BufReadPre", "BufNewFile" },
        config = function()

            null_ls=require"null-ls"
            require "null-ls".setup({
                debug = false,
                sources = {
                    null_ls.builtins.formatting.prettier.with({
                        extra_filetypes = { "toml" },
                        extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
                    }),
                    null_ls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.google_java_format,
                    null_ls.builtins.diagnostics.flake8,
                    null_ls.builtins.diagnostics.eslint,
                    null_ls.builtins.diagnostics.markdownlint,
                },
            })
        end
    },
}
