if exists('b:current_syntax')
  finish
endif

syn match jesponsiv2Comment "//.\{-}\(?>\|$\)\@="
hi def link jesponsiv2Comment Comment

let b:current_syntax = 'jesponsiv2'
