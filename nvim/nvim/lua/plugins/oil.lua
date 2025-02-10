return {
	"stevearc/oil.nvim",
	lazy = false,
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		default_file_explorer = true,
		columns = {
			"icon",
			"permissions",

			"size",
		},
		view_options = {
			show_hidden = true,
		},
	},
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
