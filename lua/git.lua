local function open_commit_explorer(hash)
    if not hash or hash == "" then return end

    local cmd = "git diff-tree --no-commit-id --name-only -r " .. hash
    local files = vim.fn.systemlist(cmd)
    if vim.v.shell_error ~= 0 or #files == 0 then return end

    vim.cmd("tabnew")
    local list_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(list_buf, 0, -1, false, files)

    vim.bo[list_buf].buftype = "nofile"
    vim.bo[list_buf].bufhidden = "hide"
    vim.bo[list_buf].swapfile = false
    vim.bo[list_buf].filetype = "gitcommit_files"

    vim.cmd("topleft 10split")
    vim.api.nvim_set_current_buf(list_buf)
    local list_win = vim.api.nvim_get_current_win()

    vim.keymap.set("n", "<CR>", function()
        local file = vim.api.nvim_get_current_line()
        if file == "" then return end

        local cur_tab = vim.api.nvim_get_current_tabpage()
        for _, w in ipairs(vim.api.nvim_tabpage_list_wins(cur_tab)) do
            if w ~= list_win and vim.api.nvim_win_is_valid(w) then
                pcall(vim.api.nvim_win_close, w, true)
            end
        end

        vim.cmd("botright split")
        vim.cmd("Gedit " .. hash .. ":" .. file)

        vim.cmd("vert Gdiffsplit! " .. hash .. "~1:" .. file)

        vim.api.nvim_set_current_win(list_win)
    end, { buffer = list_buf, silent = true })

    vim.keymap.set("n", "q", ":tabclose<CR>", { buffer = list_buf, silent = true })
end

local function git_commit_explorer()
    require("telescope.builtin").git_commits({
        attach_mappings = function(prompt_bufnr, map)
            local actions = require("telescope.actions")
            local action_state = require("telescope.actions.state")
            map("i", "<CR>", function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                open_commit_explorer(selection.value)
            end)
            return true
        end,
    })
end

vim.keymap.set("n", "<leader>gv", git_commit_explorer, { desc = "Git: Commit Explorer" })
vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { desc = 'Preview Hunk Popup' })
vim.api.nvim_create_user_command('GitsignsFocus', function()
    local gs = require('gitsigns')
    gs.toggle_numhl()
    gs.toggle_linehl()
    gs.toggle_word_diff()
end, { desc = 'Toggle Gitsigns number and line highlighting' })
vim.keymap.set('n', '<leader>gh', ':GitsignsFocus<CR>', { silent = true, desc = 'Toggle Git Highlighting' })
