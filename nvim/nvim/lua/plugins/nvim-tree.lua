return {
	"nvim-tree/nvim-tree.lua",
	lazy = false, --with true nvim tree doesn't work at all
	config = function()
		vim.cmd([[hi NvimTreeNormal guibg=NONE ctermbg=None]])
		require("nvim-tree").setup({
			filters = {
				dotfiles = false,
			},
		})
	end,
}
