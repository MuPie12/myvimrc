set nocompatible              " required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

"-------------------------------------------------------------------------
" set foldmethod=indent, creates folds based upon line indents
" whereas in our code , it might probably be a 4 spaces or +
" so for that we simply use a plugin called SimpylFold to handle it

Plugin 'tmhedberg/SimpylFold'

"-------------------------------------------------------------------------

"Auto-Indent conformed to PEP8 standards
Plugin 'vim-scripts/indentpython.vim'

"-------------------------------------------------------------------------

" Auto-Compelete code
Bundle 'Valloric/YouCompleteMe'

"-------------------------------------------------------------------------

" a Plugin which higlight the bas spaces as Red Color
" That white space can be deleted with command |EraseBadWhitespace|
Bundle 'vim-bad-whitespace'


"-------------------------------------------------------------------------
" Syntax Checking
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'

"-------------------------------------------------------------------------
" Color Scheme
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'

"-------------------------------------------------------------------------
" File Browsing
Plugin 'scrooloose/nerdtree'
" Git integration for NerdTree . If a file changes, it get highlighted
Plugin 'Xuyuanp/nerdtree-git-plugin'
"-------------------------------------------------------------------------
"Git integration with the comfort of VIM
Plugin 'tpope/vim-fugitive'


"-------------------------------------------------------------------------
" Super Seaching . For BAsically Anything
Plugin 'kien/ctrlp.vim'

"-------------------------------------------------------------------------
" Status Bar
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}


"-------------------------------------------------------------------------
"Help for Python code
Plugin 'davidhalter/jedi-vim'


"-------------------------------------------------------------------------
"Show uncommited Changes
Plugin 'airblade/vim-gitgutter'

"-------------------------------------------------------------------------
" Idenify Ruby block
"
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock'


"-------------------------------------------------------------------------
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Enable folding based on identation
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" See the docstring for the folded code
let g:SimpylFold_docstring_preview=1

" PEP8 standards
:au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" For web dev
:au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2

" Flagging unnecessary white spaces
":au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Encoding Format
set encoding=utf-8


" Set line numbers
set number

" Auto Completion goes away when done
let g:ycm_autoclose_preview_window_after_completion=1
"Shortcut for goto definition. It goes to the decalaration
"of a var in the code. The leader touch is mapped to \

map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>


"python with virtualenv support:
"This determines if you are running inside a virtualenv,
"switches to that specific virtualenv, and then sets up
" your system path so that YouCompleteMe
" will find the appropriate site packages.

if has('python')
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF
endif

" Python Highliting
let python_highlight_all=1
syntax on


" For the Color Scheme:
if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif

" Some Togglables
"
" Press F5 to switch dark/light mode for Solarized theme
call togglebg#map("<F5>")
" Nerdtree toggle
nnoremap <F6> :NERDTreeToggle<CR>

" Copy & Paste from Vim
"nnoremap <C-y > "+y
"vnoremap <C-y> "+y
"nnoremap <C-p> "+p
"vnoremap <C-p> "+p
"
" Display Help of a Python command
nnoremap <buffer> HH :<C-u>execute "!pydoc3 " . expand("<cword>")<CR>

" Ignore files in NerdTree
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" System Clipbboard
set clipboard=unnamed

"-------- Templates --------
" Python
if has("autocmd")
  augroup templates
    autocmd BufNewFile *.py 0r ~/.vim/templates/skeleton.py
  augroup END
endif

" Bash
if has("autocmd")
  augroup templates
    autocmd BufNewFile *.sh 0r ~/.vim/templates/skeleton.sh
  augroup END
endif


" Ruby
if has("autocmd")
  augroup templates
    autocmd BufNewFile *.rb 0r ~/.vim/templates/skeleton.rb
  augroup END
endif
"
"-------- End of Templates -----------
" NerdTree Indicator for Git
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
"Git  Gutter config
set signcolumn=yes

nmap ]h <Plug>(GitGutterNextHunk) "same as default
nmap [h <Plug>(GitGutterPrevHunk) "same as default

nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)

let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '✹'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '-'
let g:gitgutter_sign_modified_removed = '-'


" Calll hidden buffers
set hidden

" Highlight the line
set cursorline

" needed for ruby block
runtime macros/matchit.vim
