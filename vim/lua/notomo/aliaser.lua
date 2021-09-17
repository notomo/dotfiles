local aliaser = require("aliaser")

aliaser.register_factory("thetto", function(aliases)
  aliases:set("assigned_issues", function()
    require("thetto").start("github/issue", {source_opts = {assignee = "me"}})
  end)
end)

aliaser.register_factory("vim", function(aliases)
  aliases:set("clear_messages", "messages clear")
end)
