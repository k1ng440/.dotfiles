--- Get all the changes in the git repository
---@param staged? boolean
---@return string
local function get_git_diff(staged)
  local cmd = staged and 'git diff --staged' or 'git diff'
  local handle = io.popen(cmd)
  if not handle then
    return ''
  end

  local result = handle:read('*a')
  handle:close()
  return result
end

return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    -- version = '1.9.1',
    branch = 'canary',
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-lua/plenary.nvim' },
    },
    opts = function()
      local user = vim.env.USER or 'User'
      user = user:sub(1, 1):upper() .. user:sub(2)
      return {
        model = 'gpt-4',
        auto_insert_mode = true,
        show_help = true,
        question_header = '  ' .. user .. ' ',
        answer_header = '  Copilot ',
        window = {
          width = 0.4,
        },
        selection = function(source)
          local select = require('CopilotChat.select')
          return select.visual(source) or select.buffer(source)
        end,
      }
    end,
    build = function()
      vim.notify("Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim.")
    end,
    event = 'VeryLazy',
    keys = {
      -- Show help actions with telescope
      {
        '<leader>ah',
        function()
          require('CopilotChat.code_actions').show_help_actions()
        end,
        desc = 'CopilotChat - Help actions',
      },
      -- Show prompts actions with telescope
      {
        '<leader>ap',
        function()
          require('CopilotChat.code_actions').show_prompt_actions()
        end,
        desc = 'CopilotChat - Prompt actions',
      },
      {
        '<leader>ap',
        ":lua require('CopilotChat.code_actions').show_prompt_actions(true)<CR>",
        mode = 'x',
        desc = 'CopilotChat - Prompt actions',
      },
      -- Code related commands
      { '<leader>ae', '<cmd>CopilotChatExplain<cr>', desc = 'CopilotChat - Explain code' },
      { '<leader>at', '<cmd>CopilotChatTests<cr>', desc = 'CopilotChat - Generate tests' },
      { '<leader>ar', '<cmd>CopilotChatReview<cr>', desc = 'CopilotChat - Review code' },
      { '<leader>aR', '<cmd>CopilotChatRefactor<cr>', desc = 'CopilotChat - Refactor code' },
      { '<leader>an', '<cmd>CopilotChatBetterNamings<cr>', desc = 'CopilotChat - Better Naming' },
      -- Chat with Copilot in visual mode
      {
        '<leader>av',
        ':CopilotChatVisual',
        mode = 'x',
        desc = 'CopilotChat - Open in vertical split',
      },
      {
        '<leader>ax',
        ':CopilotChatInPlace<cr>',
        mode = 'x',
        desc = 'CopilotChat - Run in-place code',
      },
      -- Custom input for CopilotChat
      {
        '<leader>ai',
        function()
          local input = vim.fn.input('Ask Copilot: ')
          if input ~= '' then
            vim.cmd('CopilotChat ' .. input)
          end
        end,
        desc = 'CopilotChat - Ask input',
      },
      -- Generate commit message based on the git diff
      {
        '<leader>am',
        function()
          local diff = get_git_diff()
          if diff ~= '' then
            vim.fn.setreg('"', diff)
            vim.cmd('CopilotChat Write commit message for the change with commitizen convention.')
          end
        end,
        desc = 'CopilotChat - Generate commit message for all changes',
      },
      {
        '<leader>aM',
        function()
          local diff = get_git_diff(true)
          if diff ~= '' then
            vim.fn.setreg('"', diff)
            vim.cmd('CopilotChat Write commit message for the change with commitizen convention.')
          end
        end,
        desc = 'CopilotChat - Generate commit message for staged changes',
      },
      -- Quick chat with Copilot
      {
        '<leader>aq',
        function()
          local input = vim.fn.input('Quick Chat: ')
          if input ~= '' then
            vim.cmd('CopilotChat ' .. input)
          end
        end,
        desc = 'CopilotChat - Quick chat',
      },
      -- Debug
      { '<leader>ad', '<cmd>CopilotChatDebugInfo<cr>', desc = 'CopilotChat - Debug Info' },
      -- Fix the issue with diagnostic
      { '<leader>af', '<cmd>CopilotChatFixDiagnostic<cr>', desc = 'CopilotChat - Fix Diagnostic' },
      -- Clear buffer and chat history
      { '<leader>al', '<cmd>CopilotChatReset<cr>', desc = 'CopilotChat - Clear buffer and chat history' },
      -- Toggle Copilot Chat Vsplit
      { '<leader>av', '<cmd>CopilotChatToggle<cr>', desc = 'CopilotChat - Toggle Vsplit' },
    },
  },
}
