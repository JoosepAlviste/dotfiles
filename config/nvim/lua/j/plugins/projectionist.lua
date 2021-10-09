local map = require('j.utils').map

vim.g.projectionist_heuristics = {
  ['src/*'] = {
    ['*.ts'] = {
      alternate = {
        '{dirname}/{basename}.test.ts',
        '{dirname}/__tests__/{basename}.test.ts',
      },
      type = 'source',
    },
    ['*.tsx'] = {
      alternate = {
        '{dirname}/{basename}.test.ts',
        '{dirname}/{basename}.test.tsx',
        '{dirname}/__tests__/{basename}.test.ts',
        '{dirname}/__tests__/{basename}.test.tsx',
      },
      type = 'source',
    },
    ['*.test.ts'] = {
      alternate = {
        '{dirname}/{basename}.ts',
        '{dirname}/../{basename}.ts',
      },
      type = 'test',
    },
    ['*.test.tsx'] = {
      alternate = {
        '{dirname}/{basename}.tsx',
        '{dirname}/../{basename}.tsx',
      },
      type = 'test',
    },
  },
}

map('n', '<leader>av', [[:AV<cr>]], { silent = true })
map('n', '<leader>as', [[:AS<cr>]], { silent = true })
map('n', '<leader>ae', [[:A<cr>]], { silent = true })
