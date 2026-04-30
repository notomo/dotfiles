local M = {}

local url = "https://raw.githubusercontent.com/github/gemoji/refs/heads/master/db/emoji.json"

local function cache_path()
  return vim.fn.stdpath("cache") .. "/emoji/emoji.json"
end

local function to_items(emoji_data)
  local items = {}
  for _, info in ipairs(emoji_data) do
    table.insert(items, {
      value = ("%s %s"):format(info.emoji, info.aliases[1]),
      emoji = info.emoji,
    })
  end
  return items
end

local function load_cache(path)
  local data = vim.fn.json_decode(table.concat(vim.fn.readfile(path), "\n"))
  return to_items(data)
end

function M.collect()
  local path = cache_path()
  if not vim.uv.fs_stat(path) then
    vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")
    local done = false
    vim.net.request(url, {
      outpath = path,
      callback = function()
        done = true
      end,
    })
    vim.wait(5000, function()
      return done
    end)
  end
  return load_cache(path)
end

M.kind_name = "word"

M.actions = {
  opts = {
    append = { key = "emoji" },
  },
  default_action = "append",
}

M.modify_pipeline = require("thetto.util.pipeline").append({
  require("thetto.util.sorter").field_length_by_name("value"),
})

return M
