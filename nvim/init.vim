if exists('g:vscode')
    " VSCode extension
else
	call plug#begin()
		Plug 'JuliaEditorSupport/julia-vim'
		Plug 'itchyny/lightline.vim'
		Plug 'preservim/nerdtree'
		Plug 'tpope/vim-commentary'
		Plug 'chrisbra/csv.vim'
	call plug#end()
endif

"set t_Co=256
set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab 
set autochdir
set autoread
set clipboard=unnamedplus
set laststatus=1
set wildmode=longest,list
"set bg=light
set number

set visualbell

let g:zenburn_high_Contrast=1
let g:zenburn_old_Visual=1
highlight Comment cterm=italic
colorscheme zenburn

" wrapping comments
map ,> :s/^/# /<CR>
map ,< :s/^# /<CR>

let @d = ':w
let @e = ':w:call VimuxRunCommand(@0)ji' 
let @f = ':VimuxRunCommand("?".@0)'
let @g = ':w
let @p = ':e!
let @w = '0

function SendKittyCommand(command)
  let s:sendcommand = join([shellescape(a:command, 1), shellescape('\n')])

  let prefixed_command = "!kitty @ send-text --match cmdline:julia " . s:sendcommand
  silent exec prefixed_command
endfunction


" Kitty Bindings
let @d = ':w
call setreg('e', ":w
let @f = ':silent !kitty @ send-text --match cmdline:julia "? 0"\n'
let @g = ':w
let @h = ':silent !kitty @ launch --keep-focus julia
let @q = ':silent !kitty @ send-text --match cmdline:julia "\0"\n'


map <a-r> <ESC>@h  
imap <a-r> <ESC>@hi  

map <A-a> <ESC>@d
imap <A-a> <ESC>@d

noremap <A-h> <ESC>mlyaw@f<ESC>`l
inoremap <A-h> <ESC>mlyaw@f<ESC>`l

map <A-f> <ESC>ml@g@p<ESC>`l
imap <A-f> <ESC>ml@g@p<ESC>`lli

vmap <a-s> <C-q>y<ESC>@e<ESC>
imap <a-s> <ESC>ml0y$@e<ESC>`lli
nmap <a-s> <ESC>ml0y$@e<ESC>`l

vmap <a-cr> <C-q>y<ESC>@e<ESC>
imap <a-cr> <ESC>ml[[v][$y$@e<ESC>`lli
nmap <a-cr> <ESC>ml[[v][$y$@e<ESC>`l


nmap <C-_> mlVgc<CR>`l
vmap <C-_> mlgc<CR>`l
imap <C-_> <ESC>mlgc<CR>`li

nmap <S-Up> v<Up>
nmap <S-Down> v<Down>
nmap <S-Left> v<Left>
nmap <S-Right> v<Right>
nmap <S-Home> v<Home>
nmap <S-End> v<End>
nmap <S-PageUp> vgg0
nmap <S-PageDown> vG$
vmap <S-Up> <Up>
vmap <S-Down> <Down>
vmap <S-Left> <Left>
vmap <S-Right> <Right>
vmap <S-Home> <Home>
vmap <S-End> <End>
vmap <S-PageUp> gg0
vmap <S-PageDown> G$
imap <S-Up> <Esc>v<Up>
imap <S-Down> <Esc>v<Down>
imap <S-Left> <Esc>v<Left>
imap <S-Right> <Esc>v<Right>
imap <S-Home> <Esc>v<Home>
imap <S-End> <Esc><End>
imap <S-PageUp> <ESC>vgg0
imap <S-PageDown> <ESC>vG$

nnoremap <esc> :noh<return><esc>

" Workaround for TMUX
if &term =~ '^screen' && exists('$TMUX')
	set mouse+=a
	" tmux knows the extended mouse mode
	set ttymouse=xterm2
	v" tmux will send xterm-style keys when xterm-keys is on
	execute "set <xUp>=\e[1;*A"
	execute "set <xDown>=\e[1;*B"
	execute "set <xRight>=\e[1;*C"
	execute "set <xLeft>=\e[1;*D"
	execute "set <xHome>=\e[1;*H"
	execute "set <xEnd>=\e[1;*F"
	execute "set <Insert>=\e[2;*~"
	execute "set <Delete>=\e[3;*~"
	execute "set <PageUp>=\e[5;*~"
	execute "set <PageDown>=\e[6;*~"
	execute "set <xF1>=\e[1;*P"
	execute "set <xF2>=\e[1;*Q"
	execute "set <xF3>=\e[1;*R"
	execute "set <xF4>=\e[1;*S"
	execute "set <F5>=\e[15;*~"
	execute "set <F6>=\e[17;*~"
	execute "set <F7>=\e[18;*~"
	execute "set <F8>=\e[19;*~"
	execute "set <F9>=\e[20;*~"
	execute "set <F10>=\e[21;*~"
	execute "set <F11>=\e[23;*~"
	execute "set <F12>=\e[24;*~"
endif

let &t_SI = "\e[5 q"
let &t_EI = "\e[1 q"

let g:lightline = {
			\ 'colorscheme': 'apprentice',
			\ }

runtime macros/matchit.vim

set foldmethod=syntax

let g:NERDTreeQuitOnOpen = 1
:nnoremap <C-b> :NERDTreeToggle<CR>
set mouse=a

filetype plugin on