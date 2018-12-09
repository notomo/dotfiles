let g:python_highlight_all = 1
let g:markdown_fenced_languages = [
\  'vim',
\]
let g:ft_ignroe_pat = '\.\(Z\|gz\|bz2\|zip\|tgz\|log\)$'

autocmd MyAuGroup FileType python call s:python()
function! s:python() abort
    setlocal completeopt-=preview
    setlocal nomodeline
    let b:cursorword = 0
    call notomo#python#semshi_mapping()
endfunction

autocmd MyAuGroup FileType qfreplace call s:qfreplace()
function! s:qfreplace() abort
    setlocal nomodeline
endfunction

autocmd MyAuGroup FileType php call s:php()
function! s:php() abort
    setlocal noexpandtab
    setlocal matchpairs+==:;
    setlocal completeopt-=preview
    setlocal dictionary=~/dotfiles/vim/dict/php.dict
    if match(fnamemodify(expand('%'), ':t'), '^\k\+Test.php$') != -1
        setlocal dictionary+=~/dotfiles/vim/dict/phpunit.dict
        setlocal dictionary+=~/dotfiles/vim/dict/mockery.dict
    else
        setlocal dictionary-=~/dotfiles/vim/dict/phpunit.dict
        setlocal dictionary-=~/dotfiles/vim/dict/mockery.dict
    endif

    if exists('loaded_matchit')
        call notomo#matchit#sql()
    endif

    let b:textobj_function_select = function('textobj#function#java#select')

    nnoremap <buffer> [keyword]T :<C-u>ALEGoToDefinitionInTab<CR>
endfunction

autocmd MyAuGroup FileType smarty call s:smarty()
function! s:smarty() abort
    setlocal noexpandtab

    if exists('loaded_matchit')
        call notomo#matchit#smarty()
    endif
endfunction

autocmd MyAuGroup FileType sql call s:sql()
function! s:sql() abort
    if exists('loaded_matchit')
        call notomo#matchit#sql()
    endif
endfunction

autocmd MyAuGroup FileType neosnippet call s:neosnippet()
function! s:neosnippet() abort
    setlocal noexpandtab
endfunction

autocmd MyAuGroup FileType vim call s:vim()
function! s:vim() abort
    setlocal foldmethod=marker
    if exists('loaded_matchit')
        call notomo#matchit#vim()
    endif
    setlocal iskeyword-=#
endfunction

autocmd MyAuGroup FileType help call s:help()
function! s:help() abort
    if &l:buftype !=# 'help'
        setlocal list tabstop=8 shiftwidth=8 softtabstop=8 noexpandtab textwidth=78
        if exists('+colorcolumn')
            setlocal colorcolumn=+1
        endif
        if has('conceal')
            setlocal conceallevel=0
        endif
    endif
endfunction

autocmd MyAuGroup FileType xml call s:xml()
function! s:xml() abort
    setlocal noexpandtab
endfunction

autocmd MyAuGroup FileType blade call s:blade()
function! s:blade() abort
    let b:caw_wrap_oneline_comment = ['{{--', '--}}']
    setlocal expandtab
endfunction

autocmd MyAuGroup FileType markdown call s:markdown()
function! s:markdown() abort
    nmap <buffer> <Space>c <Plug>(caw:wrap:toggle:operator)_
    xmap <buffer> <Space>c <Plug>(caw:wrap:toggle:operator)
endfunction

autocmd MyAuGroup FileType Jenkinsfile call s:Jenkinsfile()
function! s:Jenkinsfile() abort
    let b:caw_oneline_comment = '//'
    let b:caw_wrap_oneline_comment = ['//']
    setlocal noexpandtab
endfunction

autocmd MyAuGroup FileType groovy call s:groovy()
function! s:groovy() abort
    setlocal noexpandtab
endfunction

autocmd MyAuGroup FileType cs call s:cs()
function! s:cs() abort
    setlocal completeopt-=preview
    setlocal expandtab
endfunction

autocmd MyAuGroup FileType ruby call s:ruby()
function! s:ruby() abort
    setlocal tabstop=2
    setlocal softtabstop=2
endfunction

autocmd MyAuGroup FileType go call s:go()
function! s:go() abort
    setlocal completeopt-=preview
    setlocal noexpandtab
    nnoremap <buffer> [keyword]o :<C-u>GoDef<CR>
    nnoremap <buffer> [keyword]v :<C-u>vsplit \| GoDef<CR>
    nnoremap <buffer> [keyword]h :<C-u>split \| GoDef<CR>
    nnoremap <buffer> [keyword]t :<C-u>call notomo#window#duplicate() \| GoDef<CR>
    nmap <buffer> [keyword]k <Plug>(go-info)
    nmap <buffer> sgj ]]
    nmap <buffer> sgk [[
    nnoremap <buffer> [exec]bl :<C-u>GoBuild<CR>
    nnoremap <buffer> [exec]gr :<C-u>GoReferrers<CR>
    nnoremap <buffer> [exec]gi :<C-u>GoImplements<CR>
    nnoremap <buffer> [test]g :<C-u>GoCoverageToggle<CR>
    nnoremap <buffer> [denite]o :<C-u>Denite decls -auto-preview<CR>
    nnoremap <buffer> [denite]gp :<C-u>DeniteCursorWord go/package -no-empty -immediately-1<CR>
endfunction

autocmd MyAuGroup FileType gina-commit call s:gina_commit()
function! s:gina_commit() abort
    setlocal spell
endfunction

autocmd MyAuGroup FileType javascript call s:javascript()
function! s:javascript() abort
    setlocal completeopt-=preview
    setlocal tabstop=2
    setlocal softtabstop=2
    setlocal expandtab
endfunction

autocmd MyAuGroup FileType typescript call s:typescript()
function! s:typescript() abort
    setlocal nomodeline
    setlocal completeopt-=preview
    setlocal tabstop=2
    setlocal softtabstop=2
    setlocal expandtab
    nnoremap <buffer> [keyword]k :<C-u>TSType<CR>
    nnoremap <buffer> [keyword]K :<C-u>TSDoc<CR>
    nnoremap <buffer> [keyword]R :<C-u>TSRefs<CR>
    nnoremap <buffer> [keyword]o :<C-u>TSDef<CR>
    nnoremap <buffer> [keyword]v :<C-u>vsplit \| TSDef<CR>
    nnoremap <buffer> [keyword]h :<C-u>split \| TSDef<CR>
    nnoremap <buffer> [keyword]t :<C-u>call notomo#window#duplicate() \| TSDef<CR>
    TSStart
endfunction

autocmd MyAuGroup FileType ansible call s:ansible()
function! s:ansible() abort
    setlocal tabstop=2
    setlocal softtabstop=2
    setlocal expandtab
endfunction

autocmd MyAuGroup FileType ejs call s:ejs()
function! s:ejs() abort
    let b:caw_wrap_oneline_comment = ['<%#', '%>']
    setlocal tabstop=2
    setlocal softtabstop=2
    setlocal expandtab
    if exists('loaded_matchit')
        call notomo#matchit#ejs()
    endif
endfunction

autocmd MyAuGroup FileType vue call s:vue()
function! s:vue() abort
    setlocal tabstop=2
    setlocal softtabstop=2
    setlocal expandtab
    if exists('loaded_matchit')
        call notomo#matchit#ejs()
    endif
endfunction
