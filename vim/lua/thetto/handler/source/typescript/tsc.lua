local M = {}

function M.collect(source_ctx)
  return function(observer)
    require("cmdhndlr")
      .build_as_job({
        name = "typescript/tsc",
        bufnr = source_ctx.bufnr,
        working_dir = function()
          return source_ctx.cwd
        end,
      })
      :next(function(ctx)
        if ctx.raw_error then
          local items = vim
            .iter(vim.split(ctx.raw_error, "\n", { plain = true }))
            :map(function(line)
              return {
                value = line,
                kind_name = "word",
              }
            end)
            :totable()
          observer:next(items)
          observer:complete()
          return
        end

        local items = vim
          .iter(ctx.errors)
          :map(function(e)
            local relative_path = require("thetto.lib.path").to_relative(e.path, source_ctx.cwd)
            return {
              value = ("%s %s"):format(relative_path, e.message),
              path = e.path,
              row = e.row,
            }
          end)
          :totable()
        observer:next(items)
        observer:complete()
      end)
  end
end

M.kind_name = "file"

M.cwd = require("thetto.util.cwd").upward({ "tsconfig.json" })

return M
