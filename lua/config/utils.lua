local M = {}

function M.clean_unused_plugins()
  local plugins = vim.pack.get()

  local active = {}
  for _, plugin in ipairs(plugins) do
    if plugin.active then
      active[plugin.spec.name] = true
    end
  end

  local remove = {}
  for _, plugin in ipairs(plugins) do
    if not active[plugin.spec.name] then
      table.insert(remove, plugin.spec.name)
    end
  end

  if #remove > 0 then
    print("removing " .. table.concat(remove, ", "))
    vim.pack.del(remove)
  else
    print("nothing to clean")
  end
end

return M
