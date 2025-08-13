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
    "jay-babu/mason-nvim-dap.nvim",
    "neovim/nvim-lspconfig"
  },
  config = function()
    -- https://github.com/mfussenegger/nvim-dap
    require("mason-nvim-dap").setup({
      ensure_installed = {},
      automatic_installation = false,
      handlers = {
        function(config)
          require("mason-nvim-dap").default_setup(config)
        end,
        php = function(config)
          set_local_adapter(config, "php-debug-adapter")
          config.configurations.php = {
            {
              type = 'php',
              request = 'launch',
              name = 'Listen for xdebug',
              port = '9003',
              log = true,
            },
          }
          require('mason-nvim-dap').default_setup(config)
        end,
        delve = function(config)
          table.insert(config.configurations, 1, {
            args = function() return vim.split(vim.fn.input("args> "), " ") end,
            type = "delve",
            name = "file",
            request = "launch",
            program = "${file}",
            outputMode = "remote",
          })

          table.insert(config.configurations, 1, {
            args = function() return vim.split(vim.fn.input("args> "), " ") end,
            type = "delve",
            name = "file args",
            request = "launch",
            program = "${file}",
            outputMode = "remote",
          })
          require('mason-nvim-dap').default_setup(config)
        end
      }
    })

    local dap, dapui = require("dap"), require("dapui")

    dapui.setup()

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
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
  end
}
-- vim: ts=2 sts=2 sw=2 et
