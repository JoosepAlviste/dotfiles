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
      \       ],
      \       'type': 'test',
      \     },
      \   },
      \ }


"
" Mappings
"

nnoremap <leader>av :AV<CR>
nnoremap <leader>as :AS<CR>
nnoremap <leader>ae :A<CR>
