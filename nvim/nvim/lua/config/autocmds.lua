-- auto-format on save
local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingGroup", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	group = lsp_fmt_group,
	callback = function(ctx)
		local efm = vim.lsp.get_clients({ name = "efm" })

		if vim.tbl_isempty(efm) or vim.fs.root(ctx.buf, { "index.norg" }) then
			return
		end

		vim.lsp.buf.format({ name = "efm", async = true })
	end,
})

-- highlight on yank
local highlight_yank_group = vim.api.nvim_create_augroup("HighlightYankGroup", {})
vim.api.nvim_create_autocmd("TextYankPost", {
	group = highlight_yank_group,
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- cd to root on enter
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function(ctx)
		local root =
			vim.fs.root(ctx.buf, { ".git", "Makefile", "CMakeLists.txt", "venv", ".venv", "index.norg", ".ignore" })
		if root then
			vim.cmd("cd " .. root)
		end
	end,
})

-- set concellevel to 2 in neorg
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function(ctx)
		local neorg = vim.fs.root(ctx.buf, { "index.norg", "refile.org" })
		if neorg then
			vim.opt.conceallevel = 3
		else
			vim.opt.conceallevel = 0
		end
	end,
})
