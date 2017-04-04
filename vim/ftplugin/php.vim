
if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

let s:undo_ftplugin = ''
if exists('b:undo_ftplugin')
    let s:undo_ftplugin = b:undo_ftplugin
endif

