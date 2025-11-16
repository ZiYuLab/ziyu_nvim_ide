local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")

local function read_file(path)
  local file = io.open(path, "r") -- "r" 表示只读模式
  if not file then
    vim.notify("无法打开文件: " .. path, vim.log.levels.ERROR)
    return ""
  end
  local content = file:read("*a") -- 读取全部内容
  file:close()
  return content
end

local nexte_file_head = read_file(vim.fn.stdpath("config") .. "/snippets/nexte_file_head.txt")
local ziyu_file_head = read_file(vim.fn.stdpath("config") .. "/snippets/ziyu_file_head.txt")

ls.add_snippets("all", {
  s("nexte_file_head", fmta(nexte_file_head, {})),
  s("ziyu_file_head", fmta(ziyu_file_head, {})),
})
