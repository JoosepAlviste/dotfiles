CompilerSet makeprg=eslint_d\ --format\ stylish\ --ext\ .js,.ts,.tsx,.vue\ --ignore-path\ .eslintignore\ .
CompilerSet errorformat=%-P%f,
		\%\\s%#%l:%c\ %#\ %trror\ \ %m,
		\%\\s%#%l:%c\ %#\ %tarning\ \ %m,
		\%-Q,
		\%-G%.%#,
