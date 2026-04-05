local u = require('core.utils')

u.map('n', '<leader>y', '<cmd>%y+<CR>', 'Yank entire buffer to clipboard')
u.map('n', '<leader>m', require('treesj').toggle, "Split/Join blocks")
u.map("v", "<", "<gv", "Indent Left")
u.map("v", ">", ">gv", "Indent Right")

vim.keymap.set('n', '<M-Up>', ':resize +2<CR>', { desc = 'Resize split up' })
vim.keymap.set('n', '<M-Down>', ':resize -2<CR>', { desc = 'Resize split down' })
vim.keymap.set('n', '<M-Left>', ':vertical resize -2<CR>', { desc = 'Resize split left' })
vim.keymap.set('n', '<M-Right>', ':vertical resize +2<CR>', { desc = 'Resize split right' })

local ls = require("luasnip")
u.map({"i", "s"}, "<C-K>", function()
    if ls.expand_or_jumpable() then ls.expand_or_jump() end
end, "Snippet Expand/Jump")

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
