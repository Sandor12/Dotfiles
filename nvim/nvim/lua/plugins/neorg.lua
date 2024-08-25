local config = function()
	require("neorg").setup({
		load = {
			["core.defaults"] = {},
			["core.concealer"] = {
				folds = false,
				icons = {
					code_block = {
						conceal = true,
						content_only = true,
					},
					padding = {
						left = 2,
					},
				},
			},
			["core.dirman"] = {
				config = {
					workspaces = {
						notes = "~/Bureau/neorgnotes",
					},
					default_workspace = "notes",
				},
			},
		},
	})
end

return {
	"nvim-neorg/neorg",
	lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
	version = "*", -- Pin Neorg to the latest stable release
	config = config,
}
