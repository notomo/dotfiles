
command! -bar LightlineUpdate call lightline#init()| call lightline#colorscheme()| call lightline#update()

let s:enable = {}
let s:enable.tabline = 0
let s:enable.statusline = 1
let s:active = {}

" for gesture debug
" let s:active.left = [['mode'], ['position_map'], ['position'], ['gesture_lines']]
let s:active.left = [['mode'], ['position_map'], ['position'], ['vimonga']]

let s:active.right = [['gitbranch'], ['fileinfo'], ['filepath']]
let s:inactive = {}
let s:inactive.left = [[]]
let s:inactive.right = s:active.right
let s:component_function = {}
let s:component_function.mode = 'LightlineMode'
let s:component_function.gitbranch = 'LightlineGitBranch'
let s:component_function.fileinfo = 'LightlineFileInfo'
let s:component_function.position = 'LightlinePosition'
let s:component_function.position_map = 'LightlinePositionMap'
let s:component_function.gesture_lines = 'LightlineGestureLines'
let s:component_function.vimonga = 'LightlineVimonga'
let s:component_function.filepath = 'LightlineFilePath'
let g:lightline = {'enable': s:enable, 'active': s:active, 'inactive': s:inactive, 'component_function': s:component_function, }

function! s:surround(value) abort
    return '[' . a:value . ']'
endfunction

function! LightlineVimonga()
    if !exists('*vimonga#status')
        return ''
    endif

    let doc_count = vimonga#status('document', 'count')
    if empty(doc_count)
        return ''
    endif

    let first = vimonga#status('document', 'first_number')
    let last = vimonga#status('document', 'last_number')
    let prev = vimonga#status('document', 'is_first') ? '' : '<'
    let next = vimonga#status('document', 'is_last') ? '' : '>'
    return printf('%s %d ~ %d / %d %s', prev, first, last, doc_count, next)
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
    elseif &filetype ==? 'denite'
        return denite#get_status('linenr')
    endif
    return s:surround(col('.'))
endfunction

function! LightlinePositionMap()
    if &filetype ==? 'denite'
        return ''
    endif

    if winwidth(0) < 100
        return ''
    endif

    let current = line('.')
    let line_count = line('$')
    let length = 20

    let currentPosition = float2nr(round(current * 1.0 / line_count * length))

    let otherMark = '-'
    let otherLine = repeat(otherMark, length)

    let front = currentPosition == 0 ? '' :  otherLine[:currentPosition - 1]
    let rear = otherLine[currentPosition :]
    let line =  front . '+' . rear

    return s:surround(line)
endfunction

function! LightlineGestureLines()
    if !has('nvim') || &filetype =~? 'defx\|denite'
        return ''
    endif
    let directions = map(gesture#get_inputs(), { _, v -> v.value })
    return s:surround(join(directions, ','))
endfunction

function! LightlineFilePath()
    return expand('%:p:~')
endfunction

function! LightlineMode()
    if &filetype ==? 'defx'
        return ''
    elseif &filetype ==? 'denite'
        " '-- NORMAL --' or '-- INSERT --' or ...
        let mode = substitute(denite#get_status('mode'), '-\| ', '', 'g')
        call lightline#link(tolower(mode[0]))
        return mode
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
let s:p.normal.left = [[s:fore, '#798fab'], s:normal_base, s:normal_base]
let s:p.normal.right = [s:normal_base, s:normal_base, s:normal_base]

let s:p.insert.middle = s:p.normal.middle
let s:p.insert.left = [[s:fore, '#6a9681'], s:normal_base, s:normal_base]
let s:p.insert.right = s:p.normal.right

let s:p.select = s:p.insert

let s:p.visual.middle = s:p.normal.middle
let s:p.visual.left = [[s:fore, '#b0817c'], s:normal_base, s:normal_base]
let s:p.visual.right = s:p.normal.right

let g:lightline#colorscheme#spring_night#palette = lightline#colorscheme#fill(s:p)

