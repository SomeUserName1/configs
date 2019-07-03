"========== vim-plug init ========
    if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
      silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif


"=========== PlugIns =================
    "Specify a directory for plugins
    call plug#begin('~/.local/share/nvim/plugged')

    "vim-plug
    Plug 'junegunn/vim-plug'
    " Rust support
    Plug 'rust-lang/rust.vim'
	Plug 'prabirshrestha/async.vim'
	Plug 'prabirshrestha/vim-lsp'
	Plug 'prabirshrestha/asyncomplete.vim'
	Plug 'prabirshrestha/asyncomplete-lsp.vim'

    " NerdTree
    Plug 'scrooloose/nerdtree' 

    " git integration
    Plug 'tpope/vim-fugitive'
    
    " Syntastic
    Plug 'vim-syntastic/syntastic'

    " fancy statusline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'


    " Multi-entry selection UI. FZF
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    " Change Fontsize
    Plug 'drmikehenry/vim-fontsize'

    " Graphical Un/ReDo Tree
    Plug 'sjl/gundo.vim'

    " Silver searcher integration
    Plug 'mileszs/ack.vim'

    "colorscheme
    Plug 'dikiaap/minimalist'

    Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'bash install.sh',
        \ }

    " (Optional) Multi-entry selection UI.
    Plug 'junegunn/fzf'

    " Initialize plugin system
    call plug#end()


"==== Rust conf ============
if executable('rls')
        au User lsp_setup call lsp#register_server({
                \ 'name': 'rls',
                \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
                \ 'whitelist': ['rust'],
                \ })
endif 

"==== LanguageClient conf =========
" Required for operations modifying multiple buffers like rename.
" set hidden
"
 let g:LanguageClient_serverCommands = {
	\ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
	\ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
	\ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
	\ 'python': ['/usr/local/bin/pyls'],
	\ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
\ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

"==== GUndoTree Conf ==============
    let g:gundo_width = 60
    let g:gundo_preview_height = 40
    let g:gundo_right = 1

    " remap ,u to toggle undo tree
    nnoremap <leader>u :GundoToggle<CR>

"====== ACK.vim/Ag Config =============
    if executable('ag')
      let g:ackprg = 'ag --vimgrep'
    endif

    "remap ,a to ag
    nnoremap <leader>a :Ack

"============= UI =======================
    let mapleader=","   " , is the leader key

    set hidden          " allow hidden buffers *required by PlugInManager*
    set mouse=a         " mouse integration
    set number          " show line numbers
    set showcmd         " show typed command strokes in bottom bar
    set cursorline      " highlight current cursor line
    set wildmenu        " visual tab completions menu
    set lazyredraw      " only redraw when we have to
    set showmatch       " show matching paranthesis
    set statusline+=%{FugitiveStatusline()} " git statusline

    " Color & Syntax
    set syntax=on          " syntax highlighting
    set termguicolors
    set t_Co=256
    syntax on
    colorscheme minimalist " colorscheme
    let g:airline_theme='minimalist'
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tabline#enabled = 1

    " Whitespace 
    filetype plugin indent on
    set tabstop=4
    set softtabstop=4
    set expandtab
    set shiftwidth=4
    
    " Folding
    set foldenable        " enable folding
    set foldlevelstart=0  " fold most parts (0-99)
    set foldnestmax=5     " set max nested foldings to 5
    set foldmethod=syntax " fold based on indentation
    "remap open/close folds to space
    nnoremap <space> za
    nnoremap <C-n> :NERDTree<CR>
    
    " Searching
    set hlsearch         " highlight search results
    set incsearch        " search as we type
    "turn off highlighting
    nnoremap <leader><space> :nohlsearch<CR> 

    " Movement
    "move to start/end of the line
    nnoremap B ^
    nnoremap E $

    "Highlighting
    "highlight last inserted text
    nnoremap gV `[v`]

"================= BackUps ==========
    set backup
    set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
    set backupskip=/tmp/*,/private/tmp/*
    set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
    set writebackup


