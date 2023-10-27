local breakpoints_fp = os.getenv('HOME') .. '/.cache/dap/breakpoints.json'

local function file_exist(file_path)
  local f = io.open(file_path, 'r')
  return f ~= nil and io.close(f)
end

function _G.store_breakpoints(clear)
  local bps = {}

  local load_bps_raw = io.open(breakpoints_fp, 'r'):read('*a')
  if string.len(load_bps_raw) ~= 0 and file_exist(breakpoints_fp) then
    bps = vim.fn.json_decode(load_bps_raw)
  end

  if clear then
    for _, bufrn in ipairs(vim.api.nvim_list_bufs()) do
      bps[vim.api.nvim_buf_get_name(bufrn)] = nil
    end
  else
    local breakpoints_by_buf = require('dap.breakpoints').get()
    for _, bufrn in ipairs(vim.api.nvim_list_bufs()) do
      bps[vim.api.nvim_buf_get_name(bufrn)] = breakpoints_by_buf[bufrn]
    end
  end
  local fp = io.open(breakpoints_fp, 'w')
  if fp ~= nil then
    fp:write(vim.fn.json_encode(bps))
    fp:close()
  end
end

function _G.load_breakpoints()
  if not file_exist(breakpoints_fp) then
    return
  end
  local content = io.open(breakpoints_fp, 'r'):read('*a')
  if string.len(content) == 0 then
    return
  end
  local bps = vim.fn.json_decode(content)
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local file_name = vim.api.nvim_buf_get_name(buf)
    if bps[file_name] ~= nil then
      for _, bp in pairs(bps[file_name]) do
        local line = bp.line
        local opts = {
          condition = bp.condition,
          log_message = bp.logMessage,
          hit_condition = bp.hitCondition,
        }
        require('dap.breakpoints').set(opts, tonumber(buf), line)
      end
    end
  end
end

-- for lazy.nvim
return {}
