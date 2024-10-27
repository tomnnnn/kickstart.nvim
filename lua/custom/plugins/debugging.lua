local mason_dap = {
  'jay-babu/mason-nvim-dap.nvim',
  event = 'VeryLazy',
  dependencies = {
    'williamboman/mason.nvim',
    'mfussenegger/nvim-dap',
  },
  opts = {
    handlers = {},
  },
}

local dap_plugin = {
  'mfussenegger/nvim-dap',
  config = function()
    local dap = require 'dap'

    vim.keymap.set('n', '<Leader>db', dap.toggle_breakpoint, { desc = 'Toggle breakpoint' })
    vim.keymap.set('n', '<Leader>dc', dap.clear_breakpoints, { desc = 'Clear breakpoints' })
    vim.keymap.set('n', '<Leader>dr', dap.continue, { desc = 'Run debugger' })
    vim.keymap.set('n', '<F8>', dap.continue)
    vim.keymap.set('n', '<F9>', dap.step_over)
    vim.keymap.set('n', '<F10>', dap.step_into)
    vim.keymap.set('n', '<F11>', dap.step_out)
  end,
}

local dap_lldb = {
  'julianolf/nvim-dap-lldb',
  config = function()
    require('dap-lldb').opts = { codelldb_path = require('mason-registry').get_package('codelldb'):get_install_path() }

    require('dap-lldb').setup()
  end;
  dependencies = { 'mfussenegger/nvim-dap' },
}

local dap_ui = {
  'rcarriga/nvim-dap-ui',
  event = 'VeryLazy',
  dependencies = {
    'mfussenegger/nvim-dap',
    'nvim-neotest/nvim-nio',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    dapui.setup()

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.after.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.after.event_exited.dapui_config = function()
      dapui.close()
    end
  end,
}

return {
  mason_dap,
  dap_plugin,
  dap_ui,
  dap_lldb,
}
