" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/.git/*

set termguicolors
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

call plug#begin()
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
" telescope requirements...
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'vuciv/vim-bujo'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim'
" tpope plugins
Plug 'tpope/vim-surround'


" Initialize plugin system
call plug#end()

lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "maintained",

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing
  ignore_install = {},

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- list of language that will be disabled
    disable = {},

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

" Plug 'hoob3rt/lualine.nvim' {{{
lua << EOF
require('plenary.reload').reload_module('lualine', true)
require('lualine').setup({
  options = {
    theme = 'dracula',
    disabled_types = { 'NvimTree' }
  },
  sections = {
    lualine_x = {},
    -- lualine_y = {},
    -- lualine_z = {},
  }
})
EOF
" }}}

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

" vim TODO
nmap <Leader>tu <Plug>BujoChecknormal
nmap <Leader>th <Plug>BujoAddnormal
let g:bujo#todo_file_path = $HOME . "/.cache/bujo"

" Find files across project
nnoremap <leader>ff :lua require'telescope.builtin'.find_files{ hidden = true }<cr>
" Find files with grep across project
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep( { file_ignore_patterns = { '**/*.spec.js' } } )<cr>
" Find my git status change
nnoremap <Leader>fc :lua require'telescope.builtin'.git_status{}<cr>
" telescope through file system
nnoremap <leader>fs <cmd>lua require 'telescope'.extensions.file_browser.file_browser( { path = vim.fn.expand('%:p:h') } )<CR>
" telescope through active buffers
nnoremap <leader>fb <cmd>Telescope buffers<cr>

" set up bufferline TODO: get the config to work on this
lua << EOF
require('bufferline').setup {}
EOF
