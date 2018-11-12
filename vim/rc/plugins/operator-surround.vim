scriptencoding utf-8

let g:operator#surround#ignore_space = 0
let g:operator#surround#uses_input_if_no_block = 0

let g:operator#surround#blocks =
\ {
\   '-' : [
\       { 'block' : ['(', ')'], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['p'] },
\       { 'block' : ['[', ']'], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['l'] },
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
\       { 'block' : ['「', '」'], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['L'] },
\       { 'block' : ['（', '）'], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['P'] },
\       { 'block' : ["```\n", "\n\n\<C-u>```"], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['c'] },
\       { 'block' : ["<pre>\n", "\n\n\<C-u></pre>"], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['apre'] },
\   ],
\ }
