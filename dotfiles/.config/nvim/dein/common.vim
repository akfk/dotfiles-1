" ==============================================================================
"                                      Common
" ==============================================================================

set synmaxcol=500                 " ハイライトする文字数を制限する
set backspace=indent,eol,start    " インサートモード時にバックスペースを使う
set whichwrap=b,s,h,l,<,>,[,]     " 行頭から前行文末へ移動可能にする
" set scrolloff=999               " スクロール時にカーソルを中央へ移動
set scrolloff=3                   " スクロールを開始する行数
set cindent                       " cオートインデント
set cinoptions=g0                 " cppでのpublic宣言を下げる
set showtabline=2                 " タブ(上部)を常に表示する
set number                        " 行数を表示する
set nohlsearch                    " 検索文字列を強調を無効化
set ignorecase                    " 大文字小文字を無視
set smartcase                     " (ただし大文字入力時のみ考慮)
set guioptions-=m                 " メニューバーを非表示
set guioptions-=T                 " ツールバーを非表示
set guioptions-=e                 " TabのGUI表示をOFF
set colorcolumn=80                " 80文字のライン
set wildmenu                      " コマンドモードの補完方法
set diffopt+=vertical             " diffは縦分割
set conceallevel=0                " 非表示文字も表示
set nobackup                      " バックアップhoge~を作成しない
set belloff=all                   " ビープ音無効化
set termguicolors                 " CLIでフルカラー
" set ttimeoutlen=50              " ノーマルモードに戻る時間
set cursorline                    " カーソル行をハイライト

" === Encoding ===
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis,latin1
set fileformats=unix,dos,mac

" === Folding ===
autocmd FileType * set foldmethod=syntax
autocmd FileType python set foldmethod=indent
autocmd FileType glsl set foldmethod=indent
autocmd FileType verilog set foldmethod=indent
autocmd FileType text set foldmethod=indent
set nofoldenable                           " 自動では折りたたまない
set foldlevel=0
set foldcolumn=2

" === PreviewWindow ===
set completeopt=menuone,longest,preview    " プレビューウインドウで表示
set previewheight=1                        " プレビューウインドウの高さ
set splitbelow                             " 下に表示
set laststatus=2                           " ステータスラインを常に表示
" autocmd BufWritePre * :%s/\s\+$//ge      " 保存時に行末の空白を除去

" === Tab Settings ===
" Hard Tab
" autocmd FileType * set tabstop=4 shiftwidth=4 noexpandtab
" autocmd FileType * set tabstop=2 shiftwidth=2 expandtab
" Soft Tab
autocmd FileType * set tabstop=4 shiftwidth=4 expandtab
autocmd FileType javascript set tabstop=2 shiftwidth=2 expandtab
autocmd FileType python     set tabstop=4 shiftwidth=4 expandtab
autocmd FileType neosnippet set noexpandtab

"=== Font Settings (for gvim) ===
if has('win32') || has('win64')
    " Windows
    set guifont=DejaVu\ Sans\ Mono\ Book\ 10.0
    " set guifont=MS_Gothic:h10
else
    " Others
    set guifont=DejaVu\ Sans\ Mono\ Book\ 11.0
endif

"=== Infinity Undo ===
if has('persistent_undo')
    set undodir=~/.vimundo  " ~/.vim/undo
    set undofile
endif

"===== Quickfix =====
autocmd QuickfixCmdPost make,grep,grepadd,vimgrep copen  "自動で開く

"===== KeyBind =====
" 再描画
nnoremap <F5> <C-l>
inoremap <F5> <Esc><C-l>a
" 上下移動を表記上のものにする
map j gj
map k gk
noremap <Up> g<Up>
noremap <Down> g<Down>
" 高速移動 上下移動は滑らかに
noremap <C-h> 10h
noremap <C-l> 10l
noremap <C-j> 20j
noremap <C-k> 20k
" 行末行頭への移動
noremap 9 ^
noremap 0 $
" タブ移動
nnoremap <F3> gt
inoremap <F3> <Esc>gt
nnoremap <F2> gT
inoremap <F2> <Esc>gT
nnoremap 3 gt
nnoremap 2 gT
nnoremap " :tabm -1 <CR>
nnoremap # :tabm +1 <CR>
" クリップボードから貼り付け,コピー
inoremap <C-v> <ESC>"+gp
vnoremap <C-c> "+y
" 折り込み
" nnoremap <C-c> zc
" inoremap <C-c> <Esc>zc
" F1のヘルプを無効化
map <F1> <Esc>
" 終了(q)を無効化
map <C-q> <Esc>
" Vimgrep
nmap <A-[> :cN<CR>
nmap <A-]> :cn<CR>
" Quickfix windowの非表示
nnoremap <C-c> :cclose<CR>
" Terminal
nnoremap <F4> :terminal ++rows=10<CR>
tnoremap <F4> <C-\><C-n>>:q!<CR>
tnoremap <silent> <ESC> <C-\><C-n>
" omni補完
inoremap <C-o> <C-x><C-o>

"==== Auto fcitx ====
let g:input_toggle = 0
function! Fcitx2en()
    let s:input_status = system("fcitx-remote")
    if s:input_status == 2
        let g:input_toggle = 1
        let l:a = system("fcitx-remote -c")
    endif
endfunction
function! Fcitx2zh()
    let s:input_status = system("fcitx-remote")
    if s:input_status != 2 && g:input_toggle == 1
        let l:a = system("fcitx-remote -o")
        let g:input_toggle = 0
    endif
endfunction
set iminsert=0
set imsearch=0
autocmd InsertLeave *.txt call Fcitx2en()
autocmd InsertEnter *.txt call Fcitx2zh()
autocmd InsertLeave *.tex call Fcitx2en()
autocmd InsertEnter *.tex call Fcitx2zh()
autocmd InsertLeave *.md call Fcitx2en()
autocmd InsertEnter *.md call Fcitx2zh()
autocmd InsertLeave *.plaintex call Fcitx2en()
autocmd InsertEnter *.plaintex call Fcitx2zh()

"===== engdict (http://d.hatena.ne.jp/aki-yam/20080629/1214757485) =====
function! EngDict()
    sp +enew | put = system('engdict ' . @*)
    setlocal bufhidden=hide noswapfile noro nomodified
    normal gg
endfunction
vnoremap <silent> <c-d> :call EngDict()<CR>

"===== Spell check toggle =====
let s:spell_check_flag = 1
set spell spelllang=en_us
function! g:Spellcheck_toggle()
    if s:spell_check_flag
        let s:spell_check_flag = 0
        set nospell
        echomsg string('spell off')
    else
        let s:spell_check_flag = 1
        set spell spelllang=en_us
        echomsg string('spell on')
    endif
endfunction
nnoremap <F12> :call g:Spellcheck_toggle()<CR>
