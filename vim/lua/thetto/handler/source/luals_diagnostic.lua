local pathlib = require("thetto.lib.path")

local M = {}

function M.collect(source_ctx)
  local output_path = vim.fn.tempname()
  local cmd = {
    "lua-language-server",
    "--check=lua",
    "--check_out_path",
    output_path,
    "--configpath",
    vim.fs.joinpath(require("optpack").get("workflow").directory, ".luarc.json"),
  }
  return require("thetto.util.job")
    .promise(cmd, {
      cwd = source_ctx.cwd,
      on_exit = function() end,
    })
    :next(function()
      local f = assert(io.open(output_path))
      local content = f:read("*a")
      f:close()

      local items_map = vim
        .iter(vim.json.decode(content))
        :map(function(uri, diagnostics)
          return vim
            .iter(diagnostics)
            :map(function(diagnostic)
              local path = vim.uri_to_fname(uri)
              local relative_path = pathlib.to_relative(path, source_ctx.cwd)
              local row = diagnostic.range.start.line + 1
              local column = diagnostic.range.start.character
              local path_part = ("%s:%d:%d"):format(relative_path, row, column)
              local message = diagnostic.message:gsub("\n", " ")
              local desc = ("%s %s [%s:%s]"):format(path_part, message, diagnostic.source, diagnostic.code)
              return {
                value = message,
                desc = desc,
                row = row,
                column = diagnostic.range.start.character,
                end_column = diagnostic.range["end"].character,
                path = path,
                severity = diagnostic.severity,
                column_offsets = {
                  path = 0,
                  value = #path_part + 1,
                },
              }
            end)
            :totable()
        end)
        :totable()
      return vim.iter(vim.tbl_values(items_map)):flatten():totable()
    end)
end

M.kind_name = "file"

M.cwd = require("thetto.util.cwd").upward({ "lua", ".git" })

M.highlight = require("thetto.util.highlight").columns({
  {
    group = "Comment",
    end_key = "value",
  },
})

return M
