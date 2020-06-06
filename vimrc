syntax on

set guicursor=
set noshowmatch
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set encoding=utf-8
set cmdheight=2
set updatetime=50
set shortmess+=c
set splitright
set clipboard=unnamed
set cc=120
set diffopt+=vertical

let mapleader = ","
imap jj <Esc>
nnoremap d "_d
vnoremap d "_d

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

call plug#begin('~/.vim/plugged')

Plug 'jremmen/vim-ripgrep'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'davidhalter/jedi-vim'
Plug '907th/vim-auto-save'
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }

call plug#end()

" ColourScheme
colorscheme gruvbox
set background=dark

if executable('rg')
    let g:rg_derive_root='true'
endif

" use the silver searcher
 let g:agprg="ag -i --vimgrep"
 let g:ag_highlight=1

" ripgrep and fzf
command! -bang -nargs=* F
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow
  \   --color always -g "*.{py}"
  \   '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
set grepprg=rg\ --vimgrep\ $*

" Git Gutter options
highlight clear SignColumn
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=yellow
highlight GitGutterDelete ctermfg=red
highlight GitGutterChangeDelete ctermfg=yellow


" Jedi Options
" let g:jedi#use_tabs_not_buffers = 1

" Toggle NERDTreeToggle
map <C-n> :NERDTreeToggle<CR>
map <leader>r :NERDTreeFind<cr>
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)


" Add `:Format` command to format current buffer.
command! -nargs=0 Fmt  :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 Or   :call     CocAction('runCommand', 'editor.action.organizeImport')

set rtp+=/usr/local/opt/fzf

let g:coc_disable_startup_warning = 1

nnoremap <silent> <c-p> :GFiles<cr>
nnoremap <silent> <c-o> :History<cr>
nnoremap <silent> <c-f> :BLines<cr>
inoremap <silent> <c-f> :BLines<cr>
nnoremap <Leader>lb :Buffers<cr>
nnoremap <Leader>m :NERDTreeFind<cr>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>

filetype plugin indent on

let python_highlight_all=1

au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=120 expandtab autoindent fileformat=unix

" NERDTree changes.
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree


" For saving files
let g:auto_save = 1
let g:auto_save_events = ["InsertLeave", "TextChanged"]

nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
nnoremap <silent> <C-w>T :tab split<CR>

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

autocmd BufWritePre * :call TrimWhitespace()

" Pydoc
let g:pydocstring_formatter = 'google'
nmap <silent> <s-d> <Plug>(pydocstring)
