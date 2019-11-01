
command! -bar LightlineUpdate call lightline#init()| call lightline#colorscheme()| call lightline#update()

let s:enable = {}
let s:enable.tabline = 0
let s:enable.statusline = 1
let s:active = {}

let s:active.left = [['filepath'], ['gitbranch']]

let s:active.right = [['mode'], ['fileinfo'], ['vimonga'], ['position']]
let s:inactive = {}
let s:inactive.right = [[]]
let s:inactive.left = s:active.left
let s:component_function = {}
let s:component_function.mode = 'LightlineMode'
let s:component_function.gitbranch = 'LightlineGitBranch'
let s:component_function.fileinfo = 'LightlineFileInfo'
let s:component_function.position = 'LightlinePosition'
let s:component_function.vimonga = 'LightlineVimonga'
let s:component_function.filepath = 'LightlineFilePath'
let g:lightline = {'enable': s:enable, 'active': s:active, 'inactive': s:inactive, 'component_function': s:component_function, }

function! s:surround(value) abort
    return '[' . a:value . ']'
endfunction

function! LightlineVimonga()
    if !has('nvim') || !exists('*vimonga#status')
        return ''
    endif

    let status = vimonga#status('documents')
    if empty(status)
        return ''
    endif

    let first = status['first_number']
    let last = status['last_number']
    let prev = status['is_first'] ? '' : '<'
    let next = status['is_last'] ? '' : '>'
    return printf('%s %d ~ %d / %d %s', prev, first, last, status['count'], next)
endfunction

function! LightlineGitBranch()
    if &filetype ==? 'defx'
        return ''
    endif
    let branch = gina#component#repo#branch()
    if empty(branch)
        return ''
    endif
    return s:surround(branch)
endfunction

function! LightlineFileInfo()
    if &filetype =~? 'defx\|denite'
        return ''
    endif
    return s:surround(&fileencoding . ':' . &fileformat . ':' . &filetype)
endfunction

function! LightlinePosition()
    if &filetype ==? 'defx'
        return ''
    elseif &filetype ==? 'denite-filter'
        return denite#get_status('line_total')
    elseif &filetype ==? 'denite'
        return line('.') . '/' . line('$')
    endif
    return s:surround(col('.'))
endfunction

function! LightlineFilePath()
    return expand('%:p:~')
endfunction

function! LightlineMode()
    if &filetype ==? 'defx'
        return ''
    endif
    return lightline#mode()
endfunction

let g:lightline.colorscheme = 'spring_night'
let s:p = {'inactive': {}, 'normal': {}, 'insert': {}, 'select': {}, 'visual': {}, 'tabline': {}}

let s:inactive_base = ['#7e8d9b', '#3a4b5c']
let s:p.inactive.middle = [s:inactive_base]
let s:p.inactive.left = [s:inactive_base]
let s:p.inactive.right = [s:inactive_base, s:inactive_base, s:inactive_base]

let s:fore = '#fffeeb'
let s:normal_base = [s:fore, '#536273']

let s:p.normal.middle = [s:normal_base]
let s:p.normal.right = [[s:fore, '#798fab'], s:normal_base, s:normal_base]
let s:p.normal.left = [s:normal_base, s:normal_base, s:normal_base]

let s:p.insert.middle = s:p.normal.middle
let s:p.insert.right = [[s:fore, '#6a9681'], s:normal_base, s:normal_base]
let s:p.insert.left = s:p.normal.left

let s:p.select = s:p.insert

let s:p.visual.middle = s:p.normal.middle
let s:p.visual.right = [[s:fore, '#b0817c'], s:normal_base, s:normal_base]
let s:p.visual.left = s:p.normal.left

let g:lightline#colorscheme#spring_night#palette = lightline#colorscheme#fill(s:p)

