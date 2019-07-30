" ============================================================
" myoceanicnext
" Slightly modified veresion of oceanicnext
" Author: Joosep Alviste
" ============================================================

let s:p = {"normal": {}, "inactive": {}, "insert": {}, "replace": {}, "visual": {}, "tabline": {} }

let s:darkest = [["#65737e", 15], ["#17252c", 235]]
let s:dark = [["#cdd3de", 15], ["#1b2b34", 235]]
let s:lighter = [["#cdd3de", 15], ["#1F323C", 243]]
let s:light = [["#ffffff", 15], ["#65737e", 243]]

let s:blue = [["#cdd3de", 15], ["#6699cc", 68]]
let s:red = [["#ffffff", 15], ["#ec5f67", 203]]
let s:yellow = [["#ffffff", 15], ["#fac863", 221]]
let s:orange = [["#ffffff", 15], ["#f99157", 221]]
let s:green = [["#ffffff", 15], ["#99c794", 114]]

let s:p.normal.left = [s:blue, s:lighter]
let s:p.normal.middle = [s:darkest]
let s:p.normal.right = [s:lighter, s:lighter]
let s:p.normal.error = [s:red]
let s:p.normal.warning = [s:yellow]

let s:p.inactive.left = [s:dark, s:dark]
let s:p.inactive.middle = [s:dark]
let s:p.inactive.right = [s:dark, s:dark]

let s:p.insert.left = [s:green, s:lighter]
let s:p.insert.middle = [s:darkest]
let s:p.insert.right = [s:lighter, s:lighter]

let s:p.replace.left = [s:red, s:lighter]
let s:p.replace.middle = [s:darkest]
let s:p.replace.right = [s:lighter, s:lighter]

let s:p.visual.left = [s:orange, s:lighter]
let s:p.visual.middle = [s:darkest]
let s:p.visual.right = [s:lighter, s:lighter]

let s:p.tabline.left = [s:lighter]
let s:p.tabline.tabsel = [s:light]
let s:p.tabline.middle = [s:darkest]
let s:p.tabline.right = [s:darkest]

let g:lightline#colorscheme#myoceanicnext#palette = lightline#colorscheme#flatten(s:p)
