local status_ok, treesitter = pcall(require, "nvim-treesitter")
if not status_ok then
    return
end

local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

configs.setup({
    ensure_installed = {
        all
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

    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },

    endwise = {
        enable = true,
    },
})

local ft_to_parser = require"nvim-treesitter.parsers".filetype_to_parsername
ft_to_parser.nomad = "hcl"