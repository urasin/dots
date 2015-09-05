" vi 互換モードで動作させない
set nocompatible

"---------------------------
" Start Neobundle Settings.
"---------------------------
" bundleで管理するディレクトリを指定
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'

" 今後このあたりに追加のプラグインをどんどん書いて行きます！！"
NeoBundle 'w0ng/vim-hybrid'

NeoBundle 'Shougo/vimproc.vim', {
                        \ 'build' : {
                        \     'windows' : 'tools\\update-dll-mingw',
                        \     'cygwin' : 'make -f make_cygwin.mak',
                        \     'mac' : 'make -f make_mac.mak',
                        \     'linux' : 'make',
                        \     'unix' : 'gmake',
                        \    },
                        \ }

NeoBundle 'Shougo/unite.vim'

NeoBundle 'thinca/vim-quickrun'
NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'sgur/vim-lazygutter'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'Shougo/neocomplete.vim'   " 補完
call neobundle#end()

" Required:
filetype plugin indent on

" 未インストールのプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定
" 毎回聞かれると邪魔な場合もあるので、この設定は任意です。
NeoBundleCheck

let g:auto_save = 1

let g:unite_enable_split_vertically=1

let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '➜'
let g:gitgutter_sign_removed = '✘'
"-------------------------
" End Neobundle Settings.
"-------------------------

set number
set relativenumber

"" tab setting
set tabstop=4
set expandtab

"set tabstop=4
" ESC response
set timeoutlen=50

"" 不可視文字
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

"" かっこの強調
set showmatch

"" ウィンドウ幅で行を折り返す
set wrap

" 色
let g:hybrid_use_iTerm_colors = 1
colorscheme hybrid

" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//ge
syntax on

" カーソルラインを強調
set cursorline

