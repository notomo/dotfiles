local M = {}

function M.collect(source_ctx)
  if source_ctx.cursor_word.str == "" then
    return {}
  end

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
M.kind_label = "Snippet"

return M
