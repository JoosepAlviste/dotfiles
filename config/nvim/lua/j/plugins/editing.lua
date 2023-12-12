return {
  {
    'altermo/ultimate-autopair.nvim',
    event = { 'InsertEnter', 'CmdlineEnter' },
    branch = 'v0.6',
    opts = {
      tabout = {
        enable = true,
        hopout = true,
      },
    },
  },
  {
    'kylechui/nvim-surround',
    keys = { 'ys', 'cs', 'ds' },
    opts = {},
  },
  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').set_default_keymaps()
    end,
  },
  {
    'numToStr/Comment.nvim',
    keys = {
      { 'gc', mode = { 'n', 'v' }, 'gcc' },
    },
    opts = {
      pre_hook = function(ctx)
        return require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()(ctx)
      end,
    },
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    ft = { 'typescriptreact' },
    opts = {
      enable_autocmd = false,
    },
  },
  {
    'axelvc/template-string.nvim',
    opts = {
      filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'vue' },
      remove_template_string = true,
      restore_quotes = {
        normal = [[']],
        jsx = [["]],
      },
    },
    event = 'InsertEnter',
    ft = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'vue' },
  },
}
