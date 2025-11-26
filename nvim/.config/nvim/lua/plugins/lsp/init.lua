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
                ansiblels = {
                  filetype = {
                    'yaml.ansible',
                  }
                },
                bashls = {},
                cssls = {},
                dockerls = {},
                gopls = {},
                html = {},
                jsonls = {},
                pyright = {},
                pylsp = {},
                rnix = {},
                lua_ls = {},
                marksman = {},
                sqlls = {},
                terraformls = {
                  filetype= {
                    "hcl",
                    "terraform",
                    "terraform-vars",
                    "nomad",
                  }
                },
                tflint = {},
                yamlls = {}
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
            for  server, config in pairs(servers) do
                config.attach = require("plugins.lsp.handlers").on_attach
                config.capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
                vim.lsp.config(server,config)
            end
        end
    },
}
