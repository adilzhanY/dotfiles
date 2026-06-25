local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

-- Add snippets for React/JS/TS filetypes
ls.add_snippets("javascript", {
  s("cln", {
    t('className="'),
    i(1),
    t('"'),
  }),
})

ls.add_snippets("javascriptreact", {
  s("cln", {
    t('className="'),
    i(1),
    t('"'),
  }),
})

ls.add_snippets("typescript", {
  s("cln", {
    t('className="'),
    i(1),
    t('"'),
  }),
})

ls.add_snippets("typescriptreact", {
  s("cln", {
    t('className="'),
    i(1),
    t('"'),
  }),
})
