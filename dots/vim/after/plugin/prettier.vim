let g:prettier#config#config_precedence = 'file-override'
let g:prettier#exec_cmd_async = 1

" Automatically run prettier on files without @format comment
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

