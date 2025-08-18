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
                automatic_installation = true,
            })
            local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
            if not lspconfig_status_ok then
                    return
            end
            for  server, config in pairs(servers) do
                config.on_attach = require("plugins.lsp.handlers").on_attach
                config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
                lspconfig[server].setup(config)
            end
        end
    },
}
