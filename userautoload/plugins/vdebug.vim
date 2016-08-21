let s:bundle=neobundle#get('vdebug')
function! s:bundle.hooks.on_source(bundle)

    let s:ACTION_KEY = "action"
    let s:SUFFIX_KEY = "suffix"
    let s:vdebug_keymap_infos = [
    \    {s:SUFFIX_KEY : "r", s:ACTION_KEY : "run"},
    \    {s:SUFFIX_KEY : "c", s:ACTION_KEY : "run_to_cursor"},
    \    {s:SUFFIX_KEY : "s", s:ACTION_KEY : "step_over"},
    \    {s:SUFFIX_KEY : "i", s:ACTION_KEY : "step_into"},
    \    {s:SUFFIX_KEY : "o", s:ACTION_KEY : "step_out"},
    \    {s:SUFFIX_KEY : "x", s:ACTION_KEY : "close"},
    \    {s:SUFFIX_KEY : "d", s:ACTION_KEY : "detach"},
    \    {s:SUFFIX_KEY : "b", s:ACTION_KEY : "set_breakpoint"},
    \    {s:SUFFIX_KEY : "g", s:ACTION_KEY : "get_context"},
    \    {s:SUFFIX_KEY : "e", s:ACTION_KEY : "eval_under_cursor"},
    \    {s:SUFFIX_KEY : "v", s:ACTION_KEY : "eval_visual"}
    \]

    function! s:set_vdebug_keymap(prefix_key) abort
        let keymap = {}
        for info in s:vdebug_keymap_infos
            let keymap[info[s:ACTION_KEY]] = a:prefix_key . info[s:SUFFIX_KEY]
        endfor
        let g:vdebug_keymap = keymap
    endfunction
    call s:set_vdebug_keymap("<Space>d")

    let g:vdebug_options= {
    \    "timeout" : 10,
    \    "on_close" : 'detach',
    \    "break_on_open" : 0,
    \    "debug_window_level" : 0,
    \    "debug_file_level" : 0,
    \    "debug_file" : "",
    \    "watch_window_style" : 'expanded',
    \    "marker_closed_tree" : '▸',
    \    "marker_open_tree" : '▾'
    \}
    if exists("*g:VdebugLocalSetting")
        call VdebugLocalSetting()
    endif
endfunction
unlet s:bundle

nnoremap [vdebug] <Nop>
nmap <Space>d [vdebug]

nnoremap [vdebug]a :<C-u>BreakpointRemove *<CR>
