set encoding=utf-8
let mapleader=" "

" PLUGIN "{{{
" vim:foldmethod=marker:foldlevel=0
" ---------------------------------------------------------------------
call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'numToStr/Comment.nvim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'branch' : 'master', 'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects', {'branch' : 'master'}
Plug 'nvim-treesitter/playground'
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'ray-x/lsp_signature.nvim'
Plug 'stevearc/dressing.nvim'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'mfussenegger/nvim-lint'

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'AckslD/nvim-neoclip.lua'
Plug 'simrat39/rust-tools.nvim'
Plug 'vim-test/vim-test'
Plug 'skywind3000/asyncrun.vim'
Plug 'godlygeek/tabular'

Plug 'lewis6991/gitsigns.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'catppuccin/nvim'
Plug 'beauwilliams/focus.nvim'
Plug 'junegunn/goyo.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'sainnhe/gruvbox-material'
Plug 'rebelot/kanagawa.nvim'
Plug 'https://gitlab.com/yorickpeterse/nvim-pqf.git'

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

set expandtab tabstop=4 softtabstop=4 shiftwidth=4
set relativenumber nu
set scrolloff=5

set nobackup noswapfile nowritebackup
set undofile undodir=~/.vim/undodir

set splitbelow splitright

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

if exists('g:started_by_firenvim') && g:started_by_firenvim
    augroup FireNvimFT
        autocmd!
        autocmd BufEnter *.txt set filetype=markdown
        autocmd BufEnter go.dev_play_*.txt set filetype=go | call GuiFont(12)
    augroup END
endif

" vim-test
let test#strategy = "asyncrun_background"

" ---------------------------------------------------------------------
" }}}

" KEYMAP "{{{
" ---------------------------------------------------------------------
" CLIPBOARD
noremap <Leader>cc "*y
noremap <Leader>cv "*p
" vnoremap p "0p

noremap <silent> <Leader>gs :Git<CR>
noremap <silent> <Leader>t :NvimTreeToggle<CR>
noremap <silent> <Leader>T :NvimTreeFindFile<CR>
noremap <silent> <Leader>gg :Goyo<CR>

nmap <silent> <leader>y :TestNearest<CR>
nmap <silent> <leader>Y :TestFile<CR>

nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [q :cprev<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [b :bprev<CR>

augroup qfKeymap
    autocmd!
    autocmd FileType qf nnoremap <buffer> <silent> dd :call setqflist(filter(getqflist(), {idx -> idx != line('.') - 1}), 'r') <Bar> cc<CR>
augroup end

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

command! -nargs=? GuiFont call GuiFont(<q-args>)
function! GuiFont(num)
    let num = a:num == '' ? 10 : a:num
    execute printf('set guifont=IosevkaNerdFont:h%s', num)
endfunction

command! -nargs=? GolangciDiag call GolangciDiag()
function! GolangciDiag()
    execute "cexpr system('golangci-lint run ./...')"
endfunction

autocmd FileType go setlocal noexpandtab
autocmd FileType yaml setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
" ---------------------------------------------------------------------
" }}}

" Override "{{{
" ---------------------------------------------------------------------
autocmd FileType go setlocal noexpandtab
autocmd FileType yaml,proto setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
" ---------------------------------------------------------------------
" }}}
