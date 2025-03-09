"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()
Plug 'gruvbox-community/gruvbox'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'preservim/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'nvim-lua/plenary.nvim'
Plug 'ThePrimeagen/harpoon'

call plug#end()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax / Highlight / Visual / Audio / etc. 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
set number
set relativenumber
colorscheme elflord
if has('nvim')
	set background=dark
	colorscheme gruvbox
endif
set signcolumn=yes
set colorcolumn=80
set cursorline
set noeb vb t_vb=
set noerrorbells
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabs / Indent / Wrap
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set wrap
set nohlsearch
set noincsearch
set ignorecase
set smartcase
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Splits / Buffers 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set splitbelow
set splitright
set hidden
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Status bar 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Some type specific configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = " "
filetype on
filetype plugin on
filetype indent on " file type based indentation
augroup filetype
  autocmd BufNewFile,BufRead *.txt set filetype=human
augroup END
autocmd FileType human set formatoptions-=t textwidth=0 
autocmd FileType html,xhtml,css,xml,xslt set shiftwidth=2 softtabstop=2 
autocmd FileType make set noexpandtab shiftwidth=4 softtabstop=0
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Navigate files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Harpoon Link: https://github.com/ThePrimeagen/harpoon 
nnoremap <leader>hh :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <leader>ha :lua require("harpoon.mark").add_file()<CR>
nnoremap <C-y> :lua require("harpoon.ui").nav_next()<CR>
nnoremap <C-x> :lua require("harpoon.ui").nav_prev()<CR>
" Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Motions 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Window
nnoremap <C-j> <C-W>j    " Window up
nnoremap <C-k> <C-W>k    " Window down
nnoremap <C-h> <C-W>h    " Window left
nnoremap <C-l> <C-W>l    " Window right
" Resize
nnoremap <C-A-j> :resize +3<CR>
nnoremap <C-A-k> :resize -3<CR>
nnoremap <C-A-h> :vertical resize +3<CR>
nnoremap <C-A-l> :vertical resize -3<CR>
" 1/2 Page jump
nnoremap <C-d> <C-d>zz          " Cursor half page down (centered)
nnoremap <C-u> <C-u>zz          " Cursor half page up (centered)
" Other
nnoremap <n> nzzzv              " Cursor half page down (centered)
nnoremap <N> Nzzzv              " Cursor half page up (centered)
nnoremap "<leader>p" "\"_dP     " Keep copy
tnoremap <Esc> <C-\><C-n>       " Escape terminal 
