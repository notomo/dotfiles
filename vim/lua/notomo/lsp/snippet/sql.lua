local M = {}

M.select = {
  body = [[
SELECT
  ${1:*}
FROM
  ${2:table}
]],
}

M.select_where = {
  body = [[
SELECT
  ${1:*}
FROM
  ${2:table}
WHERE
  ${3:condition}
]],
}

M.insert_into = {
  body = [[
INSERT INTO ${1:table} (${2:columns}) VALUES (${3:values});
]],
}

M.update = {
  body = [[
UPDATE ${1:table} SET ${2:column} = ${3:value} WHERE ${4:condition};
]],
}

M.left_join = {
  body = [[
LEFT JOIN ${1:table} ${2:t} ON $2.${3:id} = ${4:other}.${5:id}
]],
}

M.where = {
  body = [[
WHERE
  ${1:condition}
]],
}

M.group_by = {
  body = [[
GROUP BY ${1:column}
]],
}

M.order_by = {
  body = [[
ORDER BY ${1:column}
]],
}

M.count = {
  body = [[
COUNT(${1:column})
]],
}

return M
