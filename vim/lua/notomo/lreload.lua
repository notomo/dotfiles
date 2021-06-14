local modules = {
  "reacher",
  "cmdbuf",
  "wintablib",
  "nvimtool",
  "kivi",
  "flompt",
  "gesture",
  "searcho",
  "filetypext",
  "cmdhndlr",
  "suball",
  "notomo",
}
for _, m in ipairs(modules) do
  require("lreload").enable(m)
end
