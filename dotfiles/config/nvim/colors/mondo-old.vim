" Vim color file
" Maintainer:   Your name <youremail@something.com>
" Last Change:  
" URL:		

" cool help screens
" :he group-name
" :he highlight-groups
" :he cterm-colors

" your pick:
set background=dark	" or light
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="mondo-old"

"hi Normal

" OR

" highlight clear Normal
" set background&
" highlight clear
" if &background == "light"
"   highlight Error ...
"   ...
" else
"   highlight Error ...
"   ...
" endif

" A good way to see what your colorscheme does is to follow this procedure:
" :w 
" :so % 
"
" Then to see what the current setting is use the highlight command.  
" For example,
" 	:hi Cursor
" gives
"	Cursor         xxx guifg=bg guibg=fg 
 	
" Uncomment and complete the commands you want to change from the default.

"hi Cursor		
"hi CursorIM	
hi Directory ctermfg=252
"hi DiffAdd		
"hi DiffChange	
"hi DiffDelete	
"hi DiffText	
"hi ErrorMsg	
"hi VertSplit	
"hi Folded		
"hi FoldColumn	
"hi IncSearch	
hi LineNr ctermbg=0 ctermfg=15 cterm=bold
hi CursorLineNr ctermbg=0 ctermfg=11 cterm=bold
"hi ModeMsg		
hi MoreMsg ctermbg=0 ctermfg=15	cterm=reverse
hi NonText ctermfg=5		
hi Question ctermbg=0 ctermfg=15
"hi Search		
hi SpecialKey	ctermfg=5
hi StatusLine ctermbg=252 ctermfg=253	cterm=bold
hi SignColumn ctermbg=252 ctermfg=253 cterm=none
hi StatusLineNC	ctermbg=252 ctermfg=253 cterm=bold
hi User1 ctermbg=252 ctermfg=253
"hi Title		
"hi Visual		
"hi VisualNOS	
"hi WarningMsg	
"hi WildMenu	
"hi Menu		
"hi Scrollbar	
"hi Tooltip		

" syntax highlighting groups
hi Comment cterm=italic ctermfg=252
hi Constant ctermfg=11
hi Identifier ctermfg=11	
"hi Statement	
hi PreProc ctermfg=8
hi Type	ctermfg=6	
hi Special ctermfg=5
hi Underlined	ctermfg=4 cterm=underline
"hi Ignore		
"hi Error		
"hi Todo		

hi SyntasticErrorLine ctermbg=red
hi SyntasticErrorSign ctermbg=8 ctermfg=red
hi SyntasticWarningLine ctermbg=yellow
hi SyntasticWarningSign ctermbg=8 ctermfg=yellow
hi String ctermfg=green

