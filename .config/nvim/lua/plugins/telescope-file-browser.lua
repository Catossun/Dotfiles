return {
	"nvim-telescope/telescope-file-browser.nvim",
	dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	keys = {
		{ "<Leader>fe", "<cmd>Telescope file_browser<CR>", desc = "File Browser" },
	},
	config = function()
		require("telescope").load_extension("file_browser")
	end,
}
