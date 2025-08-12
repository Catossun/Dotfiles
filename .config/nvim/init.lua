-- Set Leader key to Space
vim.g.mapleader = " "

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.fileformat = "unix"
vim.opt.expandtab = true

-- Install lazy.vim package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup({
  spec = {
    {import = "plugins"},
  },
  performance = {
    cache = {
      -- Disable cache to prevent ENAMETOOLONG
      enabled = false,
    },
  },
})

-- Load vim options
require("options")
require("options.keymaps")

