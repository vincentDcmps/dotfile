return {
    {
        'ellisonleao/gruvbox.nvim',
        event = "VeryLazy",
    },
    {
        "echasnovski/mini.bufremove",
        -- stylua: ignore
         keys = {
            { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
            { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
          },
    },
    {
        "https://github.com/akinsho/bufferline.nvim",
        event = "VeryLazy",
        config = function()
            require("bufferline").setup({
                options = {
                        -- stylua: ignore
                    close_command = function(n) require("mini.bufremove").delete(n, false) end,
                    -- stylu  a: ignore
                    right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
                    always_show_bufferline = false,
                    offsets = {
                        {
                           filetype = "NvimTree",
                           text = "nvim-tree",
                           highlight = "Directory",
                           text_align = "left",
                        },
                    },
                },
            })
        end,
    },
    {
        "kyazdani42/nvim-tree.lua",
        event = "VeryLazy",
        config = function()
            require("nvim-tree").setup({
                update_focused_file = {
                    enable = false,
                    update_root = true,
                },
                diagnostics = {
                    enable = true,
                    show_on_dirs = true,
                    icons = {
                        hint = "",
                        info = "",
                        warning = "",
                        error = "",
                    },
                },
                view = {
                    width = 30,
                    side = "left",
                },
            })
        end
    },
    {
      "https://github.com/folke/which-key.nvim",
      event = "VeryLazy",
      opts = {
        plugins = { spelling = true },
        defaults = {
          mode = { "n", "v" },
          {"<leader><tab>", group = "tabs" },
          {"<leader>b"  , group = "buffer" },
          {"<leader>c"  , group = "code" },
          {"<leader>f"  , group = "file/find" },
          {"<leader>g"  , group = "git" },
          {"<leader>gh", group = "hunks" },
          {"<leader>q"  , group = "quit/session" },
          {"<leader>s"  , group = "search" },
          {"<leader>u"  , group = "ui" },
          {"<leader>w"  , group = "windows" },
          {"<leader>x"  , group = "diagnostics/quickfix" },
          },
        },
      config = function(_, opts)
        local wk = require("which-key")
        wk.setup(opts)
        wk.add(opts.defaults)
      end,
    },
    {
        "https://github.com/nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        config = function()
            require("lualine").setup({
                options = {
                    globalstatus = true,
                },
            })
        end,
    },
    {
        "https://github.com/j-hui/fidget.nvim",
        tag = "legacy", -- TODO https://github.com/j-hui/fidget.nvim/issues/131
        event = "VeryLazy",
        config = function()
            require("fidget").setup({
                text = {
                    spinner = "dots",
                },
            })
        end,
    },
    {
      "rcarriga/nvim-notify",
      keys = {
        {
          "<leader>un",
          function()
            require("notify").dismiss({ silent = true, pending = true })
          end,
          desc = "Dismiss all Notifications",
        },
      },
      opts = {
        timeout = 3000,
        max_height = function()
          return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
          return math.floor(vim.o.columns * 0.75)
        end,
      },
    },
    {
      "stevearc/dressing.nvim",
      lazy = true,
      init = function()
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.select = function(...)
          require("lazy").load({ plugins = { "dressing.nvim" } })
          return vim.ui.select(...)
        end
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.input = function(...)
          require("lazy").load({ plugins = { "dressing.nvim" } })
          return vim.ui.input(...)
        end
      end,
    },
    {
      "SmiteshP/nvim-navic",
      lazy = true,
      opts = function()
        return {
          separator = " ",
          highlight = true,
          depth_limit = 5,
        }
      end,
    },
    { "MunifTanjim/nui.nvim", lazy = true }
}
