local opt = vim.opt
local map = vim.keymap.set
local g = vim.g
local cmd = vim.cmd

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
opt.colorcolumn = '80'
opt.fillchars = { eob = ' ' }
opt.statusline = ' '
opt.winbar = ' '
opt.cursorline = true
opt.cursorlineopt = "screenline"
opt.scrolloff = 3
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.undotree_WindowLayout = 3
g.undotree_SetFocusWhenToggle = 1
g.undotree_SplitWidth = 45
g.mapleader = ' '

vim.pack.add({
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
  { src = 'https://github.com/nvim-tree/nvim-tree.lua' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  { src = 'https://github.com/romgrk/barbar.nvim' },
  { src = 'https://github.com/mbbill/undotree' },
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

map('n', '<leader>o', ':update<CR>:source<CR>')
map('n', '<leader>e', ':NvimTreeToggle<CR>')
map('n', '<leader>f', ':NvimTreeFocus<CR>')
map('n', '<leader>u', ':UndotreeToggle<CR>')
map('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
map('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })
map('n', '<leader>cc', ':colorscheme wildcharm<CR>')
map('n', '<Tab>', ':bnext<CR>')
map('i', '<Tab>', '  ')
map('n', '<S-Tab>', ':bprevious<CR>')
map('i', '<S-Tab>', '<BS>')
map('n', '<leader>w', ':BufferClose<CR>')
map('n', '<space>y', function() vim.fn.setreg('+', vim.fn.expand('%:p')) end)
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

cmd('colorscheme lunaperche')
cmd('hi statusline guibg=NONE')

