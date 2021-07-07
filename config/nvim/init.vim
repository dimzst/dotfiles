set encoding=utf-8
let mapleader=" "

" PLUGIN "{{{
" ---------------------------------------------------------------------
call plug#begin('~/.local/share/nvim/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'glepnir/lspsaga.nvim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-commentary'

Plug 'mhinz/vim-signify'

Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'vim-airline/vim-airline'

call plug#end()

lua require('dimzst')
" ---------------------------------------------------------------------
" }}}

" SETTINGS "{{{
" ---------------------------------------------------------------------
set list listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

set incsearch ignorecase smartcase showmatch nohlsearch
set noerrorbells novisualbell

set noexpandtab tabstop=4 softtabstop=4 shiftwidth=4
set relativenumber nu
set scrolloff=4

set nobackup noswapfile nowritebackup 
set undofile undodir=~/.vim/undodir

set hidden
set signcolumn=yes
set shortmess+=c
set updatetime=300
" set cmdheight=2
" set jumpoptions+=stack

" THEME
syntax on
set t_Co=256
set cursorline
colorscheme onehalfdark
let g:airline_theme='onehalfdark'

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Transparancy
hi Normal guibg=NONE ctermbg=NONE

" NETRW
set splitbelow
set splitright
" ---------------------------------------------------------------------
" }}}

" KEYMAP "{{{
" ---------------------------------------------------------------------
" CLIPBOARD
noremap <Leader>cc "*y
noremap <Leader>cv "*p

noremap <silent> <Leader>gs :Git<CR>

" AUTO CLOSE BRACKET
inoremap <expr> " IsMatchingEnable() ? "\"" :  "\"\"\<left>"
inoremap <expr> ' IsMatchingEnable() ? "'" :  "''\<left>"
inoremap <expr> ` IsMatchingEnable() ? "`" :  "``\<left>"
inoremap <expr> ( IsMatchingEnable() ? "(" :  "()\<left>"
inoremap <expr> [ IsMatchingEnable() ? "[" :  "[]\<left>"
inoremap <expr> { IsMatchingEnable() ? "{" :  "{}\<left>"
inoremap <expr> {<CR> IsMatchingEnable() ? "{\<CR>" :  "{\<CR>}\<ESC>O"
inoremap <expr> {;<CR> IsMatchingEnable() ? "{;\<CR>" :  "{<CR>};<ESC>O"

function! IsMatchingEnable()
	return &filetype ==# 'TelescopePrompt'
endfunction

" PANE NAVIGATION
function! s:PaneNavigationRemap()
  nnoremap <C-J> <C-W><C-J>
  nnoremap <C-K> <C-W><C-K>
  nnoremap <C-L> <C-W><C-L>
  nnoremap <C-H> <C-W><C-H>
endfunction

augroup netrwRemap
  autocmd!
  autocmd FileType netrw call s:PaneNavigationRemap()
augroup end

call s:PaneNavigationRemap()
" ---------------------------------------------------------------------
" vim:foldmethod=marker:foldlevel=0
" }}}
