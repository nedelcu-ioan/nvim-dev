local u = require('core.utils')

local function compile_and_run_current_cpp_file()
    if vim.bo.filetype == "cpp" then
        vim.cmd("w")
        local filename = vim.fn.expand("%")
        local output = vim.fn.expand("%:r")
        local cmd = string.format("g++ -std=c++23 -Wall -o %s %s -g && ./%s", output, filename, output)
        vim.cmd("terminal bash -c '" .. cmd .. "; echo; read -p \"--- Finished --- Press key...\" -n1'")
    end
end

u.map("n", "<F9>", compile_and_run_current_cpp_file, "Compile and run current cpp file")
