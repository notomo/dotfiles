if exists('g:loaded_altr_test')
    finish
endif
let g:loaded_altr_test = 1

if !exists('g:altr_test_patterns')
    let g:altr_test_patterns = {}
endif
let g:altr_test_patterns['go'] = {'app': '%.go', 'test': '%_test.go'}
