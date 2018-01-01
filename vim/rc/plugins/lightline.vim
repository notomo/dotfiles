
command! -bar LightlineUpdate call lightline#init()| call lightline#colorscheme()| call lightline#update()

let s:enable = {}
let s:enable.tabline = 0
let s:enable.statusline = 1
let s:active = {}
let s:active.left = [['mode'], ['column']]
let s:active.right = [['gitbranch'], ['fileinfo'], ['filepath']]
let s:component_function = {}
let s:component_function.gitbranch = 'LightlineGitBranch'
let s:component_function.fileinfo = 'LightlineFileInfo'
let s:component_function.column = 'LightlineColumn'
let s:component_function.filepath = 'LightlineFilePath'
let g:lightline = {'enable': s:enable, 'active': s:active, 'inactive': s:active, 'component_function': s:component_function, }

function! s:surround(value) abort
    return '[' . a:value . ']'
endfunction

function! LightlineGitBranch()
  return s:surround(gina#component#repo#branch())
endfunction

function! LightlineFileInfo()
  return s:surround(&fileencoding . ':' . &fileformat . ':' . &filetype)
endfunction

function! LightlineColumn()
  return s:surround(col('.'))
endfunction

function! LightlineFilePath()
    return expand('%:p:~')
endfunction


let g:lightline.colorscheme = 'spring_night'
let s:p = {'inactive': {}, 'normal': {}, 'insert': {}, 'select': {}, 'visual': {}, 'tabline': {}}

let s:inactive_base = ['#7e8d9b', '#3a4b5c']
let s:p.inactive.middle = [s:inactive_base]
let s:p.inactive.left = [s:inactive_base, s:inactive_base]
let s:p.inactive.right = [s:inactive_base, s:inactive_base, s:inactive_base]

let s:fore = '#fffeeb'
let s:normal_base = [s:fore, '#536273']

let s:p.normal.middle = [s:normal_base]
let s:p.normal.left = [[s:fore, '#798fab'], s:normal_base]
let s:p.normal.right = [s:normal_base, s:normal_base, s:normal_base]

let s:p.insert.middle = s:p.normal.middle
let s:p.insert.left = [[s:fore, '#6a9681'], s:normal_base]
let s:p.insert.right = s:p.normal.right

let s:p.select = s:p.insert

let s:p.visual.middle = s:p.normal.middle
let s:p.visual.left = [[s:fore, '#b0817c'], s:normal_base, s:normal_base]
let s:p.visual.right = s:p.normal.right

let g:lightline#colorscheme#spring_night#palette = lightline#colorscheme#fill(s:p)

