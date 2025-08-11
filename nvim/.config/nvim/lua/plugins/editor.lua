return {
  {
    'jvirtanen/vim-hcl',
    event = "VeryLazy"
  },
  {
    "https://github.com/iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = "cd app && yarn install",
    setup = function()
      require("markdown-preview").setup({})
      vim.keymap.set("n", "<leader>mp", ":MarkdownPreviewToggle<cr>", { silent = true })
    end
  },
  {
    "https://github.com/MagicDuck/grug-far.nvim",
    lazy = true,
    config = function()
      require("grug-far").setup({})
    end,
  },
  {
    "https://github.com/ibhagwan/fzf-lua",
    dependencies = {
      "https://github.com/elanmed/fzf-lua-frecency.nvim",
    },
    event = "VeryLazy",
    config = function()
      require("fzf-lua").setup({
        "max-perf",
        winopts = {
          height = 0.5,
          width = 1,
          row = 1,
        },
      })
      require("fzf-lua").register_ui_select()
      require("fzf-lua-frecency").setup({
        display_score = false,
      })
    end,
    keys = {
      { "<Leader>/",     "<Cmd>FzfLua live_grep<CR>",       desc = "Live grep" },
      { "<leader>:",     "<cmd>FzfLua command_history<cr>", desc = "Command History" },
      { "<leader><space>", "<cmd>FzfLua files<cr>",           desc = "find files" },
      { "<leader>gc",    "<cmd>FzfLua git_commits<CR>",     desc = "Commits" },
      { "<leader>gs",    "<cmd>FzfLua git_status<CR>",      desc = "Status" },
      { '<leader>s"',    "<cmd>FzfLua registers<cr>",       desc = "Registers" },
      { "<leader>sa",    "<cmd>FzfLua autocmds<cr>",        desc = "Auto Commands" },
      { "<leader>sb",    "<cmd>FzfLua grep_curbuf<cr>",     desc = "Buffer" },
      { "<leader>sc",    "<cmd>FzfLua command_history<cr>", desc = "Command History" },
      { "<leader>sC",    "<cmd>FzfLua commands<cr>",        desc = "Commands" },
    }
  },
  {
    'zhou13/vim-easyescape',
    config = function()
      vim.g.easyescape_chars   = {
        j = 0,
        k = 0
      }
      vim.g.easyescape_timeout = 99
    end
  },

  {
    "https://github.com/windwp/nvim-autopairs",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
        fast_wrap = {
        },
      })
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    opts = {},
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
  },
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          markdown = { "prettier" },
          terraform = { "terraform_fmt"},
          go = {"gofmt"},
          nomad= {"nomad_fmt"}
        },
      })
      vim.keymap.set({ "n", "v" }, "<leader>lf", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        })
      end, { desc = "Format file or range (in visual mode)" })
    end,
  },
  
}
