require("packer").startup(function(use)
    -- Packer can manage itself
    use 'NoahTheDuke/vim-just'
    use 'wbthomason/packer.nvim'
    use 'glepnir/dashboard-nvim'
    use 'nvim-tree/nvim-tree.lua'
    use 'alaviss/nim.nvim'
    use 'jiangmiao/auto-pairs'
    use 'Shougo/neocomplcache.vim'
    use 'farmergreg/vim-lastplace'
    use 'ctrlpvim/ctrlp.vim'
    use 'vimwiki/vimwiki'
    use 'bob16795/markup.vim'
    use 'vim-scripts/LargeFile'
    use 'dradtke/VIP'
    use 'Shougo/neocomplcache'
    use 'neovim/nvim-lspconfig'
    use { 'dracula/vim', as = 'dracula' }
    use 'noahfrederick/vim-noctu'
    use 'terryma/vim-multiple-cursors'
    use 'ojroques/vim-scrollstatus'
    use 'idbrii/vim-unityengine'
    use 'OmniSharp/omnisharp-vim'
    use 'nanotee/zoxide.vim'
    use 'wakatime/vim-wakatime'
    use 'nvim-lua/plenary.nvim'
    use 'folke/todo-comments.nvim'
    use 'onsails/lspkind.nvim'
    use 'sainnhe/everforest'
    use 'arcticicestudio/nord-vim'
    use 'airblade/vim-gitgutter'

    use 'vim-test/vim-test'
    use 'vim-scripts/OmniCppComplete'
    use 'tpope/vim-fugitive'
    use 'nvim-tree/nvim-web-devicons'

    use 'nvim-telescope/telescope.nvim'
    use 'romgrk/barbar.nvim'

    use 'pwntester/octo.nvim'
    use 'andweeb/presence.nvim'
    use 'junegunn/goyo.vim'
    use { 'yoshio15/vim-trello', branch = 'main' }
    use 'MarcWeber/vim-addon-mw-utils'
    use 'tomtom/tlib_vim'
    use 'ziglang/zig.vim'
    use 'ahmedkhalf/project.nvim'
    use 'nvim-lua/lsp-status.nvim'
    use 'brenoprata10/nvim-highlight-colors'
    use "akinsho/toggleterm.nvim"
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use 'sbdchd/neoformat'
    use 'michaelrommel/nvim-silicon'
    use 'plasticboy/vim-markdown'
end)
