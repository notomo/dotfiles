local M = {}

local function compile_glob(glob)
  local ok, pat = pcall(vim.glob.to_lpeg, glob)
  if not ok then
    return nil
  end
  return pat
end

local function matches_filter(old_path, new_path, filter)
  if filter.scheme and filter.scheme ~= "file" then
    return false
  end

  local pattern = filter.pattern
  if not pattern or not pattern.glob then
    return false
  end

  if pattern.matches == "file" and vim.fn.isdirectory(new_path) == 1 then
    return false
  end
  if pattern.matches == "folder" and vim.fn.isdirectory(new_path) == 0 then
    return false
  end

  local pat = compile_glob(pattern.glob)
  if not pat then
    return false
  end

  local candidate = old_path
  if pattern.options and pattern.options.ignoreCase then
    candidate = candidate:lower()
  end

  return pat:match(candidate) == #candidate + 1
end

local function matches_filters(old_path, new_path, filters)
  if not filters or #filters == 0 then
    return false
  end
  for _, filter in ipairs(filters) do
    if matches_filter(old_path, new_path, filter) then
      return true
    end
  end
  return false
end

local function normalize_path(path)
  return (path:gsub("/+$", ""))
end

local function collect_files(renames, filters)
  local files = {}
  for _, rename in ipairs(renames) do
    local old_path = normalize_path(rename.old_path)
    local new_path = normalize_path(rename.new_path)
    if matches_filters(old_path, new_path, filters) then
      table.insert(files, {
        oldUri = vim.uri_from_fname(old_path),
        newUri = vim.uri_from_fname(new_path),
      })
    end
  end
  return files
end

local function request_will_rename(client, files)
  local Promise = require("promise")
  local promise, resolve, reject = Promise.with_resolvers()
  local ok = client:request("workspace/willRenameFiles", { files = files }, function(err, result, ctx)
    if err then
      return reject(err)
    end
    resolve({ result = result, ctx = ctx })
  end)
  if not ok then
    reject(("willRenameFiles request failed: %s"):format(client.name))
  end
  return promise
end

local function apply_will_rename_result(value)
  if not value.result then
    return
  end
  local client = vim.lsp.get_client_by_id(value.ctx.client_id)
  if not client then
    return
  end
  vim.lsp.util.apply_workspace_edit(value.result, client.offset_encoding)
end

local function apply_for_client(client, renames)
  local file_ops = vim.tbl_get(client.server_capabilities or {}, "workspace", "fileOperations")
  if not file_ops then
    return
  end

  local did_files = file_ops.didRename and collect_files(renames, file_ops.didRename.filters) or {}
  local will_files = file_ops.willRename and collect_files(renames, file_ops.willRename.filters) or {}

  local Promise = require("promise")
  local will_done
  if #will_files == 0 then
    will_done = Promise.resolve()
  else
    will_done = request_will_rename(client, will_files):next(apply_will_rename_result):catch(function(err)
      require("notomo.lib.message").warn(err)
    end)
  end

  will_done:finally(function()
    if #did_files == 0 then
      return
    end
    client:notify("workspace/didRenameFiles", { files = did_files })
  end)
end

function M.apply(renames)
  if not renames or #renames == 0 then
    return
  end
  for _, client in ipairs(vim.lsp.get_clients()) do
    apply_for_client(client, renames)
  end
end

return M
