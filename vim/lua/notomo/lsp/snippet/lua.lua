local M = {}

M.if_only = {
  body = [[
if ${1:condition} then
  ${0}
end
]],
}

M.module = {
  body = [[
local M = {}

${0}

return M
]],
}

M.require = {
  body = [[
require("${1:name}")
]],
}

M.import = {
  body = [[
local ${1:Name} = require("${2:path}")
]],
}

M.func = {
  body = [[
local function ${1:name}(${2})
  ${0}
end
]],
}

M.closure = {
  body = [[
function(${1})
  ${0}
end
]],
}

M.for_each = {
  body = [[
for ${1:i}, ${2:v} in ipairs(${3:t}) do
  ${0}
end
]],
}

M.for_pairs = {
  body = [[
for ${1:k}, ${2:v} in pairs(${3:t}) do
  ${0}
end
]],
}

M.pcall = {
  body = [[
local ok, ${1:result} = pcall(${2:func}${3:, args})
]],
}

M.inspect = {
  body = [[
print(vim.inspect(${0}))
]],
}

M.api = {
  body = [[vim.api.nvim_${0}]],
}

M["local"] = {
  body = [[
local ${1:name} = ${0}
]],
}

M.keymap = {
  body = [[
vim.keymap.set("${1:n}", "${2:lhs}", function()
  ${0}
end)
]],
}

M.augroup = {
  body = [[vim.api.nvim_create_augroup("${1:name}", {})]],
}

M.namespace = {
  body = [[local ns = vim.api.nvim_create_namespace("${0:name}")]],
}

M.doc = {
  body = [[--- ${0:description}]],
}

M.doc_param = {
  body = [[--- @param ${1:name} ${2:type} ${0:description}]],
}

M.doc_return = {
  body = [[--- @return ${1:type} # ${0:description}]],
}

M.doc_class = {
  body = [[--- @class ${0:name}]],
}

M.doc_field = {
  body = [[--- @field ${1:name} ${2:type} ${0:description}]],
}

return M
