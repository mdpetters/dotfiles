call plug#begin()
	Plug 'JuliaEditorSupport/julia-vim'
	Plug 'itchyny/lightline.vim'
	Plug 'preservim/nerdtree'
	Plug 'tpope/vim-commentary'
	Plug 'chrisbra/csv.vim'
	Plug 'jghauser/kitty-runner.nvim'
	Plug 'tpope/vim-fugitive'
	Plug 'shinchu/lightline-gruvbox.vim'
	Plug 'acepukas/vim-zenburn'
	Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
call plug#end()

set autochdir
set autoread
set clipboard=unnamedplus
set laststatus=1
set wildmode=longest,list
set number
set visualbell

let g:zenburn_high_Contrast=1
let g:zenburn_old_Visual=1
highlight Comment cterm=italic
set bg=dark
set termguicolors
let g:gruvbox_italic=1
colorscheme zenburn

function SendKittyCommand()
  let command = @"
  let s:sendcommand = join([shellescape(command, 1), shellescape('\n')])

  let prefixed_command = "!kitty @ send-text --match num:1 " . s:sendcommand
  silent exec prefixed_command
endfunction

" Kitty Bindings for REPL interaction
call setreg('e', ":call SendKittyCommand()")

if &filetype == 'julia'
	let @d = ':w:silent !kitty @ send-text --match num:1 "@time include(\"%\")\n" '
	let @f = ':silent !kitty @ send-text --match num:1 "? 0"\n'
	let @g = ':w:silent !kitty @ send-text --match num:1 "format(\"%\")\n":e!'
	let @q = ':silent !kitty @ send-text --match num:1 "\0"\n'
endif

if &filetype == 'matlab'
	let @d = ':w:silent !kitty @ send-text --match num:1 "run(\"%\")\n" '
	let @f = ':silent !kitty @ send-text --match num:1 "help 0"\n'
	let @g = ':w:silent !kitty @ send-text --match num:1 "format(\"%\")\n":e!'
	let @q = ':silent !kitty @ send-text --match num:1 "\0"\n'
endif

if &filetype == 'python'
	let @d = ':w:silent !kitty @ send-text --match num:1 "exec(open(\"%\").read())\n" '
	let @f = ':silent !kitty @ send-text --match num:1 "help(\"0\")"\n'
	let @g = ':w:silent !kitty @ send-text --match num:1 "format(\"%\")\n":e!'
	let @q = ':silent !kitty @ send-text --match num:1 "\0"\n'
endif
	
let @h = ':silent !kitty @ send-text --match num:1 "@edit 0"\n'

map <a-r> <ESC>@h  
imap <a-r> <ESC>@hi  

noremap <A-a> <ESC>@d
inoremap <A-a> <ESC>@d

noremap <A-h> <ESC>mlyaw@f<ESC>`l
inoremap <A-h> <ESC>mlyaw@f<ESC>`l

map <A-f> <ESC>ml@g@p<ESC>`l
imap <A-f> <ESC>ml@g@p<ESC>`lli

vmap <a-s> <C-q>y<ESC>@e<ESC>
imap <a-s> <ESC>ml0y$@e<ESC>`lli
nmap <a-s> <ESC>ml0y$@e<ESC>`l

vmap <a-e> <C-q>y<ESC>@h<ESC>
imap <a-e> <ESC>ml0y$@h<ESC>`lli
nmap <a-e> <ESC>ml0y$@h<ESC>`l

vmap <a-cr> <C-q>y<ESC>@e<ESC>
imap <a-cr> <ESC>ml[[v][$y$@e<ESC>`lli
nmap <a-cr> <ESC>ml[[v][$y$@e<ESC>`l

" Comment and uncomment via <CTRL-/>
nmap <C-_> mlVgc<CR>`l
vmap <C-_> mlgc<CR>`l
imap <C-_> <ESC>mlgc<CR>`li

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

let g:lightline = {
			\ 'colorscheme': 'solarized',
			\ }

let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

let g:lightline = {}
let g:lightline.colorscheme = 'zenburn'

let s:is_dark=(&background == 'dark')

set noshowmode
set laststatus=2

runtime macros/matchit.vim

let g:NERDTreeQuitOnOpen = 1
:nnoremap <C-b> :NERDTreeToggle<CR>

set mouse=a

filetype plugin on

":lua require('kitty-runner')

" julia
let g:default_julia_version = '1.0'
let g:julia_indent_align_brackets = 0
let g:julia_indent_align_funcargs = 0
let g:julia_indent_align_import = 0
let g:julia_spellcheck_comments = 1
let g:julia_spellcheck_docstrings = 1

set nospell

set clipboard+=unnamedplus
