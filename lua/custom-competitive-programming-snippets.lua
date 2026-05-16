local status_ok, ls = pcall(require, "luasnip")

if not status_ok then
    print("LuaSnip not found. It should be available after the next restart.")
else
    local p = ls.parser.parse_snippet
    local registered_snippets = {}

    local snippet_dir = vim.fn.expand("~/.config/nvim-ned/snippets/")

    if vim.fn.isdirectory(snippet_dir) == 1 then
        local files = vim.fn.readdir(snippet_dir)
        for _, file in ipairs(files) do
            if file:match("%.cpp$") then
                local filepath = snippet_dir .. "/" .. file
                local f = io.open(filepath, "r")
                if f then
                    local content = f:read("*all")
                    f:close()
                    local trigger = file:gsub("%.cpp$", "")
                    table.insert(registered_snippets, p(trigger, content))
                end
            end
        end
    end

    ls.add_snippets("cpp", registered_snippets)

    vim.keymap.set({"i", "s"}, "<C-K>", function()
        if ls.expand_or_jumpable() then ls.expand_or_jump() end
    end)
    vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
    vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})
end
