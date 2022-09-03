local neotest = {}
neotest.statusline = {}

---@alias statusline.TestStatus 'idle' | 'running' | 'pass' | 'fail'

---@type statusline.TestStatus
neotest.statusline.test_status = 'idle'

---@param client neotest.Client
local function init(client)
  client.listeners.run = function()
    neotest.statusline.test_status = 'running'
  end

  client.listeners.results = function(_, results)
    local statuses = vim.tbl_map(function(result)
      return result.status
    end, vim.tbl_values(results))
    local is_failed = vim.tbl_contains(statuses, 'failed')

    neotest.statusline.test_status = is_failed and 'fail' or 'pass'
  end
end

neotest.statusline = setmetatable(neotest.statusline, {
  __call = function(_, client)
    init(client)
    return neotest.statusline
  end,
})

return neotest.statusline
