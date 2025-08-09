return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    spec = {
      { "<Leader>?", "<cmd>lua require('which-key').show()<CR>", desc = "Show keymaps" },

      { "<Leader>q", group = "Diagnostic" },
      { "<Leader>qn", vim.diagnostic.goto_next,  desc = "Go to next diagnostic" },
      { "<Leader>qp", vim.diagnostic.goto_prev,  desc = "Go to previus diagnostic" },
      { "<Leader>qq", vim.diagnostic.open_float,  desc = "Show diagnostic" },

      { "<Leader>lg", "<cmd>Telescope live_grep<cr>",  desc = "Live grep" },
      { "<Leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<Leader>of", "<cmd>Telescope oldfiles<cr>",  desc = "Old files" },
      { "<Leader>fe", "<cmd>Telescope file_browser<CR>", desc = "File Browser" },
    }
  }
}

