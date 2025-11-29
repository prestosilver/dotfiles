vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require 'prestosilver'

require("octo").setup()
require("todo-comments").setup()

vim.api.nvim_set_var('s:using_snippets', 1)

vim.cmd([[
syntax enable
syntax on
filetype plugin indent on

autocmd BufWritePre * lua vim.lsp.buf.format()

augroup dirchange
    autocmd!
    autocmd DirChanged * let &titlestring=v:event['cwd']
augroup END

nnoremap <S-ScrollWheelUp> <ScrollWheelLeft>
nnoremap <S-2-ScrollWheelUp> <2-ScrollWheelLeft>
nnoremap <S-3-ScrollWheelUp> <3-ScrollWheelLeft>
nnoremap <S-4-ScrollWheelUp> <4-ScrollWheelLeft>
nnoremap <S-ScrollWheelDown> <ScrollWheelRight>
nnoremap <S-2-ScrollWheelDown> <2-ScrollWheelRight>
nnoremap <S-3-ScrollWheelDown> <3-ScrollWheelRight>
nnoremap <S-4-ScrollWheelDown> <4-ScrollWheelRight>

inoremap <S-ScrollWheelUp> <ScrollWheelLeft>
inoremap <S-2-ScrollWheelUp> <2-ScrollWheelLeft>
inoremap <S-3-ScrollWheelUp> <3-ScrollWheelLeft>
inoremap <S-4-ScrollWheelUp> <4-ScrollWheelLeft>
inoremap <S-ScrollWheelDown> <ScrollWheelRight>
inoremap <S-2-ScrollWheelDown> <2-ScrollWheelRight>
inoremap <S-3-ScrollWheelDown> <3-ScrollWheelRight>
inoremap <S-4-ScrollWheelDown> <4-ScrollWheelRight>

inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
]])

-- line numbers
vim.opt.number = true

vim.opt.completeopt = "menuone,noinsert,noselect"

-- sign
vim.opt.signcolumn = "yes"

-- title
vim.opt.title = true

-- zig config
vim.g.zig_fmt_autosave = true

-- compat stuff idk
vim.opt.compatible = false

-- indentation
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.wrap = false

-- undo
vim.opt.undofile = true
vim.opt.undodir = "/home/john/.config/nvim/undo"

-- disable folding bc im smart
vim.opt.foldenable = false
vim.opt.numberwidth = 2

-- mouse
vim.opt.mouse = 'a'

-- font
vim.opt.syntax = "on"

-- styiling
vim.opt.fillchars = "vert:▎"

vim.g.neoformat_enabled_nim = { "nph" }

-- bamba
--vim.api.nvim_create_autocmd('BufRead,BufNewFile', {
--    pattern = { '*.bam' },
--    callback = function()
--        vim.opt.syntax = 'bamba'
--    end,
--})
