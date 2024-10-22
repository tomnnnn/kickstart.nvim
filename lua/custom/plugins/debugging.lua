local run_dap_with_config = function()
  local dap = require("dap")
  local ft = vim.bo.filetype

  if ft == "" then
    print("Missing filetype, cannot determine dap config")
    return
  end

  local configs = dap.configurations[ft]
  if configs == nil then
    print("Filetype \"" .. ft .. "\" has no dap configs")
    return
  end

  local mConfig = nil
  vim.ui.select(
    configs,
    {
      prompt = "Select config to run: ",
      format_item = function(config)
        return config.name
      end
    },
    function(config)
      mConfig = config
    end
  )

  -- redraw to make selector disappear
  vim.api.nvim_command("redraw")

  if mConfig == nil then
    return
  end

  vim.ui.input(
    {
      prompt = "Program arguments: ",
    },
    function(input)
      if input == nil then
        return
      end
      local args = vim.split(input, ' ')
      mConfig.args = args
      dap.run(mConfig)
    end
  )
end

local mason_dap = {
  "jay-babu/mason-nvim-dap.nvim",
  event = "VeryLazy",
  dependencies = {
    "williamboman/mason.nvim",
    "mfussenegger/nvim-dap",
  },
  opts = {
    handlers = {},
  }
}

local dap_plugin = {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require("dap")

    vim.keymap.set('n', '<Leader>db', dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
    vim.keymap.set('n', '<Leader>dc', dap.clear_breakpoints, { desc = "Clear breakpoints" })
    vim.keymap.set('n', '<Leader>dr', dap.continue, { desc = "Run debugger" })
    vim.keymap.set('n', '<F8>', dap.continue)
    vim.keymap.set('n', '<F9>', dap.step_over)
    vim.keymap.set('n', '<F10>', dap.step_into)
    vim.keymap.set('n', '<F11>', dap.step_out)

    dap.adapters.php = {
      type = "executable",
      command = "node",
      args = { os.getenv("HOME") .. "/vscode-php-debug/out/phpDebug.js" }
    }

    dap.configurations = {
      {
        php = {
            type = "php",
            request = "launch",
            name = "Listen for Xdebug",
            port = 9003
        },
    }
  }
  end,
}

local cfg = {
   configurations = {
      -- C lang configurations
      cpp = {
         {
            name = "Crazyyyy debugger",
            type = "lldb",
            request = "launch",
            cwd = "..",
            program = "../imapcl"
         },
      },
   },
}

local dap_lldb = {
   "julianolf/nvim-dap-lldb",
   config = function()
      local dap_lldb = require("dap-lldb")
      local mason_registry = require("mason-registry")
      local codelldb = mason_registry.get_package("codelldb")
      dap_lldb.opts = { codelldb_path = codelldb:get_install_path()}
      require("dap-lldb").setup(cfg)
   end,
   dependencies = { "mfussenegger/nvim-dap" },
}

local dap_ui = {
  "rcarriga/nvim-dap-ui",
  event = "VeryLazy",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio"
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

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
  dap_lldb
}
