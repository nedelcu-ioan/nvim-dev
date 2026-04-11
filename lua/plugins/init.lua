vim.pack.add({
    -- prereq
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-neotest/nvim-nio" },

    -- navigation ui
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/folke/flash.nvim" },
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },

    -- lsp / refactoring
    { src = "https://github.com/wansmer/treesj" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/williamboman/mason.nvim" },
    { src = "https://github.com/williamboman/mason-lspconfig.nvim" },
    { src = "https://github.com/echasnovski/mini.surround" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter",  run = ":TSUpdate" },

    -- git integration
    { src = "https://github.com/tpope/vim-fugitive"},
    { src = "https://github.com/lewis6991/gitsigns.nvim"},

    -- snippets
    { src = "https://github.com/L3MON4D3/LuaSnip",                 tag = "v2.*",     run = "make install_jsregexp" },

    -- debugging
    { src = "https://github.com/mfussenegger/nvim-dap" },
    { src = "https://github.com/rcarriga/nvim-dap-ui" },
    { src = "https://github.com/jay-babu/mason-nvim-dap.nvim" },

    -- Add these to your lsp / refactoring section
    { src = "https://github.com/hrsh7th/nvim-cmp" },
    { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
    { src = "https://github.com/saadparwaiz1/cmp_luasnip" }
})
