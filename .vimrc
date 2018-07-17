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

    Plug 'lervag/vimtex'

    " NerdTree
    Plug 'scrooloose/nerdtree' 

    " git integration
    Plug 'tpope/vim-fugitive'

    " fancy statusline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " virtualenvs
    Plug 'plytophogy/vim-virtualenv'
 
    " Multi-entry selection UI. FZF
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    " deoplete auto complete
    if has('nvim')
        Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    else
        Plug 'Shougo/deoplete.nvim'
        Plug 'roxma/nvim-yarp'
        Plug 'roxma/vim-hug-neovim-rpc'
    endif

    " Change Fontsize
    Plug 'drmikehenry/vim-fontsize'

    " Graphical Un/ReDo Tree
    Plug 'sjl/gundo.vim'

    " Silver searcher integration
    Plug 'mileszs/ack.vim'

    "colorscheme
    Plug 'dikiaap/minimalist'

    Plug 'vim-syntastic/syntastic'
    " Initialize plugin system
    call plug#end()

    " Required for operations modifying multiple buffers like rename.


"============ LangServerProtocol Config =========
    let g:deoplete#enable_at_startup = 1

    " syntastic settings
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0

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


"======= vimtex ==========
    

"============= UI =======================
    let mapleader=","   " , is the leader key
    let maplocalleader=","

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
    set list
    set shiftwidth=4
    set tw=80 ff=unix


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
    nnoremap <C-w>d :bd<CR>

    "Highlighting
    "highlight last inserted text
    nnoremap gV `[v`]

"================= BackUps ==========
    set backup
    set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
    set backupskip=/tmp/*,/private/tmp/*
    set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
    set writebackup

" Remove all trailing whitespaces in the file by doing ':TW'
function TrimWhitespace()
   let l:save = winsaveview()
   %s/\s\+$//e
   call winrestview(l:save)
endfunction
command! TW call TrimWhitespace()


" OpenCog code style
autocmd BufNewFile,BufReadPost * if match(expand("%:p:h"), "/opencog") >= 0 && &filetype == "cpp" | set ts=4 sw=4 tw=80 ff=unix cindent expandtab | endif
