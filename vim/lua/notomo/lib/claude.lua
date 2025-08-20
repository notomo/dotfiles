local M = {}

local function get_session(file)
  local session_id = vim.fn.fnamemodify(file, ":t:r")

  local head_messages = vim
    .iter(vim.fn.readfile(file, "", 100))
    :map(function(line)
      return vim.json.decode(line)
    end)
    :filter(function(data)
      return data.type == "user" and data.message
    end)
    :map(function(data)
      return data.message.content
    end)
    :filter(function(content)
      return type(content) == "string"
    end)
    :totable()
  if #head_messages > 0 then
    return {
      session_id = session_id,
      head_messages = head_messages,
    }
  end

  return nil
end

function M.get_sessions()
  local git_root = vim.fs.root(0, ".git")
  if not git_root then
    return {}
  end

  local project_name = git_root:gsub("/", "-")
  local sessions_dir = vim.fs.normalize(vim.fs.joinpath("~/.claude/projects/", project_name))
  if vim.fn.isdirectory(sessions_dir) == 0 then
    return {}
  end

  return vim
    .iter(vim.fs.dir(sessions_dir))
    :filter(function(name, type)
      return type == "file" and name:match("%.jsonl$")
    end)
    :map(function(name)
      return get_session(vim.fs.joinpath(sessions_dir, name))
    end)
    :totable()
end

return M