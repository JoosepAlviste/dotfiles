let s:p = {"normal": {}, "inactive": {}, "insert": {}, "replace": {}, "visual": {}, "tabline": {} }

let s:p.normal.left = [[["#1e272c", 235], ["#83afe5", 110]], [["#c5d4dd", 188], ["#6a7d89", 242]]]
let s:p.normal.middle = [[["#6a7d89", 66], ["#556873", 235]]]
let s:p.normal.right = [[["#c5d4dd", 235], ["#6a7d89", 66]], [["#c5d4dd", 188], ["#556873", 242]]]
let s:p.normal.error = [[["#1e272c", 235], ["#df8c8c", 174]]]
let s:p.normal.warning = [[["#1e272c", 235], ["#dada93", 186]]]

let s:p.inactive.left = [[["#1e272c", 235], ["#6a7d89", 66]], [["#c5d4dd", 188], ["#556873", 242]]]
let s:p.inactive.middle = [[["#6a7d89", 66], ["#1e272c", 235]]]
let s:p.inactive.right = [[["#1e272c", 235], ["#6a7d89", 66]], [["#c5d4dd", 188], ["#556873", 242]]]

let s:p.insert.left = [[["#1e272c", 235], ["#a8ce93", 150]], [["#c5d4dd", 188], ["#556873", 242]]]
let s:p.insert.middle = [[["#6a7d89", 66], ["#1e272c", 235]]]
let s:p.insert.right = [[["#1e272c", 235], ["#6a7d89", 66]], [["#c5d4dd", 188], ["#556873", 242]]]

let s:p.replace.left = [[["#1e272c", 235], ["#df8c8c", 174]], [["#c5d4dd", 188], ["#556873", 242]]]
let s:p.replace.middle = [[["#6a7d89", 66], ["#1e272c", 235]]]
let s:p.replace.right = [[["#1e272c", 235], ["#6a7d89", 66]], [["#c5d4dd", 188], ["#556873", 242]]]

let s:p.visual.left = [[["#1e272c", 235], ["#dada93", 186]], [["#c5d4dd", 188], ["#556873", 242]]]
let s:p.visual.middle = [[["#6a7d89", 66], ["#1e272c", 235]]]
let s:p.visual.right = [[["#1e272c", 235], ["#6a7d89", 66]], [["#c5d4dd", 188], ["#556873", 242]]]

let s:p.tabline.left = [[["#c5d4dd", 66], ["#556873", 242]]]
let s:p.tabline.tabsel = [[["#1e272c", 235], ["#9a93e1", 104]]]
let s:p.tabline.middle = [[["#899ba6", 103], ["#3c4c55", 235]]]
let s:p.tabline.right = [[["#c5d4dd", 66], ["#556873", 242]]]

let g:lightline#colorscheme#nova#palette = lightline#colorscheme#flatten(s:p)
