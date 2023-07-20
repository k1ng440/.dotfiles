
local M = {}
function M.is_yadm_file()
  local current_file = vim.api.nvim_buf_get_name(0)
  local is_yadm_file = false
  local cmd = {'yadm', 'ls-files', '--error-unmatch', current_file}

  vim.fn.jobstart(cmd, {
    on_exit = function(_, code)
      if code == 0 then
        is_yadm_file = true
      end
    end
  })

  return is_yadm_file
end

function M.setup()
  local ok, neogit = pcall(require, 'neogit')
  if ok then
  end

end


return M
