"
" Options
"

let g:projectionist_heuristics = {
      \   'src/*': {
      \     '*.js': {
      \       'alternate': [
      \         '{dirname}/{basename}.test.js',
      \         '{dirname}/__tests__/{basename}.test.js',
      \       ],
      \       'type': 'source',
      \     },
      \     '*.test.js': {
      \       'alternate': [
      \         '{dirname}/{basename}.js',
      \         '{dirname}/../{basename}.js',
      \       ],
      \       'type': 'test',
      \     },
      \     '*.ts': {
      \       'alternate': [
      \         '{dirname}/{basename}.test.ts',
      \         '{dirname}/{basename}.test.tsx',
      \         '{dirname}/__tests__/{basename}.test.ts',
      \         '{dirname}/__tests__/{basename}.test.tsx',
      \       ],
      \       'type': 'source',
      \     },
      \     '*.test.ts': {
      \       'alternate': [
      \         '{dirname}/{basename}.ts',
      \         '{dirname}/{basename}.tsx',
      \         '{dirname}/../{basename}.ts',
      \         '{dirname}/../{basename}.tsx',
      \       ],
      \       'type': 'test',
      \     },
      \     '*.tsx': {
      \       'alternate': [
      \         '{dirname}/{basename}.test.ts',
      \         '{dirname}/{basename}.test.tsx',
      \         '{dirname}/__tests__/{basename}.test.ts',
      \         '{dirname}/__tests__/{basename}.test.tsx',
      \       ],
      \       'type': 'source',
      \     },
      \     '*.test.tsx': {
      \       'alternate': [
      \         '{dirname}/{basename}.ts',
      \         '{dirname}/{basename}.tsx',
      \         '{dirname}/../{basename}.ts',
      \         '{dirname}/../{basename}.tsx',
      \       ],
      \       'type': 'test',
      \     },
      \   },
      \ }


"
" Mappings
"

nnoremap <silent> <leader>av :AV<CR>
nnoremap <silent> <leader>as :AS<CR>
nnoremap <silent> <leader>ae :A<CR>
