let s:bundle=neobundle#get('omnisharp-vim')
function! s:bundle.hooks.on_source(bundle)
    let g:OmniSharp_host = "http://localhost:2000"
    " let g:OmniSharp_server_type = 'v1'
    let g:OmniSharp_server_type = 'roslyn'
    let g:OmniSharp_timeout = 1
    let g:OmniSharp_selector_ui = 'unite'  " Use unite.vim
    let g:Omnisharp_stop_server = 0
    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
    endif

    let g:neocomplete#sources#omni#input_patterns.cs = '.*[^=\);]'
    " let g:neocomplete#sources#omni#input_patterns.cs = '[^.]\.\%(\u\{2,}\)\?'
    let g:OmniSharp_start_without_solution = 1

    let g:OmniSharp_typeLookupInPreview = 1
endfunction
unlet s:bundle
