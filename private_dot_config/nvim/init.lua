local opt = vim.opt
local map = vim.keymap.set
local g = vim.g
local cmd = vim.cmd
local lsp = vim.lsp

opt.tabstop = 2
opt.shiftwidth = 2
opt.smartindent = true
opt.wrap = false
opt.number = true
opt.relativenumber = true
opt.swapfile = false
opt.termguicolors = true
opt.undofile = true
opt.incsearch = true
opt.signcolumn = 'yes'
opt.mouse = 'a'
opt.clipboard = 'unnamedplus'
opt.fillchars = { eob = ' ' }
opt.statusline = ' '
opt.winbar = ' '
opt.cursorline = true
opt.cursorlineopt = "screenline"
opt.scrolloff = 3
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.completeopt = 'menuone,noselect,popup,fuzzy'
opt.complete = '.,w,b,u,o'

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.undotree_WindowLayout = 3
g.undotree_SetFocusWhenToggle = 1
g.undotree_SplitWidth = 45
g.mapleader = ' '
g.clipboard = 'osc52'

vim.pack.add({
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
  { src = 'https://github.com/nvim-tree/nvim-tree.lua' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  { src = 'https://github.com/romgrk/barbar.nvim' },
  { src = 'https://github.com/mbbill/undotree' },
  { src = 'https://github.com/nvim-mini/mini.completion' },
  { src = 'https://github.com/nvim-mini/mini.icons' },
  { src = 'https://github.com/nvim-mini/mini.clue' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/mason-org/mason.nvim' },
})

require('nvim-treesitter.configs').setup({
  auto_install = true,
  highlight = { enable = true }
})
require('nvim-tree').setup({
  actions = { open_file = { quit_on_open = true } },
  disable_netrw = true,
  update_focused_file = { enable = true },
  renderer = { group_empty = true },
})
require('barbar').setup()
require('mini.completion').setup()
require('mini.icons').setup()
local miniclue = require('mini.clue')
miniclue.setup({
  triggers = {
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },
    { mode = 'i', keys = '<C-x>' },
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },
    { mode = 'n', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'x', keys = "'" },
    { mode = 'x', keys = '`' },
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },
    { mode = 'n', keys = '<C-w>' },
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },
  },

  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
		{ mode = 'n', keys = '<Leader>cc', desc = 'change colorscheme' },
		{ mode = 'n', keys = '<Leader>d', desc = 'diagnostic' },
		{ mode = 'n', keys = '<Leader>e', desc = 'open filetree' },
		{ mode = 'n', keys = '<Leader>f', desc = 'format code with lsp' },
		{ mode = 'n', keys = '<Leader>l', desc = 'lint jsonnet code' },
		{ mode = 'n', keys = '<Leader>o', desc = 'nvim source current file' },
		{ mode = 'n', keys = '<Leader>s', desc = 'fast replace under cursor' },
		{ mode = 'n', keys = '<Leader>u', desc = 'open undotree' },
		{ mode = 'n', keys = '<Leader>w', desc = 'close buffer' },
		{ mode = 'n', keys = '<Leader>x', desc = 'make current file +x' },
		{ mode = 'n', keys = '<Leader>y', desc = 'yank filename into +' },
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
})
require('mason').setup()
require'lspconfig'.rust_analyzer.setup({})
MiniIcons.tweak_lsp_kind()

lsp.config('elixirls', {
  cmd = { '/usr/bin/elixir-ls' };
})

lsp.enable('elixirls', 'rust_analyzer')

map('n', '<leader>cc', ':colorscheme wildcharm<CR>')
map('n', '<leader>d', vim.diagnostic.open_float, { noremap = true, silent = true })
map('n', '<leader>e', ':NvimTreeToggle<CR>')
map('n', '<leader>f', vim.lsp.buf.format, { noremap = true, silent = true })
map('n', '<leader>l', ':!tk lint %<CR>')
map('n', '<leader>o', ':update<CR>:source<CR>')
map('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
map('n', '<leader>u', ':UndotreeToggle<CR>')
map('n', '<leader>w', ':BufferClose<CR>')
map('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })
map('n', '<leader>y', function() vim.fn.setreg('+', vim.fn.expand('%:p')) end)
map('n', '<Tab>', ':bnext<CR>')
map('i', '<Tab>', '  ')
map('n', '<S-Tab>', ':bprevious<CR>')
map('i', '<S-Tab>', '<BS>')
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

cmd('colorscheme lunaperche')
cmd('hi statusline guibg=NONE')

