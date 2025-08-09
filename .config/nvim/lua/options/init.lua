-- Nord Color Palette for Neovim
local nord = {
  -- Polar Night (Dark colors)
  nord0 = "#2e3440",   -- darkest
  nord1 = "#3b4252",   -- dark
  nord2 = "#434c5e",   -- medium dark
  nord3 = "#4c566a",   -- light dark

  -- Snow Storm (Light colors)
  nord4 = "#d8dee9",   -- light
  nord5 = "#e5e9f0",   -- lighter
  nord6 = "#eceff4",   -- lightest

  -- Frost (Blue/Cyan colors)
  nord7 = "#8fbcbb",   -- cyan
  nord8 = "#88c0d0",   -- light blue
  nord9 = "#81a1c1",   -- blue
  nord10 = "#5e81ac",  -- dark blue

  -- Aurora (Accent colors)
  nord11 = "#bf616a",  -- red
  nord12 = "#d08770",  -- orange
  nord13 = "#ebcb8b",  -- yellow
  nord14 = "#a3be8c",  -- green
  nord15 = "#b48ead",  -- purple
}

vim.cmd.colorscheme("tokyonight-night")
vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "LineNr", { fg = nord.nord4, bg = nord.nord2 })
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = nord.nord4 })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = nord.nord4 })
vim.api.nvim_set_hl(0, "Whitespace", { fg = nord.nord3, bg = nord.nord4 })

vim.o.rnu = true
vim.o.number = true
vim.o.list = true
