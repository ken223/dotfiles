"-----------------------------------------------------------------------------
" 一般
"
" viとの互換をとらない
set nocompatible
" コマンド、検索パターンを50個まで履歴に残す
set history=50

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
        " textファイルのカラムを78に設定
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
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neosnippet'
Bundle 'ken223/vim-snippets'
Bundle 'kevinw/pyflakes-vim'
Bundle 'vim-scripts/sudo.vim'

" for Bundle setting
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'


" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?  "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?  "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

