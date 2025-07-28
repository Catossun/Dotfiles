return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.4",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<Leader>lg", "<cmd>Telescope live_grep<cr>",  desc = "Live grep" },
    { "<Leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<Leader>of", "<cmd>Telescope oldfiles<cr>",  desc = "Old files" },
  },
  config = function()
    local actions = require("telescope.actions")
    require("telescope").setup({
      defaults = {
        path_display = function(opts, path)
          local shorten = { len = 1, exclude = { -1, -2, -3 } }
          local Path = require "plenary.path"
          local cwd = vim.loop.cwd()
          local shorten_path = Path:new(Path:new(path):make_relative(cwd)):shorten(shorten.len, shorten.exclude)
          local tail = require("telescope.utils").path_tail(path)
          return string.format("%s  (%s)", tail, shorten_path)
        end,
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "   ",
        results_title = "",
        sorting_strategy = "ascending",
        layout_strategy = 'vertical',
        layout_config = {
          vertical = {
            preview_cutoff = 25,
            prompt_position = "top",
            preview_height = 0.45,
          },
          -- horizontal = {
          --  width = { 0.5, max = 70, min = 123 },
          --  preview_cutoff = 0,
          --  preview_width = 0.5,
          -- },
        },
        file_ignore_patterns = {
          ".git/*",
          "target/",
          "docs/",
          "vendor/*",
          "%.lock",
          "__pycache__/*",
          "%.sqlite3",
          "%.ipynb",
          "node_modules/*",
          "%.svg",
          "%.otf",
          "%.ttf",
          "%.webp",
          ".dart_tool/",
          ".github/",
          ".gradle/",
          ".idea/",
          ".settings/",
          ".vscode/",
          "__pycache__/",
          "build/",
          "gradle/",
          "node_modules/",
          "%.pdb",
          "%.dll",
          "%.class",
          "%.exe",
          "%.cache",
          "%.ico",
          "%.pdf",
          "%.dylib",
          "%.jar",
          "%.docx",
          "%.met",
          "smalljre_*/*",
          ".vale/",
          "%.burp",
          "%.mp4",
          "%.mkv",
          "%.rar",
          "%.zip",
          "%.7z",
          "%.tar",
          "%.bz2",
          "%.epub",
          "%.flac",
          "%.tar.gz",
        },
        vimgrep_arguments = {
          "rg",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--trim" -- add this value
        },
        mappings = {
          i = {
            ["<Esc>"] = actions.close,
            -- ["<leader>"] = actions.close,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-s>"] = actions.select_vertical,
          },
          n = {
            ["<C-s>"] = actions.select_vertical,
          }
        },
      },
      extensions = {
        file_browser = {}
      }
    })
  end,
}
