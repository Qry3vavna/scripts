" Qry3vavna vimrc
" Thanks to Martin Brochhaus: mbrochh for lots of this code!

" F5 OPNOTES
nmap <F5> a<C-R>=strftime("%Y-%m-%d %a %H:%M:%S")<CR><Esc>
inoremap <F5> <C-R>=strftime("[" . $USER . "] %Y-%m-%d %a %H:%M:%S: ")<CR>
nnoremap <F5> "=strftime("[" . $USER . "] %Y-%m-%d %a %H:%M:%S: ")"<CR>Pa

" Better copy & paste
" When you want to paste large blocks of code into vim, press F2 before you
" paste. At the bottom you should see ``-- INSERT (paste) --``.
set pastetoggle=<F2>
set clipboard=unnamed

" Mouse and backspace
"set mouse=a  " on OSX press ALT and click
set bs=2     " make backspace behave like normal again

" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" Color scheme
" mkdir -p ~/.vim/colors && cd ~/.vim/colors
" wget -O wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
set t_Co=256
color wombat256mod

" Enable syntax highlighting
" You need to reload this file for the change to apply
filetype off
"filetype plugin indent on
syntax on

" easier formatting of paragraphs
vmap Q gq
nmap Q gqap

" Useful settings
set history=700
set undolevels=700

" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase
