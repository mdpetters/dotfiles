call plug#begin()
Plug 'JuliaEditorSupport/julia-vim'
Plug 'itchyny/lightline.vim'
Plug 'preservim/vimux'
Plug 'purescript-contrib/purescript-vim'
Plug 'neovim/nvim-lspconfig'
"Plug 'hrsh7th/nvim-compe'
Plug 'nvim-lua/completion-nvim'
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
autocmd BufEnter * lua require'completion'.on_attach()
nnoremap <esc> :noh<return><esc>
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "pyright", "rust_analyzer", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

local cmd = {
    "julia",
    "--startup-file=no",
    "--history-file=no",
    vim.fn.expand("~/.config/nvim/lsp-julia/run.jl")
}
require'lspconfig'.julials.setup{
    cmd = cmd,
  -- Why do I need this? Shouldn't it be enough to override cmd on the line above?
    on_new_config = function(new_config, _)
        new_config.cmd = cmd
    end,
    filetypes = {"julia"},
	on_attach = on_attach
}

local function goto_definition(split_cmd)
  local util = vim.lsp.util
  local log = require("vim.lsp.log")
  local api = vim.api

  local handler = function(_, method, result)
    if result == nil or vim.tbl_isempty(result) then
      local _ = log.info() and log.info(method, "No location found")
      return nil
    end

    if split_cmd then
      vim.cmd(split_cmd)
    end

    if vim.tbl_islist(result) then
      util.jump_to_location(result[1])

      if #result > 1 then
        util.set_qflist(util.locations_to_items(result))
        api.nvim_command("copen")
        api.nvim_command("wincmd p")
      end
    else
      util.jump_to_location(result)
    end
  end

  return handler
end

vim.lsp.handlers["textDocument/definition"] = goto_definition('split')
EOF

