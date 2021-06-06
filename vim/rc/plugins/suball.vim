nnoremap <expr> [substitute]aw ':%' . suball#input(expand('<cword>'), "")
nnoremap <expr> [substitute]ay ':%' . suball#input(@+, "")
