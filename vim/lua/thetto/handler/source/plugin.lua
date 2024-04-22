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

M.modify_pipeline = require("thetto.util.pipeline").append({
  require("thetto.util.sorter").field_by_name("value"),
})

M.kind_name = "file/directory"

M.actions = {
  action_search = function(items)
    local item = items[1]
    if item == nil then
      return
    end
    local bufnr = vim.fn.bufadd(vim.fn.expand("$DOTFILES/vim/lua/notomo/plugin/_list.lua"))
    vim.fn.bufload(bufnr)
    return require("thetto").start(
      require("thetto.util.source").by_name("vim/line", {
        can_resume = false,
      }),
      {
        source_bufnr = bufnr,
        consumer_factory = require("thetto.util.consumer").immediate({ action_name = "open" }),
        pipeline_stages_factory = require("thetto.util.pipeline").list({
          require("thetto.util.filter").item(function(e)
            return e.value:find([[add%("]] .. vim.pesc(item.value))
          end),
        }),
      }
    )
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
    local names = vim
      .iter(items)
      :map(function(item)
        return ("(%s)"):format(item.name)
      end)
      :totable()
    local pattern = "\\v" .. table.concat(names, "|")
    require("optpack").update({ pattern = pattern })
  end,
}

return M
