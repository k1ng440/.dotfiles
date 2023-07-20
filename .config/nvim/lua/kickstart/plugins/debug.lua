-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  {
    'm      keys = {
          { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
          { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
        },
        opts = {},
        config = function(_, opts)
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.setup(opts)
          dap.listeners.after.event_initialized["dapui_config"] = dapui.open
          dap.listeners.before.event_terminated["dapui_config"] = dapui.close
          dap.listeners.before.event_exited["dapui_config"] = dapui.close
        end,
      },
      {
        "jay-babu/mason-nvim-dap.nvim",
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
          automatic_installation = true,
          handlers = {},
          ensure_installed = {
            'go',
          },
        }
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
      {
        "folke/which-key.nvim",
        optional = true,
        opts = {
          defaults = {
            ["<leader>d"] = { name = "+debug" },
            ["<leader>da"] = { name = "+adapters" },
          },
        },
      },
    },
    -- stylua: ignore
    keys = {
      {
        "<leader>dB",
        function() require("dap").set_breakpoint(vim.fn.input('[B]reakpoint condition: ')) end,
        desc = "Breakpoint Condition"
      },
      {
        "<leader>db",
        function() require("dap").toggle_breakpoint() end,
        desc = "Toggle [B]reakpoint"
      },
      { "<leader>dc", function() require("dap").continue() end,         desc = "[C]ontinue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end,    desc = "Run to [C]ursor" },
      { "<leader>dg", function() require("dap").goto_() end,            desc = "[G]o to line (no execute)" },
      { "<leader>di", function() require("dap").step_into() end,        desc = "Step [I]nto" },
      { "<leader>dj", function() require("dap").down() end,             desc = "Down" },
      { "<leader>dk", function() require("dap").up() end,               desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end,         desc = "Run [L]ast" },
      { "<leader>do", function() require("dap").step_out() end,         desc = "Step [O]ut" },
      { "<leader>dO", function() require("dap").step_over() end,        desc = "Step [O]ver" },
      { "<leader>dp", function() require("dap").pause() end,            desc = "[P]ause" },
      { "<leader>dr", function() require("dap").repl.toggle() end,      desc = "Toggle [R]EPL" },
      { "<leader>ds", function() require("dap").session() end,          desc = "[S]ession" },
      { "<leader>dt", function() require("dap").terminate() end,        desc = "[T]erminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "[W]idgets" },
    },
    opts = {},
    config = function()
      local Config = require('custom.config')
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
      for name, sign in pairs(Config.icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end
    end,
  },
  ---- Adapters
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "jbyuki/one-small-step-for-vimkind",
        -- stylua: ignore
        keys = {
          { "<leader>daL", function() require("osv").launch({ port = 8086 }) end, desc = "Adapter Lua Server" },
          { "<leader>dal", function() require("osv").run_this() end,              desc = "Adapter Lua" },
        },
        config = function()
          local dap = require("dap")
          dap.adapters.nlua = function(callback, config)
            callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
          end
          dap.configurations.lua = {
            {
              type = "nlua",
              request = "attach",
              name = "Attach to running Neovim instance",
            },
          }
        end,
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "gomodifytags", "impl", "gofumpt", "goimports-reviser", "delve" })
        end,
      },
    },
  },
}
