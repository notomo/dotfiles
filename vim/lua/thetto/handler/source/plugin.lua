local M = {}

function M.collect()
  local items = {}
  local plugins = require("optpack").list()
  for _, plugin in ipairs(plugins) do
    table.insert(items, {
      value = plugin.full_name,
      name = plugin.name,
      path = plugin.directory,
    })
  end
  return items
end

M.sorters = { "alphabet" }

M.kind_name = "file/directory"

M.actions = {
  action_search = function(items)
    local item = items[1]
    if item == nil then
      return
    end
    local bufnr = vim.fn.bufadd(vim.fn.expand("$DOTFILES/vim/lua/notomo/plugin/_list.lua"))
    vim.fn.bufload(bufnr)
    return require("thetto").start("line", {
      opts = {
        input_lines = { [[add("]] .. item.value },
        immediately = true,
        insert = false,
        can_resume = false,
      },
      source_opts = { bufnr = bufnr },
    })
  end,

  action_enable_hot_reloading = function(items)
    for _, item in ipairs(items) do
      local name = vim.split(item.value, "/", { plain = true })[2]:gsub("%.nvim$", "")
      require("lreload").enable(name)
    end
  end,

  action_disable_hot_reloading = function(items)
    for _, item in ipairs(items) do
      local name = vim.split(item.value, "/", { plain = true })[2]:gsub("%.nvim$", "")
      require("lreload").disable(name)
    end
  end,

  action_update = function(items)
    local names = vim.tbl_map(function(item)
      return ("(%s)"):format(item.name)
    end, items)
    local pattern = "\\v" .. table.concat(names, "|")
    require("optpack").update({ pattern = pattern })
  end,
}

return M
