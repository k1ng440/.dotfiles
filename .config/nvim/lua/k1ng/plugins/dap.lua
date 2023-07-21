return {
  "mfussenegger/nvim-dap",

  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      keys = {
        { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
        { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
      },
      opts = {},
      config = function(_, opts)
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup(opts)
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close({})
        end
      end,
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
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = "mason.nvim",
      cmd = { "DapInstall", "DapUninstall" },
      opts = {
        automatic_installation = true,
        handlers = {},
        ensure_installed = {
          'delve',
        },
      },
    },
  },

  -- stylua: ignore
  keys = {
    {
      "<leader>dB",
      function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
      desc = "Breakpoint Condition"
    },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle [B]reakpoint" },
    { "<leader>dc", function() require("dap").continue() end,          desc = "[C]ontinue" },
    { "<leader>dC", function() require("dap").run_to_cursor() end,     desc = "Run to [C]ursor" },
    { "<leader>dg", function() require("dap").goto_() end,             desc = "[G]o to line (no execute)" },
    { "<leader>di", function() require("dap").step_into() end,         desc = "Step [I]nto" },
    { "<leader>dj", function() require("dap").down() end,              desc = "Down" },
    { "<leader>dk", function() require("dap").up() end,                desc = "Up" },
    { "<leader>dl", function() require("dap").run_last() end,          desc = "Run Last" },
    { "<leader>do", function() require("dap").step_out() end,          desc = "Step [O]ut" },
    { "<leader>dO", function() require("dap").step_over() end,         desc = "Step [O]ver" },
    { "<leader>dp", function() require("dap").pause() end,             desc = "[P]ause" },
    { "<leader>dr", function() require("dap").repl.toggle() end,       desc = "Toggle [R]EPL" },
    { "<leader>ds", function() require("dap").session() end,           desc = "[S]ession" },
    { "<leader>dt", function() require("dap").terminate() end,         desc = "[T]erminate" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end,  desc = "[W]idgets" },
  },
  config = function()
    local Icons = require("k1ng.configs.icons")
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
    for name, sign in pairs(Icons.dap) do
      sign = type(sign) == "table" and sign or { sign }
      vim.fn.sign_define(
        "Dap" .. name,
        { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
      )
    end
  end,
}