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

M.kind_name = "word"

return M
