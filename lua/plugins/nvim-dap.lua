return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
      "theHamsta/nvim-dap-virtual-text",
      "jay-babu/mason-nvim-dap.nvim",
    },
    keys = {
      -- Leader keymaps
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step out" },
      { "<leader>ds", function() require("dap").step_over() end, desc = "Step over" },
      { "<leader>df", function() require("dap").continue() end, desc = "Start debugging" },
      { "<leader>dq", function() require("dap").terminate() end, desc = "Stop debugging" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
      
      -- F key keymaps
      { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
      { "<F5>", function() require("dap").continue() end, desc = "Continue" },
      { "<F1>", function() require("dap").step_into() end, desc = "Step into" },
      { "<F2>", function() require("dap").step_over() end, desc = "Step over" },
      { "<F3>", function() require("dap").step_out() end, desc = "Step out" },
      { "<F8>", function() require("dap").terminate() end, desc = "Stop debugging" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local dap_python = require("dap-python")

      require("dapui").setup({})
      require("nvim-dap-virtual-text").setup({
        commented = true,
      })

      require("mason-nvim-dap").setup({
        automatic_installation = true,
        handlers = {},
        ensure_installed = {
          "delve",
          "python",
          "codelldb",
        },
      })

      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"

      dap_python.setup(path)

      vim.fn.sign_define("DapBreakpoint", {
        text = "",
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
      })

      vim.fn.sign_define("DapBreakpointRejected", {
        text = "",
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
      })

      vim.fn.sign_define("DapStopped", {
        text = "",
        texthl = "DiagnosticSignWarn",
        linehl = "Visual",
        numhl = "DiagnosticSignWarn",
      })

      -- Automatically open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = dapui.open
      dap.listeners.before.event_terminated["dapui_config"] = dapui.close
      dap.listeners.before.event_exited["dapui_config"] = dapui.close
    end,
  },
}
