" Customize onedark colors
function! joosep#colors#CustomizeColors()
  let s:colors = onedark#GetColors()
  " Cannot use s:colors.yellow for some reason so let's copy it here :(
  let s:yellow = { "gui": "#E5C07B", "cterm": "180", "cterm16": "3" }
  let s:red = { "gui": "#E06C75", "cterm": "204", "cterm16": "1" }

  " Purple const/var/let, etc.
  call onedark#extend_highlight("StorageClass", { "fg": s:colors.purple })

  " Nicer parenthesis match
  call onedark#set_highlight("MatchParen", { "bg": s:colors.menu_grey })
  " Red TSX opening tag
  call onedark#set_highlight("tsxTagName", { "fg": s:colors.red })
  call onedark#set_highlight("tsxAttrib", { "fg": s:yellow })
  " Less crazy search highlight
  call onedark#set_highlight("Search", { "bg": s:colors.menu_grey })
  " Consistent Typescript parenthesis
  call onedark#set_highlight("typescriptParens", { "fg": s:colors.white })
  call onedark#set_highlight("typescriptVariable", { "fg": s:colors.purple })
  call onedark#set_highlight("typescriptCall", { "fg": s:colors.white })
  call onedark#set_highlight("typescriptImport", { "fg": s:colors.purple })
  call onedark#set_highlight("typescriptIdentifierName", { "fg": s:colors.red })
  call onedark#set_highlight("typescriptInterfaceKeyword", { "fg": s:colors.purple })
  call onedark#set_highlight("typescriptInterfaceName", { "fg": s:yellow })
  call onedark#set_highlight("typescriptInterfaceExtends", { "fg": s:colors.purple })
  call onedark#set_highlight("typescriptTypeReference", { "fg": s:yellow })
  call onedark#set_highlight("typescriptVariableDeclaration", { "fg": s:yellow })
  call onedark#set_highlight("styledPrefix", { "fg": s:red })
  call onedark#set_highlight("jsTemplateBraces", { "fg": s:colors.purple })
  call onedark#set_highlight("typescriptFuncTypeArrow", { "fg": s:colors.purple })
  call onedark#set_highlight("typescriptExport", { "fg": s:colors.purple })
  call onedark#set_highlight("typescriptAliasKeyword", { "fg": s:colors.purple })
  call onedark#set_highlight("typescriptAliasDeclaration", { "fg": s:yellow })
  call onedark#set_highlight("typescriptAsyncFuncKeyword", { "fg": s:colors.purple })
  call onedark#set_highlight("typescriptES6SetMethod", { "fg": s:colors.blue })
  call onedark#set_highlight("typescriptTry", { "fg": s:colors.purple })

  " GraphQL
  call onedark#set_highlight("graphqlStructure", { "fg": s:colors.purple })
  call onedark#set_highlight("graphqlName", { "fg": s:colors.blue })
  call onedark#set_highlight("graphqlTemplateString", { "fg": s:colors.white })
endfunc
