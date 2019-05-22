call gesture#clear()

let s:x_long_gesture_length = 40

call gesture#register({'name': 'scroll to bottom'}).up().down().noremap('G')
call gesture#register({'name': 'scroll to top'}).down().up().noremap('gg')
call gesture#register({'name': 'open filer'}).down().right().map('[exec]f')
call gesture#register({'name': 'paste'}).right().down().left().map('p')

call gesture#register({'name': 'split window vertically'}).down().right().up().map('[win]v')

call gesture#register({'name': 'new tab'}).up().map('[tab]t')
call gesture#register({'name': 'new tab'}).down().map('[tab]t')

call gesture#register({'name': 'next tab'}).right({'max_length' : s:x_long_gesture_length}).map('[tab]l')
call gesture#register({'name': 'last tab'}).right({'min_length' : s:x_long_gesture_length}).map('[tab]e')

call gesture#register({'name': 'previous tab'}).left({'max_length' : s:x_long_gesture_length}).map('[tab]a')
call gesture#register({'name': 'first tab'}).left({'min_length' : s:x_long_gesture_length}).map('[tab]s')

call gesture#register({'name': 'close tab'}).down().left().map('[tab]q')
call gesture#register({'name': 'go back'}).right().left().map('go')
call gesture#register({'name': 'go forward'}).left().right().map('gi')
call gesture#register({'name': 'close the other windows'}).down().left().down().map('[win]o')
call gesture#register({'name': 'close the other tabs'}).down().left().down().left().map('[tab]o')

call gesture#register({'name': 'open the recent file'}).up().right().map('[denite]ud')
call gesture#register({'name': 'open todo'}).right().text('KEY_A').map('[exec]t', {'nowait' : v:true})

" left hand keyboard gesture
nnoremap <expr> a notomo#gesture#key('a', 'KEY_A')

call gesture#custom#set('enabled_input_view', v:true)
