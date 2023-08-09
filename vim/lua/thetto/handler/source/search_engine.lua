local M = {}

function M.collect()
  return vim
    .iter({
      mdn = [[https://developer.mozilla.org/ja/search?q=]],
      docker = [[https://docs.docker.com/search/?q=]],
      mongo = [[https://www.mongodb.com/docs/search/?q=]],
      github_api = [[https://docs.github.com/en?query=]],
      ansible = [[https://docs.ansible.com/ansible/latest/index.html#stq=]],
      git = [[http://git-scm.com/search/results?search=]],
      deno = [[https://deno.land/x?query=]],
      google = [[https://google.com/search?q=]],
    })
    :map(function(name, url_prefix)
      return {
        value = name,
        url_prefix = url_prefix,
      }
    end)
    :totable()
end

M.default_action = "search"

M.actions = {
  action_search = function(items, _, ctx)
    local item = items[1]
    if not item then
      return
    end

    vim.ui.input({ prompt = "Search: " .. item.value }, function(input)
      if not input then
        require("misclib.message").info("Canceled.")
        return
      end
      local url = item.url_prefix .. input
      local new_item = { url = url }
      return require("thetto.util.action").call("url", "open_browser", { new_item }, ctx)
    end)
  end,
}

return M
