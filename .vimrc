call plug#begin()
Plug 'JuliaEditorSupport/julia-vim'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'morhetz/gruvbox'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'acepukas/vim-zenburn'
Plug 'preservim/nerdtree'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }	
Plug 'junegunn/fzf.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
call plug#end()

set autochdir
set autoread
set clipboard=unnamedplus
set laststatus=1
set wildmode=longest,list
set number
set novisualbell
set noshowmode
set laststatus=2
set mouse=a
set nospell
set clipboard+=unnamedplus
set noerrorbells
set whichwrap=<,>,h,l,[,]
set bg=dark
set t_Co=256
set updatetime=100
set noerrorbells
set belloff=all

let g:NERDTreeChDirMode = 2
let g:NERDTreeQuitOnOpen = 1

runtime macros/matchit.vim
:au FocusLost * silent! wa

let g:zenburn_high_Contrast=1
let g:zenburn_old_Visual=1
let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'
let s:is_dark=(&background == 'dark')

" julia
let g:default_julia_version = '1.0'
let g:julia_indent_align_brackets = 0
let g:julia_indent_align_funcargs = 0
let g:julia_indent_align_import = 0
let g:julia_spellcheck_comments = 1
let g:julia_spellcheck_docstrings = 1

highlight Comment cterm=italic
colorscheme gruvbox 

nmap <C-c> mlVgc<CR>`l
vmap <C-c> mlgc<CR>`l
imap <C-c> <ESC>mlgc<CR>`li

imap <silent> <Down> <C-o>gj
imap <silent> <Up> <C-o>gk
nmap <silent> <Down> gj
nmap <silent> <Up> gk

" Comment/Uncomment selection
nmap <C-c> mlVgc<CR>`l
vmap <C-c> mlgc<CR>`l
imap <C-c> <ESC>mlgc<CR>`li

nnoremap <C-b> :NERDTreeToggle<CR>
" nnoremap <TAB> >>
" nnoremap <S-TAB> <<
" vnoremap <TAB> >gv
" vnoremap <S-TAB> <gv

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"



" Spell-check Markdown files and Git Commit Messages
autocmd FileType markdown setlocal spell
autocmd FileType gitcommit setlocal spell

filetype plugin on
