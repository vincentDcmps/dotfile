return {
  {
    "https://github.com/navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      require("onedark").setup({
        style = 'deep',
        transparent = true,
      })
      require("onedark").load()
    end,
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
        { "<leader><tab>", group = "tabs" },
        { "<leader>b",     group = "buffer" },
        { "<leader>c",     group = "code" },
        { "<leader>f",     group = "file/find" },
        { "<leader>g",     group = "git" },
        { "<leader>gh",    group = "hunks" },
        { "<leader>q",     group = "quit/session" },
        { "<leader>s",     group = "search" },
        { "<leader>u",     group = "ui" },
        { "<leader>w",     group = "windows" },
        { "<leader>x",     group = "diagnostics/quickfix" },
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
