return {
	"nvim-orgmode/orgmode",
	event = "VeryLazy",
	ft = { "org" },
	config = function()
		-- Setup orgmode
		require("orgmode").setup({
			org_agenda_files = "~/Bureau/orgfiles/**/*",
			org_default_notes_file = "~/Bureau/orgfiles/refile.org",
			org_capture_templates = {
				t = {
					description = "task",
					template = "*** TODO %?\n   SCHEDULED: %T",
					target = "~/Bureau/orgfiles/refile.org",
					headline = "Todo list",
				},
			},
		})
		-- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
		-- add ~org~ to ignore_install
		require("nvim-treesitter.configs").setup({
			ignore_install = { "org" },
		})
	end,
}
