local create_augroups = require('j.utils').create_augroups

create_augroups {
  terminal = {
    { 'TermOpen', '*', [[lua require('j.terminal.functions').configure()]] },
  },
}
