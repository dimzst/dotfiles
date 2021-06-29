set encoding=utf-8

""""""""""""""""""""""""""""""
"          PLUGIN            "
""""""""""""""""""""""""""""""
call plug#begin('~/.local/share/nvim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-commentary'

Plug 'sheerun/vim-polyglot'
Plug 'mhinz/vim-signify'

Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'vim-airline/vim-airline'

call plug#end()

""""""""""""""""""""""""""""""
"         END PLUGIN         "
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
"          GENERAL           "
""""""""""""""""""""""""""""""
set list listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

set incsearch ignorecase smartcase showmatch nohlsearch
set noerrorbells novisualbell

set noexpandtab tabstop=4 softtabstop=4 shiftwidth=4
set relativenumber nu

set nobackup noswapfile nowritebackup 
set undofile undodir=~/.vim/undodir

set scrolloff=4

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

" COC
set hidden
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

" NETRW
set splitbelow
set splitright

let g:go_highlight_function_calls=1
let g:go_highlight_function_parameters=1
let g:go_highlight_function_arguments=1

""""""""""""""""""""""""""""""
"         END GENERAL        "
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
"         BINDING            "
""""""""""""""""""""""""""""""
let mapleader=" "

" CLIPBOARD
noremap <Leader>cc "*y
noremap <Leader>cv "*p

" COC 
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else 
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" FZF
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

nnoremap <silent> <C-p> :FZF -m<cr>

command! -bang -nargs=* PRg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview({'dir': expand('%:p:h')}), <bang>0)

" AUTO CLOSE BRACKET
inoremap " ""<left>
inoremap ' ''<left>
inoremap ` ``<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" PANE NAVIGATION
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" let g:go_def_mapping_enabled = 0
" let g:go_fmt_command="gopls"
" let g:go_gopls_gofumpt=1


""""""""""""""""""""""""""""""
"       END BINDING          "
""""""""""""""""""""""""""""""
