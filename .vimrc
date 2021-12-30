set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/bundle/Vundle.vim/YouCompleteMe
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'scrooloose/nerdtree'
Plugin 'vimwiki/vimwiki'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'slashmili/alchemist.vim'
Plugin 'elixir-editors/vim-elixir'
Plugin 'liuchengxu/space-vim-dark'
Plugin 'neoclide/coc.nvim'

call vundle#end()
call plug#begin('~/.vim/plugged')
Plug 'justinmk/vim-sneak'
call plug#end()

" python identation
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2 softtabstop=2 shiftwidth=2

let mapleader=" "

" The Silver Searcher - Much faster than using systems grep for files
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

"split navigations
nnoremap <leader>j <C-W><C-J>
nnoremap <leader>k <C-W><C-K>
nnoremap <leader>l <C-W><C-L>
nnoremap <leader>h <C-W><C-H>
" might also want to try map <leader>h :windcmd h<CR> - say this on pythag

nnoremap <silent> <leader>f :files<CR>
nnoremap <silent> <leader><space> :buffers<CR>
nnoremap <silent> <leader>A :Windows<CR>
nnoremap <silent> <leader>l :BLines<CR>
nnoremap <silent> <leader>o :BTags<CR>
nnoremap <silent> <leader>t :Tags<CR>
nnoremap <silent> <leader>? :History<CR>
nnoremap <silent> <leader>s :Rg<CR>

" Simple sizing of splits
map - <C-W>-
map + <C-W>+

nnoremap <leader>gd :GoDef<Enter>
nnoremap <leader>pt :NERDTreeToggle<Enter>
nnoremap <leader>pv :NERDTreeFind<CR>
nnoremap <leader>vr :vertical resize 30<CR>
nnoremap <leader>r+ :vertical resize +5<CR>
nnoremap <leader>r- :vertical resize -5<CR>
vmap <leader>y "+y

set foldmethod=syntax
set foldnestmax=10
set nofoldenable
set foldlevel=2

color space-vim-dark
set termguicolors
hi LineNr ctermbg=NONE guibg=NONE
syntax on

set relativenumber
