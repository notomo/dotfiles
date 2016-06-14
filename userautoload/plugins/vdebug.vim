
let s:bundle=neobundle#get('vdebug')
function! s:bundle.hooks.on_source(bundle)
    let g:vdebug_keymap = {
    \    "run" : "<Space>dr",
    \    "run_to_cursor" : "<Space>dc",
    \    "step_over" : "<Space>ds",
    \    "step_into" : "<Space>di",
    \    "step_out" : "<Space>do",
    \    "close" : "<Space>dx",
    \    "detach" : "<Space>dd",
    \    "set_breakpoint" : "<Space>db",
    \    "get_context" : "<Space>dg",
    \    "eval_under_cursor" : "<Space>de",
    \    "eval_visual" : "<Space>dv",
    \}
	if exists("g:vdebug_office")
		call SetupVdebugOffice()
	endif
endfunction
unlet s:bundle

nnoremap [vdebug] <Nop>
nmap <Space>d [vdebug]

nnoremap [vdebug]a :<C-u>BreakpointRemove *<CR>
