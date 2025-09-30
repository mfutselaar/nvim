local bin_dir = vim.env.HOME .. "/.local/share/nvim/mason/bin/"

local set_local_adapter = function(config, command, args)
  config.adapters = {
    type = "executable",
    command = bin_dir .. command,
    args = args or {}
  }
end

return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    "neovim/nvim-lspconfig",

    "leoluz/nvim-dap-go"
  },
  config = function()
    local dap, dapui = require("dap"), require("dapui")

    dapui.setup()

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end

    vim.fn.sign_define('DapStopped', { text = '', texthl = 'DiffChange', linehl = 'Visual', numhl = 'DiffChange' })

    vim.fn.sign_define('DapBreakpoint', {
      text = '⬤',
      texthl = 'ErrorMsg',
      linehl = '',
      numhl = ''
    })

    vim.fn.sign_define('DapBreakpointCondition', {
      text = '',
      texthl = 'WarningMsg',
      linehl = '',
      numhl = ''
    })

    -- https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation

    -- golang/delve
    require("dap-go").setup()

    -- php
    dap.adapters.php = {
      type = 'executable',
      command = 'node',
      args = { vim.fn.expand("$HOME/.local/share/vscode-php-debug/out/phpDebug.js") }
    }

    dap.configurations.php = {
      {
        type = 'php',
        request = 'launch',
        name = 'Listen for Xdebug',
        port = 9003
      }
    }

    -- .net core
    dap.adapters.coreclr = {
      type = 'executable',
      command = '/usr/bin/netcoredbg',
      args = { '--interpreter=vscode' }
    }

    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
          return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end,
      },
    }
  end
}
-- vim: ts=2 sts=2 sw=2 et
