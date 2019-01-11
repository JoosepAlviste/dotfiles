let s:p = {"normal": {}, "inactive": {}, "insert": {}, "replace": {}, "visual": {}, "tabline": {} }

let s:p.normal.left = [[["#011627", 235], ["#82aaff", 110]], [["#c5d4dd", 188], ["#122d42", 242]]]
let s:p.normal.middle = [[["#6a7d89", 66], ["#011627", 235]]]
let s:p.normal.right = [[["#c5d4dd", 235], ["#4b6479", 66]], [["#c5d4dd", 188], ["#122d42", 242]]]
let s:p.normal.error = [[["#1e272c", 235], ["#df8c8c", 174]]]
let s:p.normal.warning = [[["#1e272c", 235], ["#dada93", 186]]]

let s:p.inactive.left = [[["#c5d4dd", 235], ["#556873", 66]], [["#c5d4dd", 188], ["#122d42", 242]]]
let s:p.inactive.middle = [[["#6a7d89", 66], ["#011627", 235]]]
let s:p.inactive.right = [[["#c5d4dd", 235], ["#4b6479", 66]], [["#c5d4dd", 188], ["#122d42", 242]]]

let s:p.insert.left = [[["#1e272c", 235], ["#22da6e", 150]], [["#c5d4dd", 188], ["#122d42", 242]]]
let s:p.insert.middle = [[["#6a7d89", 66], ["#011627", 235]]]
let s:p.insert.right = [[["#c5d4dd", 235], ["#4b6479", 66]], [["#c5d4dd", 188], ["#122d42", 242]]]

let s:p.replace.left = [[["#1e272c", 235], ["#f78c6c", 174]], [["#c5d4dd", 188], ["#122d42", 242]]]
let s:p.replace.middle = [[["#6a7d89", 66], ["#011627", 235]]]
let s:p.replace.right = [[["#c5d4dd", 235], ["#4b6479", 66]], [["#c5d4dd", 188], ["#122d42", 242]]]

let s:p.visual.left = [[["#011627", 235], ["#ffeb95", 110]], [["#c5d4dd", 188], ["#122d42", 242]]]
let s:p.visual.middle = [[["#6a7d89", 66], ["#011627", 235]]]
let s:p.visual.right = [[["#c5d4dd", 235], ["#4b6479", 66]], [["#c5d4dd", 188], ["#122d42", 242]]]

let s:p.tabline.left = [[["#c5d4dd", 188], ["#122d42", 242]]]
let s:p.tabline.tabsel = [[["#1e272c", 235], ["#c792ea", 104]]]
let s:p.tabline.middle = [[["#6a7d89", 66], ["#011627", 235]]]
let s:p.tabline.right = [[["#c5d4dd", 188], ["#122d42", 242]]]

let g:lightline#colorscheme#nightowl#palette = lightline#colorscheme#flatten(s:p)
