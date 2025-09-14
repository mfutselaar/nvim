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
    "neovim/nvim-lspconfig"
  },
  config = function()
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
