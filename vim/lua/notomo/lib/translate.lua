local M = {}

local function translate(instruction, language)
  local lines = require("notomo.lib.edit").get_selected_lines()
  require("misclib.visual_mode").leave()

  local text = table.concat(lines, "\n")
  local prompt = instruction .. ":\n\n" .. text
  require("notomo.lib.job").terminal({
    "claude",
    "--no-session-persistence",
    "--effort",
    "low",
    "--settings",
    vim.json.encode({
      language = language,
    }),
    "-p",
    prompt,
    "--model",
    "haiku",
  })
end

function M.english_to_japanese()
  translate("Translate the following English text to Japanese. Output only the translation result", "japanese")
end

function M.japanese_to_english()
  translate("Translate the following Japanese text to English. Output only the translation result", "english")
end

return M
