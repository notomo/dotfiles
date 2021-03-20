local modules = {
  "reacher",
  "cmdbuf",
  "wintablib",
  "curstr",
  "nvimtool",
  "thetto",
  "kivi",
  "flompt",
  "gesture",
  "searcho",
  "filetypext",
  "notomo",
}
for _, m in ipairs(modules) do
  require("lreload").enable(m)
end
