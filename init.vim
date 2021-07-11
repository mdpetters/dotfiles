call plug#begin()
Plug 'JuliaEditorSupport/julia-vim'
Plug 'itchyny/lightline.vim'
call plug#end()

set t_Co=256
set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab 
let g:zenburn_high_Contrast=1
let g:zenburn_old_Visual=1
set wildmode=longest,list
highlight Comment cterm=italic
colorscheme zenburn

set number
set mouse=a

function Paste()
   let x=@0
   return x
endfunction

function Paste2()
   let x=@"
   return x
endfunction

set visualbell
let @d = ':w:call VimuxRunCommand("@time include(\"" . bufname("%") . "\")")i' 
let @e = ':w:call VimuxRunCommand(@0)ji' 

" wrapping comments
map ,> :s/^/# /<CR>
map ,< :s/^# /<CR>

map cp :let @" = expand("%:r")

"map <C-d> <ESC>@d
"imap <C-d> <ESC>@d

map <S-Enter> <ESC>@d
imap <S-Enter> <ESC>@d

vmap <C-s> <C-q>y<ESC>@e<ESC>
imap <C-s> <ESC>0y$@e<ESC>k$a
nmap <C-s> <ESC>0y$@e<ESC>k$

vmap <C-Enter> <C-q>y<ESC>@e<ESC>
imap <C-Enter> <ESC>0y$@e<ESC>k$a
nmap <C-Enter> <ESC>0y$@e<ESC>k$

map <C-f> <ESC>@f
imap <C-f> <ESC>@f

nmap <NUL> v 
imap <NUL> <ESC>lv 

imap <C-A> <C-O>gg<C-O>gH<C-O>G<Esc>
vmap <C-A> <Esc>gggH<C-O>G<Esc>i

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

nm \\paste\\ "=@*.'xy'<CR>gPFx"_2x:echo<CR>
imap <C-y> x<Esc>\\paste\\"_s
vmap <C-y> "-cx<Esc>\\paste\\"_x
"autocmd VimEnter * NERDTree
"
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

set autochdir
set clipboard=unnamedplus
set laststatus=1
let g:lightline = {
      \ 'colorscheme': 'apprentice',
      \ }

let g:VimuxRunnerIndex=0

nmap K :LspHover<cr>
