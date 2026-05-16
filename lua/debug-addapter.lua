local dap = require("dap")
local dapui = require("dapui")

require("mason-nvim-dap").setup({
  ensure_installed = { "python", "cpptools" },
  automatic_installation = true,
  handlers = {
    function(config)
      require('mason-nvim-dap').default_setup(config)
    end,

    cppdbg = function(config)
      local mason_path = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7"

      if vim.loop.os_uname().sysname == "Windows_NT" then
        mason_path = mason_path .. ".exe"
      end

      config.adapters = {
        type = 'executable',
        command = mason_path,
        id = 'cppdbg',
      }
      require('mason-nvim-dap').default_setup(config)
    end,
  },
})

dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg", 
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
  },
}

dap.configurations.c = dap.configurations.cpp

dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = "Launch file",
    program = "${file}",
    pythonPath = function() return 'python3' end,
  },
}

local keymap = vim.keymap.set

keymap('n', '<F5>', function() require('dap').continue() end, { desc = "Debug: Start/Continue" })
keymap('n', '<F10>', function() require('dap').step_over() end, { desc = "Debug: Step Over" })
keymap('n', '<F11>', function() require('dap').step_into() end, { desc = "Debug: Step Into" })
keymap('n', '<F12>', function() require('dap').step_out() end, { desc = "Debug: Step Out" })
keymap('n', '<leader>b', function() require('dap').toggle_breakpoint() end, { desc = "Debug: Toggle Breakpoint" })
keymap('n', '<leader>B', function() 
    require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) 
end, { desc = "Debug: Set Conditional Breakpoint" })
keymap('n', '<leader>du', function() require('dapui').toggle() end, { desc = "Debug: Toggle UI" })
keymap('n', '<leader>dx', function() require('dap').terminate() end, { desc = "Debug: Terminate" })
