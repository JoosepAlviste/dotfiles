"
" Commands
"
command! -nargs=0 V :call joosep#terminal#OpenTerminal()

" Typescript
command! -nargs=0 TSLint :call CocAction('runCommand', 'tslint.lintProject')

" Jest
" Run jest for current project
command! -nargs=0 Jest :call  CocAction('runCommand', 'jest.projectTest')
" Run jest for current file
command! -nargs=0 JestCurrent :call  CocAction('runCommand', 'jest.fileTest', ['%'])
" Init jest in cwd, require global jest command exists
command! JestInit :call CocAction('runCommand', 'jest.init')
