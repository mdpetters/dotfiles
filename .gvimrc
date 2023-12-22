set guifont=JuliaMono\ 14
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

function SendKittyCommand1()
	let command = @"
	let s:sendcommand = join([shellescape(command, 1), shellescape('\n')])

	let prefixed_command = "!kitty @ send-text --to unix:/tmp/mykitty --match num:0 " . s:sendcommand
	silent exec prefixed_command
endfunction

" Kitty Bindings for REPL interaction
call setreg('e', ":call SendKittyCommand1()")

let @d = ':w:silent !kitty @ send-text --to unix:/tmp/mykitty --match num:0 "@time include(\"%\")\n"'
let @f = ':silent !kitty @ send-text --to unix:/tmp/mykitty --match num:0 "? 0\n"'
let @g = ':w:silent !kitty @ send-text --to unix:/tmp/mykitty --match num:0 "format(\"%\")\n":e!'
let @h = ':silent !kitty @ send-text --to unix:/tmp/mykitty --match num:0 "@edit 0\n"'
let @i = ':silent !kitty @ send-text --to unix:/tmp/mykitty --match num:0 "@enter 0\n"'
let @j = ':silent !kitty @ send-text --to unix:/tmp/mykitty --match num:0 "@run 0\n"'
let @q = ':silent !kitty @ send-text --to unix:/tmp/mykitty --match num:0 "\0"\n'
let @r = ':let @" = expand("%:p:h")'
let @t = ':silent !kitty @ send-text --to unix:/tmp/mykitty --match num:0 "cd(\"0\")\n"'
let @s = ':silent !kitty -o allow_remote_control=yes --listen-on unix:/tmp/mykitty julia &'
let @u = '[[0v][$y'

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
imap <C-/> <ESC>mlgc<CR>`li

" Send Line to REPL, do not move cursor
vmap <C-Enter> <C-q>y<ESC>@ej
nmap <C-Enter> <ESC>ml0y$@e`l
imap <C-Enter> <ESC>ml0y$@e`la

" Send Line to REPL, move cursor to next line
vmap <A-Enter> <C-q>y<ESC>@ej
nmap <A-Enter> <ESC>ml0y$@e`lj
imap <A-Enter> <ESC>ml0y$@e`llji

" Send Block to REPL and move to next block
nmap <S-Enter> <ESC>ml}{0v}h$y@e{}
imap <S-Enter> <ESC>ml}{0v}h$y@e{}i

" Send Function to REPL and move to next end of function (normal) stay on line (insert)
nmap <C-A-Enter> <ESC>}[[0v][$y$@e[[][j
imap <C-A-Enter> <ESC>hml@u@e`lla

" Exectute File in REPL, do not move cursor and stay on line 
nmap <C-S-Enter> <ESC>ml0y$@d`l
imap <C-S-Enter> <ESC>hml0y$@d`lla

" Julia Formatter - format file
nmap <C-S-f> <ESC>ml@g`l
imap <C-S-f> <ESC>hml@g`lla

" VIM Formatter - format file
nmap <C-S-i> <ESC>mlggVG=`l
imap <C-S-i> <ESC>hmlggVG=`lla

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
