local M = {}

function M.collect(_, source_ctx)
  local info = vim.fn.systemlist("deno info")[1]
  local splitted = vim.split(info, "%s+")
  local deps_path = splitted[#splitted] .. "/deps"

  local cmd = { "find", deps_path, "-name", "*.metadata.json" }
  return require("thetto.util").job.start(cmd, source_ctx, function(path)
    local f = io.open(path, "r")
    local url = vim.json.decode(f:read("*a")).url
    f:close()
    return {
      value = url,
      url = url,
      is_mod_ts = url:find("/mod.ts") ~= nil and 1 or 0,
    }
  end)
end

M.kind_name = "word"
M.sorters = { "-numeric:is_mod_ts", "-numeric" }
M.default_action = "append"

return M
