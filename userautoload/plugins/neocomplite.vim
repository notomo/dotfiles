
" �N�����ɗL����
let g:neocomplete#enable_at_startup = 1
" �啶�������͂����܂ő啶���������̋�ʂ𖳎�����
let g:neocomplete#enable_smart_case = 1
" _(�A���_�[�X�R�A)��؂�̕⊮��L����
let g:neocomplete#enable_underbar_completion = 1
let g:neocomplete#enable_camel_case_completion  =  1
" �|�b�v�A�b�v���j���[�ŕ\���������̐�
let g:neocomplete#max_list = 20
" �V���^�b�N�X���L���b�V������Ƃ��̍ŏ�������
let g:neocomplete#sources#syntax#min_keyword_length = 3
" �⊮��\������ŏ�������
let g:neocomplete#auto_completion_start_length = 2
let g:neocomplete#enable_complete_select = 1
let g:neocomplete#enable_auto_select = 0


if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'
