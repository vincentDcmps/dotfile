return {
    {
        "https://github.com/lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = function()
            require("gitsigns").setup({
                current_line_blame = true,
            })
        end,
    },
    {
        "https://github.com/NeogitOrg/neogit",
        keys = {
            {
                '<leader>gn',
                function()
                    return require('neogit').open({cwd = "%:p:h"})
                end,
                desc = 'Open neogit',
            }
        },

        cmd = "Neogit",
        config = function()
            require("neogit").setup({
                disable_commit_confirmation = true,
                kind = "split",
                integrations = {
                    diffview = true,
                },
            })
        end,
    },

}
