local M = {}

function M.collect()
  return vim
    .iter(vim.fn["neosnippet#helpers#get_completion_snippets"]())
    :map(function(snippet)
      return {
        value = snippet.word,
      }
    end)
    :totable()
end

function M.should_collect()
  return false
end

function M.resolve()
  if vim.fn["neosnippet#expandable"]() == 0 then
    return
  end
  vim.api.nvim_feedkeys(vim.keycode("<Plug>(neosnippet_expand)"), "m", true)
end

M.kind_name = "word"
M.kind_label = "Snippet"

M.min_trigger_length = 1

return M
