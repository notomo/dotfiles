
noremap [surround] <Nop>
map s [surround]
map <silent>[surround]a <Plug>(operator-surround-append)
map <silent>[surround]d <Plug>(operator-surround-delete)
map <silent>[surround]r <Plug>(operator-surround-replace)

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
\       { 'block' : ['`', '`'], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['b'] },
\       { 'block' : ['【', '】'], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['D'] },
\       { 'block' : ['「', '」'], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['L'] },
\       { 'block' : ['『', '』'], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['T'] },
\       { 'block' : ['（', '）'], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['P'] },
\   ]
\ }
