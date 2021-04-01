local M = {}

function M.setup()
  -- Override some icons to nonicons (https://github.com/yamatsum/nonicons)
  require('nvim-web-devicons').setup({
    override = {
      ['Dockerfile'] = {
        icon = '',
        color = '#0db7ed',
        name = 'Dockerfile',
      },
      graphql = {
        icon = '',
        color = '#e535ab',
        name = 'GraphQL',
      },
      json = {
        icon = '',
        color = '#cbcb41',
        name = 'Json',
      },
      js = {
        icon = '',
        color = '#cbcb41',
        name = 'Js',
      },
      lua = {
        icon = '',
        color = '#51a0cf',
        name = 'Lua',
      },
      md = {
        icon = '',
        color = '#519aba',
        name = 'Md',
      },
      ts = {
        icon = '',
        color = '#519aba',
        name = 'Ts',
      },
      tsx = {
        icon = '',
        color = '#519aba',
        name = 'Tsx',
      },
      ['vim'] = {
        icon = '',
        color = '#019833',
        name = 'Vim'
      },
      vue = {
        icon = '',
        color = '#8dc149',
        name = 'Vue',
      },
      ['yaml'] = {
        icon = '',
        color = '#cbcb41',
        name = 'Yaml'
      },
      ['yml'] = {
        icon = '',
        color = '#cbcb41',
        name = 'Yml'
      },
    },
  })
end

return M
