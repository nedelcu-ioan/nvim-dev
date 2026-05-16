vim.keymap.set('n', '<leader>y', '<cmd>%y+<CR>', { desc = 'Yank entire buffer to clipboard' })
vim.keymap.set('n', '<leader>m', require('treesj').toggle,{ desc = "Split/Join blocks" })
vim.keymap.set("v", "<", "<gv", { desc = "Indent Left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent Right" })

vim.keymap.set('n', '<M-Up>', ':resize +2<CR>', { desc = 'Resize split up' })
vim.keymap.set('n', '<M-Down>', ':resize -2<CR>', { desc = 'Resize split down' })
vim.keymap.set('n', '<M-Left>', ':vertical resize -2<CR>', { desc = 'Resize split left' })
vim.keymap.set('n', '<M-Right>', ':vertical resize +2<CR>', { desc = 'Resize split right' })

local ls = require("luasnip")
vim.keymap.set({"i", "s"}, "<C-K>", function()
    if ls.expand_or_jumpable() then ls.expand_or_jump() end
end, { desc = "Snippet Expand/Jump" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact", "javascript" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end,
})

vim.api.nvim_create_user_command('Format', function(args)
    vim.lsp.buf.format({ range = args.range > 0 and { ["start"] = { args.line1 - 1, 0 }, ["end"] = { args.line2, 0 } } or
    nil })
end, { range = true, desc = "Format Selection or Buffer" })
