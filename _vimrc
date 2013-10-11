"-----------------------------------------------------------------------------
" 一般
"
" viとの互換をとらない
set nocompatible
" コマンド、検索パターンを50個まで履歴に残す
set history=100

"-----------------------------------------------------------------------------
" 検索関連
"
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索時に最後まで行ったら最初に戻らない
set nowrapscan
" 検索文字列入力時に順次対象文字列にヒットさせない
set noincsearch
"-----------------------------------------------------------------------------
" 装飾関連
"
"行番号を表示させる
"set number
" タイトルをウインドウ枠に表示
set notitle
" ルーラーを表示
set ruler
" タブや改行を表示しない
set nolist
" 入力中のコマンドをステータスに表示する
set showcmd
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" ステータスラインに表示する情報の指定
set statusline=%y%{GetStatusEx()}%F%m%r%=<%c:%l>
" ステータスラインの色
hi StatusLine   term=NONE cterm=NONE ctermfg=black ctermbg=white
" ハイライト
"if &t_Co > 2 || has("gui_running")
if &t_Co > 2
        " シンタックスハイライトを有効にする
        syntax on
        " 検索結果文字列のハイライトを有効にする
        set hlsearch
endif
"-----------------------------------------------------------------------------
" 編集、文書整形関連
"
" backspaceキーの挙動を設定する
" indent        : 行頭の空白の削除を許す
" eol           : 改行の削除を許す
" start         : 挿入モードの開始位置での削除を許す
set backspace=indent,eol,start
" 新しい行を直前の行と同じインデントにする
set autoindent
" Tab文字を画面上の見た目で何文字幅にするか設定
set tabstop=4
" cindentやautoindent時に挿入されるタブの幅
set shiftwidth=4
" Tabキー使用時にTabでは無くホワイトスペースを入れたい時に使用する
" この値が0以外の時はtabstopの設定が無効になる
"set softtabstop=0
set softtabstop=4
" Tab文字を空白に置き換える
set expandtab
" オートインデントを有効にする
set cindent
"-----------------------------------------------------------------------------
" ファイル関連
"
" nobackup
" バックアップファイルを作成しない
set nobackup
"  add filetype setting
au BufNewFile,BufRead *.hql setf sql
"-----------------------------------------------------------------------------
" 国際化関連
"
" 文字コードの設定
" fencsの記述にはeuc-jp（encの値）は一番最後に記述する必要がある
" vimはファイルのオープン時にfencsの値を先頭から参照していき、fencsと値が
" 一致したエンコーディングでファイルをオープンする
" この時、一致しなくともencで指定されたエンコーディングが現れると無条件で
" そのエンコーディングでファイルを開いてしまうため
set encoding=utf-8
"set encoding=sjis
"set termencoding=euc-jp
"set fileencoding=euc-jp
"set fileencodings=ucs-bom,iso-2022-jp,utf-8,ucs-2le,ucs-2,cp932,euc-jp
"-----------------------------------------------------------------------------
" マップ定義
"
" 今は何もなし

"-----------------------------------------------------------------------------
" オートコマンド
"
if has("autocmd")
        " プラグイン、ファイルタイプ別インデントを有効
        filetype plugin indent on
        " textファイルのカラムを100に設定
        autocmd FileType text setlocal textwidth=100
        " カーソル位置を記憶しておく
        autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

endif " has("autocmd")

"-----------------------------------------------------------------------------
" Function定義
"
" GetStatusEx
" ステータス表示用function
function! GetStatusEx()
        let str = ''
        let str = str . '' . &fileformat . ']'
        if has('multi_byte') && &fileencoding != ''
        let str = '[' . &fileencoding . ':' . str
        endif
        return str
endfunction


"vundle setting
set rtp+=~/.vim/vundle.git/
call vundle#rc()
 
" vim-scripts for git
"github のvim-fugitive
Bundle 'tpope/vim-fugitive'
Bundle 'altercation/vim-colors-solarized'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neosnippet'
Bundle 'ken223/vim-snippets'
"Bundle 'mitechie/pyflakes-pathogen'
"Bundle 'scrooloose/syntastic.git' , {
"  \ "build": {
"  \   "mac": ["pip install flake8", "npm -g install coffeelint"],
"  \   "unix": ["pip install flake8", "npm -g install coffeelint"],
"  \ }}
Bundle 'vim-scripts/sudo.vim'
Bundle 'scrooloose/nerdtree'

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
" for Bundle setting
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'


" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?  "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?  "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" For NerdTree
"<C-n>でNERDTreeをオンオフ。いつでもどこでも。
nmap <silent> <C-n>      :NERDTreeToggle<CR>
vmap <silent> <C-n> <Esc>:NERDTreeToggle<CR>
omap <silent> <C-n>      :NERDTreeToggle<CR>
imap <silent> <C-n> <Esc>:NERDTreeToggle<CR>
cmap <silent> <C-n> <C-u>:NERDTreeToggle<CR>

"他のバッファをすべて閉じた時にNERDTreeが開いていたらNERDTreeも一緒に閉じる。
""How can I close vim if the only window left open is a NERDTree?
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"NERDTreeShowHidden 隠しファイルを表示するか？
"f コマンドの設定値
"0 : 隠しファイルを表示しない。
"1 : 隠しファイルを表示する。
"Values: 0 or 1.
"Default: 0.
"let g:NERDTreeShowHidden=0
let g:NERDTreeShowHidden=1


" neocomplecache
" 起動時に有効
let g:neocomplcache_enable_at_startup = 1
" snippet ファイルの保存先
let g:neocomplcache_snippets_dir='~/.vim/bundle/vim-snippets/snippets'
" dictionary
"let g:neocomplcache_dictionary_filetype_lists = {
"    \ 'default' : '',
"    \ 'objc' : $HOME . '/.vim/dict/objc.dict'
"\ }
" 日本語をキャッシュしない
"let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
" 補完候補の数
let g:neocomplcache_max_list = 5
" 1番目の候補を自動選択
let g:neocomplcache_enable_auto_select = 1
" 辞書読み込み
"noremap  <Space>d. :<C-u>NeoComplCacheCachingDictionary<Enter>
" <TAB> completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" C-jでオムニ補完
inoremap <expr> <C-j> &filetype == 'vim' ? "\<C-x>\<C-v>\<C-p>" : "\<C-x>\<C-o>\<C-p>"
" C-kを押すと行末まで削除
"inoremap <C-k> <C-o>D
" C-nでneocomplcache補完
inoremap <expr><C-n>  pumvisible() ? "\<C-n>" : "\<C-x>\<C-u>\<C-p>"
" C-pでkeyword補完
inoremap <expr><C-p> pumvisible() ? "\<C-p>" : "\<C-p>\<C-n>"
" 補完候補が表示されている場合は確定。そうでない場合は改行
inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "<CR>"
" 補完をキャンセル
inoremap <expr><C-e>  neocomplcache#close_popup()

" 色設定 
" coler scheme
syntax enable
colorscheme torte
" 自動保管の色
highlight Pmenu ctermbg=4 ctermfg=0
highlight PmenuSel ctermbg=1 ctermfg=7
highlight PMenuSbar ctermbg=4

" for golang
if $GOROOT != ''
  filetype off
  filetype plugin indent off
  set rtp+=$GOROOT/misc/vim
  filetype plugin indent on
  syntax on
endif
