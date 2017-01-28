scriptencoding utf-8

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
\       { 'block' : ['（', '）'], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['P'] },
\   ],
\   'markdown' : [
\       { 'block' : ['_', '_'], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['s'] },
\       { 'block' : ['~~', '~~'], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['T'] },
\       { 'block' : ['**', '**'], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['x'] },
\   ]
\ }
