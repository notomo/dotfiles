local modules = {
  "reacher",
  "cmdbuf",
  "wintablib",
  "nvimtool",
  "thetto",
  "kivi",
  "flompt",
  "gesture",
  "searcho",
  "filetypext",
  "cmdhndlr",
  "notomo",
}
for _, m in ipairs(modules) do
  require("lreload").enable(m)
end
