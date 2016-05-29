
let s:bundle=neobundle#get('vdebug')
function! s:bundle.hooks.on_source(bundle)
    let g:vdebug_keymap = {
    \    "run" : "<Leader>dr",
    \    "run_to_cursor" : "<Leader>dc",
    \    "step_over" : "<Leader>ds",
    \    "step_into" : "<Leader>di",
    \    "step_out" : "<Leader>do",
    \    "close" : "<Leader>dx",
    \    "detach" : "<Leader>dd",
    \    "set_breakpoint" : "<Leader>db",
    \    "get_context" : "<Leader>dg",
    \    "eval_under_cursor" : "<Leader>de",
    \}
endfunction
unlet s:bundle
