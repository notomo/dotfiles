local modules = {
  "reacher",
  "cmdbuf",
  "wintablib",
  "nvimtool",
  "kivi",
  "flompt",
  "searcho",
  "filetypext",
  "cmdhndlr",
  "suball",
  "promise",
  "docfilter",
  "gettest",
  "tracebundler",
  "notomo",
}
for _, m in ipairs(modules) do
  require("lreload").enable(m)
end
