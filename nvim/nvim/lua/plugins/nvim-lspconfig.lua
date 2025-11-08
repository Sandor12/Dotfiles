local config = function()
	local lspconfig = require("lspconfig")
	local cmp_nvim_lsp = require("cmp_nvim_lsp")

	local signs = { Error = " ", Warn = " ", Hint = "-", Info = "" }
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	local on_attach = function(client, bufnr)
		local opts = { noremap = true, silent = true, buffer = bufnr }

		vim.keymap.set("n", "gf", "<cmd>Lspsaga finder<CR>", opts)
		vim.keymap.set("n", "gD", "<cmd>Lua vim.lsp.buf.implementation<CR>", opts)
		vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
		vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)
		vim.keymap.set("n", "gi", "<cmd>Lua vim.lsp.buf.implementation<CR>", opts)
		vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
		vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
		vim.keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostic<CR>", opts)
		vim.keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostic<CR>", opts)
		vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) --get the manual entry for the function
	end

	local capabilities = cmp_nvim_lsp.default_capabilities()

	lspconfig.lua_ls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = { -- custom settings for lua
			Lua = {
				-- make the language server recognize "vim" global
				diagnostics = {
					globals = { "vim" },
				},
				telemetry = { enable = false },
				workspace = {
					library = {
						vim.fn.expand("$VIMRUNTIME/lua"),
						vim.fn.stdpath("config") .. "/lua",
					},
				},
			},
		},
	})

	lspconfig.pyright.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			pyright = {
				disableOrganizeImports = true,
				analysis = {
					useLibraryCodeForTypes = true,
					autoSearchPaths = true,
					diagnosticMode = "workspace",
					autoImportCompletions = true,
				},
			},
		},
	})

	lspconfig.clangd.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		cmd = {
			"clangd",
			"--offset-encoding=utf-16",
		},
	})

	lspconfig.bashls.setup({})

	lspconfig.texlab.setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

	lspconfig.gopls.setup({})

	lspconfig.html.setup({})

	lspconfig.cssls.setup({})

	lspconfig.biome.setup({})

	lspconfig.ansiblels.setup({})

	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")
	local ruff = require("efmls-configs.linters.ruff")
	--local autopep8 = require("efmls-configs.formatters.autopep8")
	local clang_tidy = require("efmls-configs.linters.clang_tidy")
	local clangformat = require("efmls-configs.formatters.clang_format")
	local shfmt = require("efmls-configs.formatters.shfmt")
	local shellcheck = require("efmls-configs.linters.shellcheck")
	local vale = require("efmls-configs.linters.vale")
	lspconfig.efm.setup({
		filetypes = {
			"lua",
			"python",
			"c",
			"cpp",
			"sh",
			"go",
			"tex",
			"latex",
			"cmake",
			"cpp",
			"html",
			"css",
			"js",
		},
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
			completion = true,
		},
		settings = {
			languages = {
				lua = { luacheck, stylua },
				python = { ruff }, --autopep8
				-- c = { clangformat, clang_tidy }, -- maybe cpplint will function better
				c = { clangformat, clang_tidy }, -- maybe cpplint will function better
				cpp = { clangformat, clang_tidy },
				sh = { shfmt, shellcheck },
				tex = { vale },
				latex = { vale },
				cmake = {},
			},
		},
	})
end

return {
	"neovim/nvim-lspconfig",
	config = config,
	lazy = false,
	dependencies = {
		"windwp/nvim-autopairs",
		"williamboman/mason.nvim",
		"creativenull/efmls-configs-nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp",
	},
}
