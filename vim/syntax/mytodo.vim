if exists('b:current_syntax')
    finish
endif

syntax match mytodoDone "^\s*#.*"
highlight default link mytodoDone Comment

let b:current_syntax = 'mytodo'
