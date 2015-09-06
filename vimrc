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
NeoBundle 'Shougo/neocomplete.vim'   " 補完

NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'sgur/vim-lazygutter'
NeoBundle 'Yggdroot/indentLine'
NeoBundle "tyru/caw.vim.git"  " コメントアウト
NeoBundle 'tpope/vim-endwise'  " end自動挿入
NeoBundle 'vim-scripts/MultipleSearch'  " 検索業ハイライト
NeoBundle 'Townk/vim-autoclose'  " 閉じかっこ入力
call neobundle#end()

" Required:
filetype plugin indent on

" 未インストールのプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定
" 毎回聞かれると邪魔な場合もあるので、この設定は任意です。
NeoBundleCheck

let g:indentLine_faster = 1

let g:unite_enable_split_vertically=1
" uniteで検索時に大文字、小文字を無視する
call unite#set_profile('default', 'context', {'ignorecase':1})

let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '➜'
let g:gitgutter_sign_removed = '✘'
"-------------------------
" End Neobundle Settings.
"-------------------------
set backspace=indent,eol,start
set number
set relativenumber

"" tab setting
set tabstop=4
set expandtab

" ESC response
set timeoutlen=15000
set ttimeoutlen=35

"" 不可視文字
set list
set listchars=tab:»-,extends:»,precedes:«,nbsp:%

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

"スペルチェックを有効にする(ただし日本語は除外する)
set spelllang+=cjk
set spell

" ファイルタイプの判定
filetype on

" 空白文字のハイライト
augroup HighlightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
  autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END

" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %

" 改行での自動コメントアウトを無効にする
autocmd FileType * setlocal formatoptions-=ro

" 検索時に大文字小文字をくべつしない
set ignorecase

" 検索行をハイライト
set hlsearch

" インクルメンタルサーチ
set incsearch

"" ---------- tyru/caw.vim.git関連(crt + k でコメントアウト)
nmap <C-K> <Plug>(caw:i:toggle)
vmap <C-K> <Plug>(caw:i:toggle)

"" ---------- Quick Run関連
" QuickRunのショートカット
nnoremap qw :QuickRun<CR>
" 右側に結果を表示
let g:quickrun_config={'*': {'split': 'vertical'}}
" 実行時間を表示
let g:quickrun_config = {'*': {'hook/time/enable': '1'},}
set splitright "新しいウィンドウを右に開く

"" ---------- Unite 関連
" 入力モードで開始する
let g:unite_enable_start_insert=1

nnoremap [unite]    <Nop>
nmap     <Space> [unite]

" スペースキーとbキーでバッファを表示
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>

" スペースキーとENTERキーでfile_rec:!
nnoremap <silent> [unite]<CR> :<C-u>Unite<Space>file_rec/async:!<CR>

" ヒストリー/ヤンク機能を有効化
let g:unite_source_history_yank_enable =1

" スペースキーとhキーでヒストリ/ヤンクを表示
nnoremap <silent> [unite]h :<C-u>Unite<Space>history/yank<CR>

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

" 高速化 https://github.com/Shougo/unite.vim/issues/326
call unite#custom#source('file_rec/async', 'ignore_pattern', '\(png\|gif\|jpeg\|jpg\)$')
let g:unite_source_rec_max_cache_files = 5000
