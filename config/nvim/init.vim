set encoding=utf-8
let mapleader=" "

" PLUGIN "{{{
" vim:foldmethod=marker:foldlevel=0
" ---------------------------------------------------------------------
call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-abolish'
Plug 'shumphrey/fugitive-gitlab.vim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'branch' : 'master', 'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects', {'branch' : 'master'}
Plug 'nvim-treesitter/playground'
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'ray-x/lsp_signature.nvim'
Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'
Plug 'j-hui/fidget.nvim'
Plug 'mfussenegger/nvim-lint'
Plug 'simrat39/rust-tools.nvim'
Plug 'rust-lang/rust.vim'
Plug 'lvimuser/lsp-inlayhints.nvim'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'stevearc/dressing.nvim'
Plug 'AckslD/nvim-neoclip.lua'
Plug 'vim-test/vim-test'
Plug 'skywind3000/asyncrun.vim'
Plug 'godlygeek/tabular'
Plug 'numToStr/Comment.nvim'
Plug 'chrisbra/csv.vim'

Plug 'lewis6991/gitsigns.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'Pocco81/true-zen.nvim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'sainnhe/gruvbox-material'
Plug 'https://gitlab.com/yorickpeterse/nvim-pqf.git'
Plug 'is0n/fm-nvim'
Plug 'beauwilliams/focus.nvim'

" Experimental ui, currently very buggy
" Plug 'MunifTanjim/nui.nvim'
" Plug 'rcarriga/nvim-notify'
" Plug 'folke/noice.nvim'

Plug 'NTBBloodbath/rest.nvim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'segeljakt/vim-silicon'
Plug 'voldikss/vim-translator'
Plug 'mfussenegger/nvim-dap'
Plug 'leoluz/nvim-dap-go'
Plug 'rcarriga/nvim-dap-ui'
Plug 'karb94/neoscroll.nvim'

call plug#end()

lua require('dimzst')
" ---------------------------------------------------------------------
" }}}

" SETTINGS "{{{
" ---------------------------------------------------------------------
let workFile = glob('~/.config/nvim/work.vim')
if !empty(workFile)
	exe 'so' workFile
endif

set background=dark

set list listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<,lead:.

set incsearch ignorecase smartcase showmatch nohlsearch
set noerrorbells novisualbell
set mouse=a

set nobackup noswapfile nowritebackup
set undofile undodir=~/.vim/undodir

set expandtab tabstop=4 softtabstop=4 shiftwidth=4
set relativenumber nu
set scrolloff=5

set splitbelow splitright

set hidden
set spell
set signcolumn=yes
set shortmess+=cI
set jumpoptions+=stack
set updatetime=300
set cmdheight=1

" THEME
syntax on
set t_Co=256

if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

" Transparency
" hi Normal guibg=NONE ctermbg=NONE
" colorscheme edge

augroup WinActiveHighLight
    autocmd!
    autocmd WinEnter * set cursorline colorcolumn=80,120
    autocmd WinLeave * set nocursorline colorcolumn=0
augroup END

" vim-test
let test#strategy = "asyncrun_background"

" vim silicon
let g:silicon = {
      \   'theme':              'gruvbox-dark',
      \   'font':          'Iosevka Nerd Font',
      \   'background':              '#FBF1C7',
      \   'shadow-color':            '#555555',
      \   'line-pad':                        2,
      \   'pad-horiz':                      80,
      \   'pad-vert':                       80,
      \   'shadow-blur-radius':              0,
      \   'shadow-offset-x':                 0,
      \   'shadow-offset-y':                 0,
      \   'line-number':                v:true,
      \   'round-corner':               v:true,
      \   'window-controls':            v:true,
      \   'output':                '/dev/null',
      \ }

" ---------------------------------------------------------------------
" }}}

" KEYMAP "{{{
" ---------------------------------------------------------------------
" CLIPBOARD
noremap <Leader>cc "*y
noremap <Leader>cv "*p

nnoremap ; :
nnoremap : ;

nnoremap <silent> <Leader>w :w<CR>

noremap <silent> <Leader>gs :Git<CR>
noremap <silent> <Leader>t :NvimTreeToggle<CR>
noremap <silent> <Leader>T :NvimTreeFindFile<CR>

nmap <silent> <leader>y :TestNearest<CR>
nmap <silent> <leader>Y :TestFile<CR>

nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [q :cprev<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [b :bprev<CR>

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
" ---------------------------------------------------------------------
" }}}

" Override "{{{
" ---------------------------------------------------------------------
autocmd FileType go setlocal noexpandtab
autocmd FileType yaml,proto,javascript,typescript setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
" ---------------------------------------------------------------------
" }}}
