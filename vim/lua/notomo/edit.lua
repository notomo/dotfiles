local M = {}

function M.exchange()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.cmd("s/\\v%#(\\_.)(\\_.)/\\2\\1/g")
  vim.api.nvim_win_set_cursor(0, pos)
  vim.cmd("normal! l")
  vim.cmd("nohlsearch")
end

function M.to_next_syntax(pattern, column, offset)
  M._to_syntax(pattern, vim.fn.line("."), column, offset, false, true)
end

function M.to_prev_syntax(pattern, column, offset)
  M._to_syntax(pattern, vim.fn.line("."), column, offset, true, true)
end

function M._to_syntax(pattern, start_row, column, offset, go_backword, wrap)
  local is_limited, limit_row, move_row, wrap_row
  if go_backword then
    is_limited = function(row, limit)
      return row > limit
    end
    limit_row = 0
    move_row = -1
    wrap_row = vim.fn.line("$")
  else
    is_limited = function(row, limit)
      return row < limit
    end
    limit_row = vim.fn.line("$")
    move_row = 1
    wrap_row = 0
  end
  local row = start_row + move_row
  while is_limited(row, limit_row) do
    local syntax = vim.fn.synIDattr(vim.fn.synID(row, column, 1), "name")
    if vim.fn.match(syntax, pattern) ~= -1 then
      vim.fn.setpos(".", { vim.fn.bufnr("%"), row + offset, 1, 0 })
      return
    end
    row = row + move_row
  end
  if not wrap then
    return
  end
  M._to_syntax(pattern, wrap_row, column, offset, go_backword, false)
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
  local tmp = vim.fn.getreg("+")
  vim.cmd("normal! ]}v%y")
  vim.cmd("tabedit | setlocal buftype=nofile noswapfile fileformat=unix")
  vim.cmd("put | %join!")
  vim.fn.setreg("+", tmp)
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
  local file_path = table.concat({ dir_path, name }, "/")
  vim.cmd("tab drop " .. file_path)
  vim.cmd("lcd " .. dir_path)
end

function M.note()
  local dir_path = vim.fn.expand("~/workspace/memo")
  if vim.fn.isdirectory(dir_path) ~= 1 then
    vim.fn.mkdir(dir_path, "p")
  end

  local file_path = table.concat({ dir_path, "note.md" }, "/")
  if vim.fn.filereadable(file_path) ~= 1 then
    io.open(file_path, "w"):close()
  end

  local before_tab_num = vim.fn.tabpagenr()
  vim.cmd("tab drop " .. file_path)
  vim.cmd("lcd " .. dir_path)

  local note_tab_num = vim.fn.tabpagenr()
  local offset = before_tab_num - note_tab_num
  if offset > 0 then
    vim.cmd("tabmove +" .. offset)
  elseif offset < -1 then
    vim.cmd("tabmove " .. (offset + 1))
  end
  vim.cmd("normal! G")
end

local prev_port = 49152
function M.mkup(open_current)
  if vim.fn.executable("mkup") ~= 1 then
    return vim.api.nvim_echo({ { "not found mkup", "WarningMsg" } }, true, {})
  end

  prev_port = prev_port + 1
  local port = vim.g["local#var#port"] or prev_port
  local document_root, path
  if vim.g["local#var#document_root"] and not open_current then
    document_root = vim.fn.expand(vim.g["local#var#document_root"])
    path = ""
  else
    document_root = vim.fn.getcwd()
    path = vim.fn.filereadable(vim.fn.expand("%:p")) == 1 and vim.fn.expand("%") or ""
  end
  if vim.fn.isdirectory(document_root) ~= 1 then
    return vim.api.nvim_echo({ { document_root .. " is not directory", "WarningMsg" } }, true, {})
  end

  local cd_cmd = ("cd %s"):format(document_root)
  local server_cmd = ("mkup -http:%s"):format(port)
  vim.cmd("tabedit | terminal")
  local cmd = ("%s\n%s\n"):format(cd_cmd, server_cmd)
  vim.fn.jobsend(vim.b.terminal_job_id, cmd)

  local host = vim.g["local#var#host"] or "localhost"
  local url = ("http://%s:%s/%s"):format(host, port, path)
  vim.cmd("OpenBrowser " .. url)
  vim.cmd("tabprevious | +tabclose")
end

function M.rotate_file()
  local origin = vim.fn.expand("%")
  if origin == "" then
    return
  end
  for i = 1, 10000 do
    local name = ("%s_%s"):format(i, origin)
    if vim.fn.filereadable(name) ~= 1 and vim.fn.bufexists(name) ~= 1 then
      vim.cmd("file " .. name)
      vim.cmd("write")
      vim.cmd("edit " .. origin)
      return
    end
  end
  error("fail rotate: " .. origin)
end

function M.set_term_title(prompt_pattern, max_length)
  local path = vim.api.nvim_buf_get_name(0)
  local shell = vim.split(vim.fn.fnamemodify(path, ":t"), ":", true)[1]
  local term_path = ("%s/%s"):format(vim.fn.fnamemodify(path, ":h"), shell)

  local prompt_line = vim.fn.getline(vim.fn.search(prompt_pattern, "nbcW"))
  local prompt = vim.fn.matchstr(prompt_line, prompt_pattern)
  local cmd = prompt_line:sub(vim.fn.strlen(prompt), max_length)
  cmd = vim.fn.substitute(cmd, "/", [[\]], "g")

  vim.api.nvim_buf_set_name(0, ("%s:%s"):format(term_path, cmd))
  vim.cmd([[redrawtabline]])
end

function M.inc_or_dec(is_inc)
  local key = is_inc and "<C-a>" or "<C-x>"
  local line = vim.fn.getline(".")
  local col = vim.fn.col(".")
  local index = math.max(col - 1, 1)
  local pattern = [=[\v\d+\ze[^[:digit:]]*$]=]
  if vim.fn.matchend(line:sub(index), pattern) == -1 then
    local idx = vim.fn.matchend(line:sub(1, index), pattern)
    if idx ~= -1 then
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

function M.prev_file()
  local jumps, index = unpack(vim.fn.getjumplist())
  jumps = vim.list_slice(jumps, 1, index)
  jumps = vim.fn.reverse(jumps)
  local bufnr = vim.api.nvim_get_current_buf()
  local count = 0
  for _, jump in ipairs(jumps) do
    count = count + 1
    if bufnr ~= jump.bufnr then
      return ("<C-o>"):rep(count)
    end
  end
  return [[<Cmd>lua require('notomo.message').warn("no prev file")<CR>]]
end

function M.next_file()
  local jumps, index = unpack(vim.fn.getjumplist())
  jumps = vim.list_slice(jumps, index + 1)
  local bufnr = vim.api.nvim_get_current_buf()
  local count = 0
  for _, jump in ipairs(jumps) do
    count = count + 1
    if bufnr ~= jump.bufnr then
      return ("<C-i>"):rep(count)
    end
  end
  return [[<Cmd>lua require('notomo.message').warn("no next file")<CR>]]
end

function M.jump(pattern, search_flag)
  local old = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_win_set_cursor(0, { old[1], 0 })

  local pos = vim.fn.searchpos(pattern, search_flag .. "n")
  if pos[1] == 0 then
    return vim.api.nvim_win_set_cursor(0, old)
  end

  vim.cmd("normal! m'")
  vim.api.nvim_win_set_cursor(0, pos)
end

return M
