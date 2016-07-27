" if version < 600
"   syntax clear
" elseif exists('g:current_after_syntax')
"   finish
" endif

" We need nocompatible mode in order to continue lines with backslashes.
" Original setting will be restored.
let s:cpo_save = &cpo
set cpo&vim

syn match pythonOperator "\(+\|=\|-\|\^\|\*\)"
syn match pythonDelimiter "\(,\|\.\|:\)"
syn keyword pythonSpecialWord self
syn keyword pythonSpecialWord cls


hi link pythonSpecialWord    Special
hi link pythonDelimiter      Special
syn match pythonConstant "[A-Z0-9]\{1,}_[A-Z0-9]\{1,}\(_[A-Z0-9]\{1,}\)\{0,}\|\([a-z]\)\@<![A-Z0-9]\{2,}"
syn match pythonClass "\([A-Za-z][A-Za-z0-9]\{0,}[A-Z][a-z0-9]\{1,}\)\{1,}\|[A-Z][a-z0-9]\{1,}\([a-z0-9]\{0,}[A-Z]\{2,}\)\@!"
hi link pythonClass pythonFunction
hi link pythonConstant Constant

hi link pythonSpecialWord    Special
hi link pythonDelimiter      Special

" let g:current_after_syntax = 'python'

let &cpo = s:cpo_save
unlet s:cpo_save
