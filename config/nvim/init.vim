set encoding=utf-8
let mapleader=" "

" PLUGIN "{{{
" vim:foldmethod=marker:foldlevel=0
" ---------------------------------------------------------------------
call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-commentary'
Plug 'shumphrey/fugitive-gitlab.vim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'branch' : '0.5-compat', 'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects', {'branch' : '0.5-compat'}
Plug 'tami5/lspsaga.nvim', {'branch' : 'nvim51'}
" Plug 'ray-x/lsp_signature.nvim'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets'

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

Plug 'lewis6991/gitsigns.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'folke/zen-mode.nvim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'catppuccin/nvim'
Plug 'beauwilliams/focus.nvim'
Plug 'goolord/alpha-nvim'
Plug 'sainnhe/gruvbox-material'
Plug 'junegunn/goyo.vim'

Plug 'NTBBloodbath/rest.nvim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

call plug#end()

lua require('dimzst')
" ---------------------------------------------------------------------
" }}}

" SETTINGS "{{{
" ---------------------------------------------------------------------
let workFile = '~/.config/nvim/work.vim'
if !empty(workFile)
	exe 'so' workFile
endif

set background=dark

set list listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<,lead:.

set incsearch ignorecase smartcase showmatch nohlsearch
set noerrorbells novisualbell
set mouse=a

set noexpandtab tabstop=4 softtabstop=4 shiftwidth=4
set relativenumber nu
set scrolloff=5

set nobackup noswapfile nowritebackup
set undofile undodir=~/.vim/undodir

set splitbelow
set splitright

set hidden
set signcolumn=yes
set shortmess+=c
set updatetime=300
" set cmdheight=2
" set jumpoptions+=stack

augroup WinActiveHighLight
    autocmd!
    autocmd WinEnter * set cursorline colorcolumn=80,100
    autocmd WinLeave * set nocursorline colorcolumn=0
augroup END

" THEME
syntax on
set t_Co=256

if exists('+termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

" Transparancy
" hi Normal guibg=NONE ctermbg=NONE
" colorscheme edge

" NvimTree
let g:nvim_tree_side='right'

" FireNvim
let g:firenvim_config = { 
			\ 'globalSettings': {
				\ 'alt': 'all',
				\ '<C-i>': 'noop',
				\  },
				\ 'localSettings': {
					\ '.*': {
						\ 'cmdline': 'neovim',
						\ 'content': 'text',
						\ 'priority': 0,
						\ 'selector': 'textarea',
						\ 'takeover': 'never',
						\ },
						\ }
						\ }
" ---------------------------------------------------------------------
" }}}

" KEYMAP "{{{
" ---------------------------------------------------------------------
" CLIPBOARD
noremap <Leader>cc "*y
noremap <Leader>cv "*p
vnoremap p "0p

noremap <silent> <Leader>gs :Git<CR>
noremap <silent> <Leader>t :NvimTreeToggle<CR>
noremap <silent> <Leader>T :NvimTreeFindFile<CR>
noremap <silent> <Leader>gg :Goyo<CR>

nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [q :cprev<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [b :bprev<CR>

augroup qfKeymap
	autocmd!
	autocmd FileType qf nnoremap <buffer> <silent> dd :call setqflist(filter(getqflist(), {idx -> idx != line('.') - 1}), 'r') <Bar> cc<CR>
augroup end

" COMPLETION
" Use <Tab> and <S-Tab> to navigate through popup menu
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

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
" }}}

" Command "{{{
" ---------------------------------------------------------------------
command! -nargs=? SetTab call SetTab(<q-args>)
function! SetTab(num)
	let num = a:num == '' ? 4 : a:num
	execute printf('set tabstop=%s softtabstop=%s shiftwidth=%s', num, num, num)
endfunction

command! -nargs=? ChangeTheme call ChangeTheme(<q-args>)
function! ChangeTheme(theme)
	let theme = a:theme == '' ? &background : a:theme
	if theme == 'dark'
		set background=dark
	else
		set background=light
	endif
	execute "ReloadLua"
endfunction

command! -nargs=? ReloadLua call ReloadLua()
function! ReloadLua()
	execute "lua require('plenary.reload').reload_module('dimzst', true)"
	execute "lua require('plenary.reload').reload_module('lualine', true)"
	execute "lua require('dimzst')"
endfunction
" ---------------------------------------------------------------------
" }}}
