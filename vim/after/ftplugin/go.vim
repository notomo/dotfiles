setlocal completeopt-=preview
setlocal noexpandtab
nnoremap <buffer> [keyword]o :<C-u>GoDef<CR>
nnoremap <buffer> [keyword]v :<C-u>vsplit \| GoDef<CR>
nnoremap <buffer> [keyword]h :<C-u>split \| GoDef<CR>
nnoremap <buffer> [keyword]t :<C-u>call notomo#window#duplicate() \| GoDef<CR>
nmap <buffer> [keyword]k <Plug>(go-info)

nnoremap <buffer> <silent> sgj :<C-u>call go#textobj#FunctionJump('n', 'next')<CR>
nnoremap <buffer> <silent> sgk :<C-u>call go#textobj#FunctionJump('n', 'prev')<CR>
xnoremap <buffer> <silent> sgj :<C-u>call go#textobj#FunctionJump('v', 'next')<CR>
xnoremap <buffer> <silent> sgk :<C-u>call go#textobj#FunctionJump('v', 'prev')<CR>

nnoremap <buffer> [exec]bL :<C-u>GoBuild<CR>
nnoremap <buffer> [exec]gr :<C-u>GoReferrers<CR>
nnoremap <buffer> [exec]gi :<C-u>GoImplements<CR>
nnoremap <buffer> [test]g :<C-u>GoCoverageToggle<CR>
nnoremap <buffer> [denite]o :<C-u>Denite decls<CR>

onoremap <buffer> <silent> af :<C-u>call go#textobj#Function('a')<CR>
xnoremap <buffer> <silent> af :<C-u>call go#textobj#Function('a')<CR>
onoremap <buffer> <silent> if :<C-u>call go#textobj#Function('i')<CR>
xnoremap <buffer> <silent> if :<C-u>call go#textobj#Function('i')<CR>
onoremap <buffer> <silent> ac :<C-u>call go#textobj#Comment('a')<CR>
xnoremap <buffer> <silent> ac :<C-u>call go#textobj#Comment('a')<CR>
onoremap <buffer> <silent> ic :<C-u>call go#textobj#Comment('i')<CR>
xnoremap <buffer> <silent> ic :<C-u>call go#textobj#Comment('i')<CR>
