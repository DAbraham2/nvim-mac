-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)


return require('lazy').setup({
    install = { colorscheme = { "habamax" } },
    checker = { enabled = true },
    spec = {
        {
            'nvim-telescope/telescope.nvim', --tag = '0.1.8',
            branch = 'master',
            lazy = false,
            requires = { { 'nvim-lua/plenary.nvim' } }
        },

        {
            'rose-pine/neovim',
            as = 'rose-pine',
            config = function()
                vim.cmd('colorscheme rose-pine')
            end
        },
        {
            "vhyrro/luarocks.nvim",
            priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
            config = true,
        },
        { 'ThePrimeagen/vim-be-good' },
        { 'nvim-treesitter/nvim-treesitter',          lazy = false,                                                                                                   build = ':TSUpdate' },
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install' },
        { "nvim-treesitter/nvim-treesitter-context" },
        { 'mbbill/undotree' },
        {
            'theprimeagen/harpoon',
            branch = "harpoon2",
            dependencies = { "nvim-lua/plenary.nvim" }
        },
        { 'tpope/vim-fugitive' },
        {
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v4.x',
            dependencies = {
                { 'williamboman/mason.nvim' },
                { 'williamboman/mason-lspconfig.nvim' },

                -- LSP Support
                { 'neovim/nvim-lspconfig' },
                -- Autocompletion
                { 'hrsh7th/nvim-cmp' },
                { 'hrsh7th/cmp-nvim-lsp' },
                { 'L3MON4D3/LuaSnip' },
                { 'hrsh7th/cmp-path' },
                { 'hrsh7th/cmp-buffer' },
                { 'hrsh7th/cmp-nvim-lua' },
                { 'rafamadriz/friendly-snippets' },
                { 'saadparwaiz1/cmp_luasnip' }
            }
        },
        { 'mfussenegger/nvim-dap' },
        { 'mfussenegger/nvim-dap-python' },
        { 'leoluz/nvim-dap-go' },
        { 'ellisonleao/dotenv.nvim' },
    },
})
