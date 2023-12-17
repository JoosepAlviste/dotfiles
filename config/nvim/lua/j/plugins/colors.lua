return {
  'rebelot/kanagawa.nvim',
  priority = 1000,
  config = function()
    require('kanagawa').setup {
      compile = true,
      dimInactive = true,
      undercurl = true,

      colors = {
        palette = {
          winterYellow = '#302e30',
        },
        theme = {
          all = {
            ui = {
              bg_gutter = 'none',
              bg = '#1b1b23',
            },
          },
        },
      },

      overrides = function(colors)
        ---@type ThemeColors
        local theme = colors.theme
        local bit_lighter_than_bg = '#21212b'

        return {
          CursorLine = { bg = bit_lighter_than_bg },
          ColorColumn = { bg = bit_lighter_than_bg },
          CursorLineNr = { fg = theme.ui.float.fg },

          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
          PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },

          Winbar = { fg = theme.syn.fun },

          DiagnosticFloatingError = { fg = theme.diag.error, bg = 'NONE' },
          DiagnosticFloatingWarn = { fg = theme.diag.warning, bg = 'NONE' },
          DiagnosticFloatingInfo = { fg = theme.diag.info, bg = 'NONE' },
          DiagnosticFloatingHint = { fg = theme.diag.hint, bg = 'NONE' },
          DiagnosticFloatingOk = { fg = theme.diag.ok, bg = 'NONE' },

          DiagnosticUnderlineWarn = { sp = theme.diag.warning, undercurl = true },
          DiagnosticUnderlineError = { sp = theme.diag.error, undercurl = true },

          LspReferenceWrite = { underline = false },

          LspDiagnosticsLineNrError = { fg = theme.diag.error },
          LspDiagnosticsLineNrWarning = { fg = theme.diag.warning },
          StatuslineError = { fg = theme.diag.error, bg = theme.ui.bg_m3 },
          StatuslineWarning = { fg = theme.diag.warning, bg = theme.ui.bg_m3 },
          StatuslineBoolean = { fg = theme.diag.warning, bg = theme.ui.bg_m3 },

          TelescopeTitle = { fg = theme.ui.special, bold = true },
          TelescopePromptNormal = { bg = theme.ui.bg_p1 },
          TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
          TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          TelescopePreviewNormal = { bg = theme.ui.bg_dim },
          TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
        }
      end,
    }

    vim.cmd.colorscheme 'kanagawa'
  end,
}