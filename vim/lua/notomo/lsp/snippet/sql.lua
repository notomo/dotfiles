local M = {}

M.select = {
  body = [[
SELECT
  ${1:*}
FROM
  ${0:table}
]],
}

M.select_where = {
  body = [[
SELECT
  ${1:*}
FROM
  ${2:table}
WHERE
  ${0:condition}
]],
}

M.insert_into = {
  body = [[
INSERT INTO ${1:table} (${2:columns}) VALUES (${0:values});
]],
}

M.update = {
  body = [[
UPDATE ${1:table} SET ${2:column} = ${3:value} WHERE ${0:condition};
]],
}

M.left_join = {
  body = [[
LEFT JOIN ${1:table} ${2:t} ON $2.${3:id} = ${4:other}.${0:id}
]],
}

M.where = {
  body = [[
WHERE
  ${0:condition}
]],
}

M.group_by = {
  body = [[
GROUP BY ${0:column}
]],
}

M.order_by = {
  body = [[
ORDER BY ${0:column}
]],
}

M.count = {
  body = [[
COUNT(${0:column})
]],
}

return M
