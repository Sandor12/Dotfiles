local config = function()
	require("neorg").setup({
		load = {
			["core.defaults"] = {},
			["core.concealer"] = {
				config = {
					folds = false,
					icons = {
						code_block = {
							conceal = true,
							content_only = false,
						},
						-- padding = {
						-- 	left = 2,
						-- },
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
			["core.integrations.nvim-cmp"] = {},
			["core.export"] = { config = { extensions = "all" } },
			["core.integrations.image"] = {},
			["core.latex.renderer"] = {},
		},
	})
end

return {
	"nvim-neorg/neorg",
	lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
	version = "7.0", -- Pin Neorg to the latest stable release
	config = config,
}
