local M = {}

local execute = function(items, args)
  local playbook
  if vim.fn.has("mac") == 1 then
    playbook = "playbooks/mac.yml"
  elseif vim.fn.has("linux") == 1 then
    playbook = "playbooks/ubuntu.yml"
  else
    error("not found playbook")
  end

  local tags = vim
    .iter(items)
    :map(function(item)
      return "--tags=" .. item.value
    end)
    :totable()

  vim.cmd.tabedit()

  local cmd = { "ansible-playbook", playbook }
  vim.list_extend(cmd, tags)
  vim.list_extend(cmd, args or {})

  local cwd = vim.fn.expand("$DOTFILES/ansible")
  vim.fn.termopen(cmd, {
    env = { ANSIBLE_CONFIG = cwd },
    cwd = cwd,
  })
end

function M.action_execute(items)
  execute(items)
end

function M.action_execute_with_become(items)
  execute(items, { "--ask-become-pass" })
end

M.default_action = "execute"

return require("thetto.core.kind").extend(M, "file/directory")
