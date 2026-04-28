return {
    'neovim/nvim-lspconfig',
    dependencies = {
        { 'williamboman/mason.nvim',          config = true }, -- config = true calls .setup()
        { 'williamboman/mason-lspconfig.nvim' },
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'L3MON4D3/LuaSnip' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-nvim-lua' },
        { 'rafamadriz/friendly-snippets' },
        { 'saadparwaiz1/cmp_luasnip' }
    },
    config = function()
        -- Move your lsp.lua logic here or keep requiring it
        require('mlgfroccs.lsp')
    end
}
