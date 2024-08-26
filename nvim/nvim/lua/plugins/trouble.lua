return {
	"folke/trouble.nvim",
	lazy = false,
	cmd = { "Trouble" },
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		modes = {
			lsp = {
				win = {
					position = "right",
				},
			},
		},
	},
	keys = {
		{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "diagnostics " },
		{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
	},
}
