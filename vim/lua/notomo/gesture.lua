local gesture = require("gesture")
gesture.register({
  name = "scroll to bottom",
  inputs = { gesture.up(), gesture.down() },
  action = "normal! G",
})
gesture.register({
  name = "scroll to top",
  inputs = { gesture.down(), gesture.up() },
  action = "normal! gg",
})
gesture.register({
  name = "open filer",
  inputs = { gesture.down(), gesture.right() },
  action = "normal [exec]f",
})
gesture.register({
  name = "paste",
  inputs = { gesture.right(), gesture.down(), gesture.left() },
  action = "normal p",
})
gesture.register({
  name = "split window vertically",
  inputs = { gesture.down(), gesture.right(), gesture.up() },
  action = "normal [win]v",
})
gesture.register({ name = "new tab", inputs = { gesture.up() }, action = "normal [tab]t" })
gesture.register({ name = "new tab", inputs = { gesture.down() }, action = "normal [tab]t" })
gesture.register({
  name = "next tab",
  inputs = { gesture.right({ max_length = 40 }) },
  action = "normal [tab]l",
})
gesture.register({
  name = "last tab",
  inputs = { gesture.right({ min_length = 40 }) },
  action = "normal [tab]e",
})
gesture.register({
  name = "previous tab",
  inputs = { gesture.left({ max_length = 40 }) },
  action = "normal [tab]a",
})
gesture.register({
  name = "first tab",
  inputs = { gesture.left({ min_length = 40 }) },
  action = "normal [tab]s",
})
gesture.register({
  name = "close tab",
  inputs = { gesture.down(), gesture.left() },
  action = "normal [tab]q",
})
gesture.register({
  name = "go back",
  inputs = { gesture.right(), gesture.left() },
  action = "normal go",
})
gesture.register({
  name = "go forward",
  inputs = { gesture.left(), gesture.right() },
  action = "normal gi",
})
gesture.register({
  name = "close the other windows",
  inputs = { gesture.down(), gesture.left(), gesture.down() },
  action = "normal [win]o",
})
gesture.register({
  name = "close the other tabs",
  inputs = { gesture.down(), gesture.left(), gesture.down(), gesture.left() },
  action = "normal [tab]o",
})
gesture.register({
  name = "open todo files",
  inputs = { gesture.left(), gesture.down(), gesture.right() },
  action = "normal [exec]do",
})
gesture.register({
  name = "open pie menu",
  inputs = { gesture.up(), gesture.right() },
  action = function(ctx)
    require("piemenu").start("default", { position = ctx.last_position })
  end,
  nowait = true,
})
