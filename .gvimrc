" set guifont=JuliaMono\ 18
set guifont=Cascadia\ Code\ 14
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set guiligatures=!\"#$%&()*+-./:<=>?@[]^_{\|~  
set hidden
set backspace=indent,eol,start
set termguicolors
let g:terminal_ansi_colors = [
			\ '#1e2021',
			\ '#cc241d',
			\ '#98971a',
			\ '#d79921',
			\ '#458588',
			\ '#b16286',
			\ '#689d6a',
			\ '#a89984',
			\ '#928374',
			\ '#fb4934',
			\ '#b8bb26',
			\ '#fadb2d',
			\ '#83a598',
			\ '#d3869b',
			\ '#8ec07c',
			\ '#928374',
			\ ]
hi Terminal guibg=#1d2021 guifg=#ebdbb2

function SendRegister()
	let command = @"
	let s:sendcommand = shellescape(command, 1)
	let prefixed_command = "!tmux send-keys -l " . s:sendcommand
	silent exec prefixed_command
	silent exec "!tmux send-keys Enter"
	" echon ''
endfunction

" Kitty Bindings for REPL interaction
call setreg('e', ":call SendRegister()")

" let @e = ':silent !tmux send-keys "0" Enter'
let @d = ':w:silent !tmux send-keys "@time include(\"%\")" Enter'
let @f = ':silent !tmux send-keys "? 0" Enter'
let @g = ':w:silent !tmux send-keys "format(\"%\")" Enter:e!'
let @h = ':silent !tmux send-keys "@edit 0" Enter'
let @i = ':silent !tmux send-keys "@enter 0" Enter'
let @j = ':silent !tmux send-keys "@run 0" Enter'
let @r = ':let @" = expand("%:p:h")'
let @t = ':silent !tmux send-keys "cd(\"0\")" Enter'
let @u = '[[0v][$'

imap <C-r> <ESC>@r@ti
nmap <C-r> <ESC>@r@t

" REPL Help ?
noremap <A-h> <ESC>mlyaw@f<ESC>`l
inoremap <A-h> <ESC>mlyaw@f<ESC>`l

" Debugger @enter
vmap <A-e> <C-q>y<ESC>@i<ESC>
imap <A-e> <ESC>ml0y$@i<ESC>`lli
nmap <A-e> <ESC>ml0y$@i<ESC>`l

" Debugger @edit 
vmap <A-v> <C-q>y<ESC>@h<ESC>j
imap <A-v> <ESC>ml0y$@h<ESC>`lli
nmap <A-v> <ESC>ml0y$@h<ESC>`l

" Debugger @run 
vmap <A-r> <C-q>y<ESC>@j<ESC>j
imap <A-r> <ESC>ml0y$@j<ESC>`lli
nmap <A-r> <ESC>ml0y$@j<ESC>`l

" Comment/Uncomment selection
nmap <C-/> mlVgc<CR>`l
vmap <C-/> mlgc<CR>`l
imap <C-/> <ESC>Vgc<CR>gi

" Send Line to REPL, do not move cursor
vmap <C-Enter> <C-q>y<ESC>@ej
nmap <C-Enter> <ESC>ml0y$@e`l
imap <C-Enter> <ESC>0y$@egi

" Send Line to REPL, move cursor to next line
vmap <A-Enter> <C-q>y<ESC>@ej
nmap <A-Enter> <ESC>ml0y$@e`lj
imap <A-Enter> <ESC>0y$@egi

" Send Block to REPL and move to next block
nmap <S-Enter> <ESC>}{0v}h$y@e{}
imap <S-Enter> <ESC>}{0v}h$y@e{}i

" Send Function to REPL and move to next end of function
nmap <C-A-Enter> <ESC>}[[0v][$y$@e[[][j0
imap <C-A-Enter> <ESC>}[[0v][$y$@e[[][j0

" Exectute File in REPL, do not move cursor and stay on line 
nmap <C-S-Enter> <ESC>ml0y$@d`l
imap <C-S-Enter> <ESC>0y$@dgi

" Julia Formatter - format file
nmap <C-S-f> <ESC>ml@g`l
imap <C-S-f> <ESC>@ggi

" VIM Formatter - format file
nmap <C-S-i> <ESC>mlggVG=`l
imap <C-S-i> <ESC>ggVG=gi

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
