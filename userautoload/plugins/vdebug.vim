
let s:bundle=neobundle#get('vdebug')
function! s:bundle.hooks.on_source(bundle)
    let g:vdebug_keymap = {
    \    "run" : "<Nop>",
    \    "run_to_cursor" : "<Nop>",
    \    "step_over" : "<Nop>",
    \    "step_into" : "<Nop>",
    \    "step_out" : "<Nop>",
    \    "close" : "<Nop>",
    \    "detach" : "<Nop>",
    \    "set_breakpoint" : "<Nop>",
    \    "get_context" : "<Nop>",
    \    "eval_under_cursor" : "<Nop>",
    \}
endfunction
unlet s:bundle
