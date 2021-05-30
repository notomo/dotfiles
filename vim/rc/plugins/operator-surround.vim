scriptencoding utf-8

nnoremap [surround] <Nop>
nmap s [surround]
xnoremap [surround] <Nop>
xmap s [surround]
nmap <silent>[surround]a <Plug>(operator-surround-append)
xmap <silent>[surround]a <Plug>(operator-surround-append)
nmap <silent>[surround]d v<Plug>(textobj-multiblock-a)<Plug>(operator-surround-delete)
xmap <silent>[surround]d <Plug>(operator-surround-delete)
nmap <silent>[surround]r v<Plug>(textobj-multiblock-a)<Plug>(operator-surround-replace)
xmap <silent>[surround]r <Plug>(operator-surround-replace)

let g:operator#surround#ignore_space = 0
let g:operator#surround#uses_input_if_no_block = 0

let g:operator#surround#blocks =
\ {
\   '-' : [
\       { 'block' : ['(', ')'], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['p'] },
\       { 'block' : ['[', ']'], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['l'] },
\       { 'block' : ['[[', ']]'], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['L'] },
\       { 'block' : ['{', '}'], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['d'] },
\       { 'block' : ['<', '>'], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['t'] },
\       { 'block' : ['"', '"'], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['w'] },
\       { 'block' : ["'", "'"], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['q'] },
\       { 'block' : ['%', '%'], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['r'] },
\       { 'block' : ['|', '|'], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['o'] },
\       { 'block' : ['*', '*'], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['x'] },
\       { 'block' : ['**', '**'], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['X'] },
\       { 'block' : ['`', '`'], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['b'] },
\       { 'block' : ['~~', '~~'], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['T'] },
\       { 'block' : ['【', '】'], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['D'] },
\       { 'block' : ['「', '」'], 'motionwise' : ['char', 'line', 'block'], 'keys' : [';'] },
\       { 'block' : ['（', '）'], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['P'] },
\       { 'block' : ["```\n", "\n\n\<C-u>```"], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['c'] },
\       { 'block' : ["<pre>\n", "\n\n\<C-u></pre>"], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['apre'] },
\       { 'block' : ["<details>\n<summary>Details</summary>\n\n", "\n\n\n\<C-u></details>"], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['s'] },
\   ],
\ }
