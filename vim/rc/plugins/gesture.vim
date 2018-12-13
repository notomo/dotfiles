call gesture#clear()

let s:y_long_gesture_length = 20
let s:x_long_gesture_length = 40

call gesture#register().up().down().noremap('G')
call gesture#register().down().up().noremap('gg')
call gesture#register().down().right().map('[exec]f')
call gesture#register().right().down().left().map('p')

call gesture#register().up({'min_length' : s:y_long_gesture_length}).map('[tab]t')

call gesture#register().right({'max_length' : s:x_long_gesture_length}).map('[tab]l')
call gesture#register().right({'min_length' : s:x_long_gesture_length}).map('[tab]e')

call gesture#register().left({'max_length' : s:x_long_gesture_length}).map('[tab]a')
call gesture#register().left({'min_length' : s:x_long_gesture_length}).map('[tab]s')

call gesture#register().down().left().map('[tab]q')
call gesture#register().right().left().map('go')
call gesture#register().left().right().map('gi')
call gesture#register().down().left().down().map('[win]o')
call gesture#register().down().left().down().left().map('[tab]o')
