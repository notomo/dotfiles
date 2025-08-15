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

M.kind_name = "word"
M.kind_label = "Snippet"

M.min_trigger_length = 1

return M
