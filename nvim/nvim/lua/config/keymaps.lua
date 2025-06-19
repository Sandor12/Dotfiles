local keymap = vim.keymap

-- Pane Navigation
keymap.set("n", "<leader>h", "<C-w>h", opts) -- Navigate left
keymap.set("n", "<leader>j", "<C-w>j", opts) -- Navigate down
keymap.set("n", "<leader>k", "<C-w>k", opts) -- Navigate up
keymap.set("n", "<leader>l", "<C-w>l", opts) -- Navigate right

-- classic navigation
keymap.set("n", "<C-j>", "<C-d>", opts) -- Navigate down
keymap.set("n", "<C-k>", "<C-u>", opts) -- Navigate up

-- Directory Navigation nvimtree  Not used anymore
-- keymap.set("n", "<leader>m", ":NvimTreeFocus<CR>", { noremap = true, silent = true })
-- keymap.set("n", "<leader>f", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- Window Management
keymap.set("n", "<leader>sv", ":vsplit<CR>", opts) -- Split vertically
keymap.set("n", "<leader>sh", ":split<CR>", opts) -- Split horizontally

-- Trouble keymaps
keymap.set("n", "<leader>xx", function()
	require("trouble").toggle()
end)

-- Moving lines
keymap.set("n", "<A-j>", ":move .+1<CR>")
keymap.set("n", "<A-k>", ":move .-2<CR>")
keymap.set("x", "<A-j>", ":move '>+1<CR>gv")
keymap.set("x", "<A-k>", ":move '<-2<CR>gv")

-- Using vim as terminal
keymap.set("n", "<leader>t", ":split<CR>:resize 10<CR>:term<CR>i")
keymap.set("t", "<Esc>", "<C-\\><C-n>:q!<CR>")

-- Snippets moving
keymap.set("i", "<C-l>", function()
	local ls = require("luasnip")
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end)

-- Neogit
keymap.set("n", "<leader>g", ":Neogit<CR>")

-- Oil
keymap.set("n", "<leader>fd", "<CMD>Oil<CR>", { desc = "Open parent directory" })
keymap.set("n", "<leader>fp", "<CMD>Oil ~/Projects<CR>", { desc = "Open Projects directory" })
keymap.set("n", "<leader>fc", "<CMD>Oil ~/.config/nvim/<CR>", { desc = "Open Projects directory" })

-- Move to neorg index
keymap.set("n", "<leader>ni", "<CMD>edit ~/Bureau/orgfiles/refile.org<CR>")
keymap.set("n", "<leader>nn", "<CMD>Neorg workspace notes<CR>")
keymap.set("n", "<leader>nr", "<CMD>Neorg return<CR>")

-- Compile latex
keymap.set("n", "<leader>c", "<CMD>!tectonic -X compile " .. vim.fn.expand("%") .. "<CR>")

-- Generate doc
keymap.set("n", "<leader>nd", "<CMD>Neogen func<CR>", { desc = "Create docs" })
