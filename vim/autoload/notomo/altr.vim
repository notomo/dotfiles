
let g:notomo#altr#test_patterns = {}
let g:notomo#altr#test_patterns['go'] = {'app': '%.go', 'test': '%_test.go'}

" HACk
function! notomo#altr#new() abort
    let pattern = g:notomo#altr#test_patterns[&filetype]['app']
    let rule = get(altr#_rule_table(), pattern, 0)
    let altr_pattern = rule['back_pattern']
    if altr_pattern !=? rule['forward_pattern']
        echomsg 'Invalid test pattern'
        return
    endif
    let [result, match] =  altr#_match_with_buffer_name(rule, expand('%:p'))
    if !result
        echomsg 'Not match'
        return
    endif
    let path = altr#_glob_path_from_pattern(altr_pattern, match)
    execute 'edit ' . path
endfunction
