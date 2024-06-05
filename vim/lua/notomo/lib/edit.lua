local M = {}

function M.exchange()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.cmd.substitute([[/\v%#(\_.)(\_.)/\2\1/g]])
  vim.api.nvim_win_set_cursor(0, pos)
  vim.cmd.normal({ args = { "l" }, bang = true })
  vim.cmd.nohlsearch()
end

function M.to_multiline()
  local col = vim.fn.col(".")
  local char = vim.fn.getline("."):sub(col)
  if vim.fn.match(char, "\\v\\>|}|\\)|]|\\<") == -1 then
    return ""
  end
  local chars = vim.fn.getline("."):sub(col - 1, col)
  if vim.fn.match(chars, "\\v\\>\\<|\\<\\>|\\{\\}|\\(\\)|\\[\\]") ~= -1 then
    return vim.api.nvim_eval([["\<CR>\<ESC>O"]])
  end
  return vim.api.nvim_eval([["\<CR>\<ESC>%a\<CR>\<ESC>$a"]])
end

function M.yank(value)
  vim.fn.setreg('"', value)
  vim.fn.setreg("+", value)
  vim.fn.setreg("0", value)
  vim.fn.setreg("*", value)
  vim.api.nvim_echo({ { "yank " .. value } }, true, {})
end

function M.jq()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local lines = vim.api.nvim_buf_get_lines(0, cursor[1] - 1, cursor[1], false)

  vim.cmd.tabedit()
  vim.bo.buftype = "nofile"
  vim.bo.swapfile = false
  vim.bo.fileformat = "unix"
  vim.bo.bufhidden = "wipe"
  vim.bo.filetype = "json"

  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.cmd("%join!")
  vim.cmd("%!jq '.'")
end

function M.scratch(name, filetype)
  local typ
  if filetype == "" then
    typ = "nofiletype"
  else
    typ = filetype
  end
  local dir_path = vim.fn.expand("~/workspace/scratch/" .. typ)
  if vim.fn.isdirectory(dir_path) ~= 1 then
    vim.fn.mkdir(dir_path, "p")
  end
  vim.cmd.lcd(dir_path)
  local file_path = table.concat({ dir_path, name }, "/")
  vim.cmd.drop({ mods = { tab = vim.fn.tabpagenr() }, args = { file_path } })
end

function M.note()
  local dir_path = vim.fn.expand("~/workspace/memo")
  local file_path = table.concat({ dir_path, "note.md" }, "/")
  if vim.fn.filereadable(file_path) ~= 1 then
    vim.fn.writefile({}, file_path, "p")
  end

  local before_tab_num = vim.fn.tabpagenr()
  local bufnr = vim.fn.bufnr("^" .. file_path .. "$")
  local window_id = vim.fn.win_findbuf(bufnr)[1]
  if not window_id then
    vim.cmd.tabedit(file_path)
  else
    vim.api.nvim_set_current_win(window_id)
  end
  vim.cmd.lcd(dir_path)

  local note_tab_num = vim.fn.tabpagenr()
  local offset = before_tab_num - note_tab_num
  if offset > 0 then
    vim.cmd.tabmove("+" .. offset)
  elseif offset < -1 then
    vim.cmd.tabmove({ args = { tostring(offset + 1) } })
  end
  vim.cmd.normal({ args = { "G" }, bang = true })
end

function M.rotate_file()
  local origin = vim.fn.expand("%")
  if origin == "" then
    return
  end
  for i = 1, 10000 do
    local name = ("%03d_%s"):format(i, origin)
    if vim.fn.filereadable(name) ~= 1 and vim.fn.bufexists(name) ~= 1 then
      vim.cmd.file(name)
      vim.cmd.write()
      vim.cmd.edit(origin)
      return
    end
  end
  error("fail rotate: " .. origin)
end

function M.set_term_title(prompt_pattern)
  prompt_pattern = prompt_pattern or "^\\$ "

  local path = vim.api.nvim_buf_get_name(0)
  local shell = vim.split(vim.fn.fnamemodify(path, ":t"), ":", { plain = true })[1]
  local term_path = ("%s/%s"):format(vim.fn.fnamemodify(path, ":h"), shell)

  local prompt_line = vim.fn.getline(vim.fn.search(prompt_pattern, "nbcW"))
  local prompt = vim.fn.matchstr(prompt_line, prompt_pattern)
  local cmd = prompt_line:sub(vim.fn.strlen(prompt))
  cmd = vim.fn.substitute(cmd, "/", [[\]], "g")
  if vim.trim(cmd) == "" then
    return
  end

  vim.api.nvim_buf_set_name(0, ("%s:%s"):format(term_path, cmd))
  vim.cmd.redrawtabline()
end

function M.set_title(bufnr, cmd)
  local simplified_cmd = vim
    .iter(cmd)
    :map(function(x)
      if vim.startswith(x, "/") then
        return "{path}"
      end
      return x
    end)
    :totable()
  local str = table.concat(simplified_cmd, " ")

  str = vim.fn.substitute(str, "/", [[\]], "g")
  if vim.trim(str) == "" then
    return
  end

  vim.api.nvim_buf_set_name(bufnr, ("%s/%s"):format(bufnr, str))
  vim.cmd.redrawtabline()
end

function M.inc_or_dec(is_inc)
  local key = is_inc and "<C-a>" or "<C-x>"
  local line = vim.fn.getline(".")
  local col = vim.fn.col(".")
  local index = math.max(col - 1, 1)
  local pattern = [=[\v\d+\ze[^[:digit:]]*$]=]
  if vim.fn.matchend(line:sub(index + 1), pattern) == -1 then
    local idx = vim.fn.matchend(line:sub(1, index), pattern)
    local count = col - idx
    if idx ~= -1 and count > 0 then
      return ("%dh%s"):format(col - idx, key)
    end
  end
  return key
end

local CURSOR_KEY = "{cursor}"
local REGISTER_KEY = "{register}"
local WORD_KEY = "{word}"
function M.gen_substitute(cmd_pattern, is_visual)
  local word = vim.fn.expand("<cword>")
  local replaced_word = vim.fn.substitute(cmd_pattern, WORD_KEY, word, "g")
  local register = vim.fn.getreg('"')
  local alter_register = vim.fn["repeat"]("x", #register)
  local alter_replaced_register = vim.fn.substitute(replaced_word, REGISTER_KEY, alter_register, "g")
  local cursor_pos = vim.fn.matchend(alter_replaced_register, CURSOR_KEY)
  local deleted_cursor = vim.fn.substitute(replaced_word, CURSOR_KEY, "", "")
  local result = vim.fn.substitute(deleted_cursor, REGISTER_KEY, register, "g")
    .. vim.fn["repeat"]([[<Left>]], #alter_replaced_register - cursor_pos)
  -- a\<BS> is for inccommand
  result = vim.fn.substitute(result, [[\n]], [[\\n]], "g") .. [[a<BS>]]
  return is_visual and result or vim.fn.substitute(result, [[:\zs]], [[<C-u>]], "")
end

function M.jump(pattern, search_flag)
  local old = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_win_set_cursor(0, { old[1], 0 })

  local pos = vim.fn.searchpos(pattern, search_flag .. "n")
  if pos[1] == 0 then
    return vim.api.nvim_win_set_cursor(0, old)
  end

  vim.cmd.normal({ args = { "m'" }, bang = true })
  vim.api.nvim_win_set_cursor(0, pos)
end

function M.delete_prev()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_text(0, row - 1, 0, row - 1, col, { "" })
  vim.api.nvim_win_set_cursor(0, { row, 0 })
end

function M.get_selected_text()
  local mode = vim.api.nvim_get_mode().mode
  if not vim.tbl_contains({ "v", "V", vim.api.nvim_eval('"\\<C-v>"') }, mode) then
    return ""
  end

  local tmp = vim.fn.getreginfo("t")

  vim.cmd.normal({ args = { [["tygv]] }, bang = true, mods = { noautocmd = true } })
  local selected_text = vim.fn.getreg("t")

  vim.fn.setreg("t", tmp)

  return selected_text
end

function M._selected_lines()
  require("misclib.visual_mode").leave()

  local typ = vim.fn.visualmode()
  vim.cmd.normal({ args = { "gv" }, bang = true })

  return vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = typ })
end

function M.open_selected()
  local lines = M._selected_lines()
  vim.cmd.tabedit()
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

function M.align(separator)
  local lines = M._selected_lines()

  local rows = vim
    .iter(lines)
    :map(function(line)
      local cells = vim.split(line, separator, { plain = true })
      return {
        cells = cells,
        widths = vim
          .iter(cells)
          :map(function(x)
            return vim.fn.strdisplaywidth(x)
          end)
          :totable(),
      }
    end)
    :totable()

  local column_count = math.max(unpack(vim
    .iter(rows)
    :map(function(row)
      return #row.cells
    end)
    :totable()))
  local column_widths = vim
    .iter(vim.fn.range(column_count))
    :map(function(i)
      local column = i + 1
      return math.max(unpack(vim
        .iter(rows)
        :map(function(row)
          return row.widths[column] or 0
        end)
        :totable()))
    end)
    :totable()

  local new_lines = vim
    .iter(rows)
    :map(function(row)
      return vim
        .iter(row.cells)
        :enumerate()
        :map(function(column, cell)
          local space = column_widths[column] - row.widths[column]
          return cell .. (" "):rep(space)
        end)
        :join(separator)
    end)
    :totable()

  local s = vim.fn.line("v") - 1
  local e = vim.fn.line(".") - 1
  if s > e then
    s, e = e, s
  end
  vim.api.nvim_buf_set_text(0, s, 0, e, -1, new_lines)

  require("misclib.visual_mode").leave()
end

return M
