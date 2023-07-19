local Border = require('custom.config').border

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      "hrsh7th/cmp-path",
      'rafamadriz/friendly-snippets',
      'hrsh7th/cmp-calc',
      'onsails/lspkind.nvim',
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local luasnip = require("luasnip")
      local cmp = require("cmp")

      local ELLIPSIS_CHAR = '…'
      local MAX_LABEL_WIDTH = 40
      local MIN_LABEL_WIDTH = 40

      -- Setup lspkind icons
      opts.formatting = {
        format = function(entry, item)
          --@label string|number
          local label = item.abbr
          local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
          if truncated_label ~= label then
            item.abbr = truncated_label .. ELLIPSIS_CHAR
          elseif string.len(label) < MIN_LABEL_WIDTH then
            local padding = string.rep(' ', MIN_LABEL_WIDTH - string.len(label))
            item.abbr = label .. padding
          end
          local icons = require("custom.config").icons.kinds
          if icons[item.kind] then
            item.kind = icons[item.kind] .. item.kind
          end
          return item
        end,
      }
      -- Setup cmp
      opts.snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      }
      opts.preselect = cmp.PreselectMode.None
      opts.sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = "emoji" },
        { name = "calc" },
      }
      opts.completion = {
        completeopt = "menu,menuone",
      }

      -- border style
      require("lspconfig.ui.windows").default_options.border = "double"
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = vim.g.bc.style,
      })
      local cmp_borders = {
        border = {
          vim.g.bc.topleft,
          vim.g.bc.horiz,
          vim.g.bc.topright,
          vim.g.bc.vert,
          vim.g.bc.botright,
          vim.g.bc.horiz,
          vim.g.bc.botleft,
          vim.g.bc.vert,
        },
        winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
      }

      opts.window = {
        completion = cmp_borders,
        documentation = cmp_borders,
      }

      opts.sorting = {
        comparators = {
          cmp.config.compare.exact,
          cmp.config.compare.kind,
          cmp.config.compare.locality,
          cmp.config.compare.recently_used,
          cmp.config.compare.score,
        },
      }

      -- Setup mapping
      opts.mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
          elseif require("copilot.suggestion").is_visible() then
            require("copilot.suggestion").accept()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      }
    end,
  },
}
