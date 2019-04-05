if v:progname =~? "evim"
        finish
endif

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
        set mouse=a
endif

" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
if &t_Co > 2 || has("gui_running")
        syntax on

        " Also switch on highlighting the last used search pattern.
        set hlsearch

        " I like highlighting strings inside C comments.
        let c_comment_strings=1
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

        " Enable file type detection.
        " Use the default filetype settings, so that mail gets 'tw' set to 72,
        " 'cindent' is on in C files, etc.
        " Also load indent files, to automatically do language-dependent indenting.
        filetype plugin indent on

        " Put these in an autocmd group, so that we can delete them easily.
        augroup vimrcEx
                au!

                " For all text files set 'textwidth' to 78 characters.
                autocmd FileType text setlocal textwidth=78

                " When editing a file, always jump to the last known cursor position.
                " Don't do it when the position is invalid or when inside an event handler
                " (happens when dropping a file on gvim).
                autocmd BufReadPost *
                                        \ if line("'\"") >= 1 && line("'\"") <= line("$") |
                                        \   exe "normal! g`\"" |
                                        \ endif

        augroup END

else

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
        command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                                \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
        " Prevent that the langmap option applies to characters that result from a
        " mapping.  If unset (default), this may break plugins (but it's backward
        " compatible).
        set langnoremap
endif

"dein Scripts-----------------------------

" Required:
set runtimepath+=/Users/sat/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/sat/.cache/dein')
        call dein#begin('/Users/sat/.cache/dein')

        " Let dein manage dein
        " Required:
        call dein#add('/Users/sat/.cache/dein/repos/github.com/Shougo/dein.vim')

        " http://kyo-bad.hatenablog.com/entry/2016/05/28/172510
        " ==========================
        " プラグインリストを収めたTOMLファイル
        let g:dein_dir = expand('/Users/sat/.cache/dein')
        let s:toml = g:dein_dir . '/dein.toml'
        let s:lazy_toml = g:dein_dir . '/dein_lazy.toml'

        " TOMLファイルにpluginを記述
        call dein#load_toml(s:toml, {'lazy': 0})
        call dein#load_toml(s:lazy_toml, {'lazy': 1})

        " ==========================
        " Add or remove your plugins here like this:
        " call dein#add('Shougo/neosnippet.vim')
        " call dein#add('Shougo/neosnippet-snippets')

        " Required:
        call dein#end()
        call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins onstartup.
if dein#check_install()
        call dein#install()
endif

"End dein Scripts-------------------------

" Setting 非同期文法チェッカ
" https://wonderwall.hatenablog.com/entry/2017/03/01/223934
let g:ale_sign_column_always = 1
highlight clear ALEErrorSign
highlight clear ALEWarningSign
" エラー時に文字と背景の色が同化して嫌なので
highlight ALEWarning ctermfg=160
highlight ALEError ctermfg=160
" Setting end

highlight Cursorline cterm=NONE ctermfg=NONE ctermbg=black
highlight LineNr ctermfg=235
inoremap <Tab> <Esc>
nnoremap : ;
nnoremap ; :
set autoindent
set backspace=indent,eol,start
set clipboard+=unnamed
set cursorline
set encoding=utf-8
set expandtab
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac
set history=50		" keep 50 lines of command line history
set incsearch		" do incremental searching
set nobackup
set nocompatible
set noswapfile
set noundofile
set nowrap
set number
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set smartindent

" Get the 2-space YAML as the default when hit carriage return after the colon
" https://gist.github.com/dragonken/c29123e597c6fdf022284cf36d245b64
autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType python setl ts=4 sts=4 sw=4 cinwords=if,elif,else,for,while,try,except,finally,def,class expandtab
autocmd FileType java setl ts=4 sts=4 sw=4 expandtab
autocmd FileType ruby setl ts=2 sts=2 sw=2 expandtab
autocmd FileType sh setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yaml setlocal ts=2 sts=2 sw=2
" http://www.kamakuraheart.org/wordpress/?p=3995
" tab+enterで開いているファイルを実行
autocmd BufNewFile,BufRead *.py nnoremap <tab> :!python %
autocmd BufNewFile,BufRead *.java nnoremap <tab> :!javac % && java %<

" https://qiita.com/kouichi_c/items/e19ccf94b8e5ab6ed18e
" 2019/01/04
call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-markdown'
Plug 'kannokanno/previm'
Plug 'tyru/open-browser.vim'
call plug#end()
""" markdown {{{
autocmd BufRead,BufNewFile *.mkd  set filetype=markdown
autocmd BufRead,BufNewFile *.md  set filetype=markdown
" Need: kannokanno/previm
nnoremap <silent> <C-i> :PrevimOpen<CR> " Ctrl-iでプレビュー
" 自動で折りたたまないようにする
let g:vim_markdown_folding_disabled=1
let g:previm_enable_realtime = 1
