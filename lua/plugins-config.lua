require("oil").setup()
require("flash").setup()
require("mini.surround").setup()
require("telescope").setup({
    defaults = {
        layout_strategy = 'bottom_pane',
        layout_config = { height = 0.4 },
        border = true,
    }
})
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "clangd", "pyright", "ts_ls", "jdtls" }
})
require("treesj").setup({ max_join_length = 2048 })
require("gitsigns").setup({
    preview_config = {
        border = 'none',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
    },
    signs = {
        add          = { text = '+' },
        change       = { text = '~' },
        delete       = { text = '-' },
        topdelete    = { text = '^' },
        changedelete = { text = '!' },
        untracked    = { text = '?' },
    },
    signs_staged = {
        add          = { text = '+' },
        change       = { text = '~' },
        delete       = { text = '-' },
        topdelete    = { text = '^' },
        changedelete = { text = '!' },
        untracked    = { text = '?' },
    },
})
