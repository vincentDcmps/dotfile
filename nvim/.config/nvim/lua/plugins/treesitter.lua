return {
    {
        "https://github.com/nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "bash",
                    "c",
                    "dockerfile",
                    "gitcommit",
                    "go",
                    "hcl",
                    "javascript",
                    "json",
                    "json5",
                    "jsonnet",
                    "latex",
                    "lua",
                    "nix",
                    "markdown",
                    "proto",
                    "python",
                    "rego",
                    "rust",
                    "terraform",
                    "typescript",
                    "yaml",
                },
                highlight = {
                    enable = true,
                },
                autopairs = {
                     enable = true,
                },
                indent = {
                    enable = true,
                },
                endwise = {
                    enable = true,
                },
            })
            vim.treesitter.language.register("nomad", "hcl")
        end,
    },

}
