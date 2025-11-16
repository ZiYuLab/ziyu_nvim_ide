return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "super-tab",
    },
    -- mapping = {
    --   ["<Tab>"] = {
    --     action = function(ctx)
    --       local luasnip = require("luasnip")
    --       if luasnip.expand_or_jumpable() then
    --         luasnip.expand_or_jump()
    --       else
    --         ctx:confirm({ select = true })
    --       end
    --     end,
    --   },
    --   ["<S-Tab>"] = {
    --     action = function()
    --       local luasnip = require("luasnip")
    --       if luasnip.jumpable(-1) then
    --         luasnip.jump(-1)
    --       end
    --     end,
    --   },
    -- },
  },
  dependencies = {
    "L3MON4D3/LuaSnip",
  },
}
