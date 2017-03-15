
for s:mode_char in ['n', 'v']
    call gina#custom#mapping#map(
    \ 'status', '[git]a',
    \ '<Plug>(gina-index-toggle)',
    \ {'mode' : s:mode_char, 'silent' : 1},
    \)

    call gina#custom#mapping#map(
    \ 'status', '[git]u',
    \ '<Plug>(gina-index-unstage)',
    \ {'mode' : s:mode_char, 'silent' : 1},
    \)

    call gina#custom#mapping#map(
    \ 'status', 'U',
    \ '<Plug>(gina-index-discard)',
    \ {'mode' : s:mode_char, 'silent' : 1},
    \)
endfor

call gina#custom#mapping#nmap(
\ 'status', 'cc',
\ ':<C-u>Gina commit<CR>',
\ {'noremap' : 1, 'silent' : 1},
\)

call gina#custom#mapping#nmap(
\ 'status', 'ca',
\ '<Plug>(gina-commit-amend)',
\ {'silent' : 1},
\)

call gina#custom#mapping#nmap(
\ 'status', 'dd',
\ '<Plug>(gina-compare)',
\ {'silent' : 1},
\)

call gina#custom#mapping#nmap(
\ 'status', 'D',
\ '<Plug>(gina-diff)',
\ {'silent' : 1},
\)

call gina#custom#command#option(
\ '/\%(status\|changes\|ls\)',
\ '--opener', 'botright split'
\)

call gina#custom#command#option(
\ '/\%(diff\|blame\|compare\|branch\|log\)',
\ '--opener', 'tabedit'
\)
