local COMPILE_COMMAND_PATTERN = "g++ -std=c++23 -DLOCAL -Wall -o %s %s -g && ./%s"

local function compile_and_run_current_cpp_file()
    if vim.bo.filetype == "cpp" then
        vim.cmd("w")
        local filename = vim.fn.expand("%")
        local output = vim.fn.expand("%:r")
        local cmd = string.format(COMPILE_COMMAND_PATTERN, output, filename, output)
        vim.cmd("terminal bash -c '" .. cmd .. "; echo; read -p \"--- Finished --- Press key...\" -n1'")
    end
end

vim.keymap.set("n", "<F9>", compile_and_run_current_cpp_file, { desc = "Compile and run current cpp file", silent = true })
