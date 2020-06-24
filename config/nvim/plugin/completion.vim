"
" Configure the LSP with Lua code
"

lua require'completion_utils'.configure_lsp()


"
" Options
"

let g:completion_enable_auto_paren = 1
let g:completion_matching_ignore_case = 1
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_sorting = 'none'
let g:completion_confirm_key = "\<c-y>"
let g:completion_customize_lsp_label = {
      \ 'Function': ' ',
      \ 'Method': ' ',
      \ 'Reference': ' ',
      \ 'Enum': ' ',
      \ 'Field': 'ﰠ ',
      \ 'Keyword': ' ',
      \ 'Variable': ' ',
      \ 'Constant': ' ',
      \ 'Folder': ' ',
      \ 'Snippet': ' ',
      \ 'Operator': ' ',
      \ 'Module': ' ',
      \ 'Text': 'ﮜ ',
      \ 'Buffers': ' ',
      \ 'Class': ' ',
      \ 'Interface': ' ',
      \}
let g:completion_chain_complete_list = {
      \'default' : [
      \    {'complete_items': ['snippet', 'lsp']},
      \    {'mode': '<c-p>'},
      \    {'mode': '<c-n>'}
      \]
      \}
