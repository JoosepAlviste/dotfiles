require('incline').setup {
  window = {
    margin = {
      vertical = {
        top = 0,
        bottom = 0,
      },
    },
  },
  render = function(props)
    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
    local icon, color = require('nvim-web-devicons').get_icon_color(filename)

    local segments = {}

    if icon and #icon then
      table.insert(segments, { icon, guifg = color })
      table.insert(segments, { ' ' })
    end

    table.insert(segments, { filename })

    return segments
  end,
}
