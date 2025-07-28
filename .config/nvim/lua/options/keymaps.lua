local keymap = vim.keymap

keymap.set("v", ">", ">gv")
keymap.set("v", "<", "<gv")
keymap.set("n", "n", "nzz")
keymap.set("n", "N", "Nzz")

-- Diagnostic
keymap.set("n", "<Leader>q", vim.diagnostic.open_float)
keymap.set("n", "<Leader>gnd", vim.diagnostic.goto_next)
keymap.set("n", "<Leader>gNd", vim.diagnostic.goto_prev)

-- LspAttach
-- From https://github.com/neovim/nvim-lspconfig
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    --
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    keymap.set("n", "K", vim.lsp.buf.hover, opts)
    keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
    keymap.set({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, opts)
    keymap.set("n", "gr", vim.lsp.buf.references, opts)
    keymap.set({ "n", "v" }, "<Leader>fc", function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end
})
