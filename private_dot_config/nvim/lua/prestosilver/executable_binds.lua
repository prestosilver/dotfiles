local map = vim.api.nvim_set_keymap

local options = { noremap = true }

-- leader key
vim.g.mapleader = " "

map('n', '<leader>gg', '<cmd>Git<cr>', options)
map('n', '<leader>gb', '<cmd>Git blame<cr>', options)

map('n', '<leader>tp', ':Telescope projects<cr>', options)
map('n', '<leader>tf', ':Telescope fd<cr>', options)
map('n', '<leader>td', ':TodoTelescope<cr>', options)

map('n', '<leader>rr', '<cmd>lua ReloadConfig()<cr>', options)
map('n', '<leader>n', ':NvimTreeToggle<cr>', options)
map('n', '<leader>t', ':ToggleTerm<cr>', options)
map('n', '<leader>mf', ':Neoformat<cr>', options)
