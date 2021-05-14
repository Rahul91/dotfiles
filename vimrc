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
set clipboard=unnamed
set cc=120
set modifiable
set ttyfast
set foldmethod=indent
set foldlevel=99
set guicursor=i:ver25-iCursor

" Allow us to use Ctrl-s and Ctrl-q as keybinds
silent !stty -ixon

" Restore default behaviour when leaving Vim.
autocmd VimLeave * silent !stty ixon

let mapleader=","
imap jj <Esc>
nnoremap d "_d
vnoremap d "_d

" move to beginning/end of line
nnoremap B ^
nnoremap E $
map <C-a> <ESC>^
map <C-e> <ESC>$

" Mapping ctlr-c to put in insert mod.
nnoremap <c-c> i

call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdcommenter'
Plug 'jremmen/vim-ripgrep'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'idanarye/vim-merginal'
Plug 'moll/vim-bbye'
Plug 'tmhedberg/SimpylFold'
Plug 'tpope/vim-sensible'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'jiangmiao/auto-pairs'

call plug#end()

" ColourScheme
colorscheme gruvbox
set background=dark

" Set code folding shortcut with space.
nnoremap <space> za
let g:SimpylFold_docstring_preview=1


if executable('rg')
    let g:rg_derive_root='true'
endif

" use the silver searcher
 let g:agprg="ag -i --vimgrep"
 let g:ag_highlight=1

" NerdCommenter.
let g:NERDSpaceDelims = 1

" Md preview
let vim_markdown_preview_hotkey='<C-g>'

" Black
let g:black_linelength=120
let g:black_skip_string_normalization=1
let g:black_virtualenv="/Users/rahulmishra/.virtualenvs/py3/bin/black"

" merginal
nnoremap <leader>gm :MerginalToggle<CR>

" fugitive
nnoremap <Leader>ga :Git add %:p<CR><CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <leader>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <leader>gp :Ggrep<Space>
nnoremap <leader>gb :Git branch<Space>
nnoremap <leader>gco :Git checkout<Space>
nnoremap <leader>gc :Git commit -am ""<Left>
command! -bar -nargs=* Gpull execute 'Git pull'
command! -bar -nargs=* Gpush execute 'Git push'

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

" Toggle NERDTreeToggle
map <C-n> :NERDTreeToggle<CR>
nnoremap <Leader>m :NERDTreeFind<cr>
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
nnoremap <silent> <c-b> :Buffers<cr>

filetype plugin indent on

let python_highlight_all=1

au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=120 expandtab autoindent fileformat=unix

" NERDTree changes.
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" Handy shortcut
noremap <silent> <c-s> :update<CR>
vnoremap <silent> <c-s> <c-c>:update<CR>
inoremap <silent> <c-s> <c-o>:update<CR>
inoremap <C-x> <esc>:wq!<cr>
nnoremap <C-x> :wq!<cr>

nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>

" Map the <Space> key to toggle a selected fold opened/closed.
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

autocmd BufWritePre * :call TrimWhitespace()

" Pydoc
let g:pydocstring_formatter = 'google'
nmap <silent> <s-d> <Plug>(pydocstring)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Splits and Tabbed Files
set splitbelow splitright

" Move between split windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Make adjusing split sizes a bit more friendly
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>

nnoremap <Leader>t gt<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Open terminal inside Vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Leader>tt :term<CR>

" Line move up and down.
noremap <c-s-up> :call feedkeys( line('.')==1 ? '' : 'ddkP' )<CR>
noremap <c-s-down> ddp
