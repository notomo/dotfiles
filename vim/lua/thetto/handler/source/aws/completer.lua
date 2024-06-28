local M = {}

function M.collect(source_ctx)
  local input = source_ctx.pattern
  return require("thetto.util.job").run({ "aws_completer" }, source_ctx, function(output)
    local last = vim.iter(vim.split(input, "%s")):pop()
    local completion = output:sub(#last + 1)
    local value = input .. completion
    return {
      value = value,
      desc = "aws " .. value,
    }
  end, {
    to_outputs = function(output)
      return vim.split(output, "\n", { plain = true })
    end,
    env = {
      COMP_LINE = "aws " .. input,
    },
  })
end

M.modify_pipeline = require("thetto.util.pipeline").prepend({
  require("thetto.util.filter").by_name("source_input"),
})

M.actions = {
  opts = {
    yank = { key = "desc" },
    append = { key = "desc" },
  },
  default_action = "append",

  action_search = function(items)
    local item = items[1]
    if item == nil then
      return
    end

    local splitted = vim.split(item.value, "%s")
    local main_cmd = splitted[1]
    local sub_cmd = splitted[2] or "index"
    local url = ("https://awscli.amazonaws.com/v2/documentation/api/latest/reference/%s/%s.html"):format(
      main_cmd,
      sub_cmd
    )
    require("notomo.lib.browser").open(url)
  end,

  action_tab_open = function(items)
    local item = items[1]
    if item == nil then
      return
    end

    local cmd = vim
      .iter(vim.split("aws " .. item.value, "%s"))
      :take(3)
      :filter(function(x)
        return x
      end)
      :totable()
    table.insert(cmd, "help")

    return require("thetto.util.job")
      .promise(cmd, {
        on_exit = function() end,
      })
      :next(function(output)
        local bufnr = vim.api.nvim_create_buf(false, true)

        local ch = vim.api.nvim_open_term(bufnr, {})
        vim.api.nvim_chan_send(ch, output)

        vim.cmd.tabedit()
        vim.cmd.buffer(bufnr)
        vim.bo.bufhidden = "wipe"
      end)
  end,
}

return M
