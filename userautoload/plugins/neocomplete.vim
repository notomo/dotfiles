
let s:bundle=neobundle#get('neocomplete.vim')
function! s:bundle.hooks.on_source(bundle)
    " �N�����ɗL����
    let g:neocomplete#enable_at_startup = 1
    " �啶�������͂����܂ő啶���������̋�ʂ𖳎�����
    let g:neocomplete#enable_smart_case = 1
    " _(�A���_�[�X�R�A)��؂�̕⊮��L����
    let g:neocomplete#enable_underbar_completion = 1
    let g:neocomplete#enable_camel_case_completion  =  1
    " �|�b�v�A�b�v���j���[�ŕ\���������̐�
    let g:neocomplete#max_list = 8
    " �V���^�b�N�X���L���b�V������Ƃ��̍ŏ�������
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    " �⊮��\������ŏ�������
    let g:neocomplete#auto_completion_start_length = 3
    let g:neocomplete#enable_complete_select = 1
    let g:neocomplete#enable_auto_select = 0


    let g:neocomplete#enable_auto_close_preview        = 3
    let g:neocomplete#enable_auto_delimiter            = 1

    let g:neocomplete#delimiter_patterns               = {'php': ['->', '::', '\']}
    let g:neocomplete#max_keyword_width                = 30
    " let g:neocomplete#sources                          = {'_': ['file','neosnippet','dictionary','buffer']}
    let g:neocomplete#sources                          = {'_': ['dictionary','file','neosnippet','buffer']}

    " ���[�U�[��`�X�j�y�b�g�ۑ��f�B���N�g��
    let g:neocomplete#snippets_dir ='~/.vim/snippets'

    let g:neocomplete#sources#buffer#cache_limit_size  = 50000
    let g:neocomplete#sources#buffer#max_keyword_width = 30
    let g:neocomplete#sources#dictionary#dictionaries  = {'_': '', 'php': '~/.vim/dict/php.dict'}
    let g:neocomplete#use_vimproc                      = 1

    if !exists('g:neocomplete#force_omni_input_patterns')
            let g:neocomplete#force_omni_input_patterns = {}
    endif

    " let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'
endfunction
unlet s:bundle
