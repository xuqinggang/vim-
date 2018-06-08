" Use Vim settings, rather then Vi settings. This setting must be as early as
" possible, as it has side effects.
set nocompatible

" syntax hightlight
syntax on 
set guioptions-=L

" fold
"打开文件是默认不折叠代码
set foldlevelstart=99

" 设定配色方案 
colorscheme molokai 

" autoindent会在换行时保持当前行的缩进
set autoindent

" 行显示设置
set number
set numberwidth=5
set cursorline                               "突出显示当前行
autocmd InsertLeave * se nocul               " 用浅色高亮当前行  
autocmd InsertEnter * se cul                 " 用浅色高亮当前行 



" 状态行，命令行设置
set ruler                                    " 显示标尺，即在窗口右下角显示当前光标的行列信息 
set showcmd                                  " 输入的命令显示出来
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}\ %{ALEGetStatusLine()}


" 搜索设置
" set hlsearch                                 " 搜索时高亮显示被找到的文本
set incsearch                                " 在执行查找前预览第一处匹配
set ignorecase smartcase                     " 搜索时忽略大小写，但在有一个或以上大写字母时仍保持对大小写敏感


" >和<字符缩进正常工作 设置tab键的字符数
" 缩进，制表符，折叠设置
set tabstop=4
set softtabstop=4
set shiftwidth=4
" expandtab选项，用来控制是否将Tab转换为空格 
set expandtab

" window macvim
if has("gui_running")
      winpos 0 20
      set lines=55 columns=250
endif

" 文件保存设置
set clipboard+=unnamed        " 共享剪贴板  
set autoread                  " 当文件被改动时自动载入
set nobackup                  " 从不备份  
set autowrite                 " 自动保存
set confirm                   " 在处理未保存或只读文件的时候，弹出确认
set history=1000              " 历史记录数
set nobackup                  " 禁止生成临时文件
set noswapfile
set autochdir                 " 自动切换当前目录为当前文件所在的目录


" 这样,我可以使用左派和右派之间 switch 标签按钮就像我通常会移动光标,除了我,就拿着控制键。
" 控制 + l 移动到下一个选项卡
" 控制 + h 移动到前面的选项卡
" 控制 + n 创建一个新的选项卡
map <C-l> :tabn<CR>
map <C-h> :tabp<CR>
map <C-n> :tabnew<CR>
map <C-c> :tabc<CR>


if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
endif

" Nerd Tree
nmap <F2> :NERDTreeToggle<cr>
" 设置宽度
" 显示行号
let NERDTreeShowLineNumbers=1
let NERDTreeAutoCenter=1
" 是否显示隐藏文件
let NERDTreeShowHidden=1
" 设置宽度
let NERDTreeWinSize=45
" 在终端启动vim时，共享NERDTree
let g:nerdtree_tabs_open_on_console_startup=1
" 忽略一下文件的显示
let NERDTreeIgnore=['\.pyc','\~$','\.swp']
" 显示书签列表
let NERDTreeShowBookmarks=1


" ctrlp
" ctrlp 设置过滤的文件
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$',
            \ 'file': '\v\.(exe|so|dll)$',
            \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
            \ }
let g:ctrlp_show_hidden = 1

" ctags
nnoremap <F5> :!ctags -R --exclude=node_modules<cr>
set tags=./tags;,tags
set autochdir

let g:tagbar_type_javascript = {
            \ 'ctagsbin' : 'jsctags'
            \ }

" tagbar
nmap <F8> :TagbarToggle<CR>
" 设置tagbar的窗口宽度
let g:tagbar_width=30



" vim-javascript
let javascript_enable_domhtmlcss=1
let b:javascript_fold=1

" vim-jsx
" jsx语法在.js文件中也生效
let g:jsx_ext_required = 0

" ale lint
let g:ale_linters = {
\   'javascript': ['eslint', 'flow'],
\   'TypeScript': ['tslint', 'tsserver'],
\}
"始终开启标志列
let g:ale_sign_column_always=1
" 出错地方是否突出标识
let g:ale_set_highlights=0
"自定义error和warning图标
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
"在vim自带的状态栏中整合ale
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"文件内容发生变化时不进行检查
" let g:ale_lint_on_text_changed = 'never'
"打开文件时不进行检查
" let g:ale_lint_on_enter = 0
"普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
"<Leader>s触发/关闭语法检查
nmap <Leader>s :ALEToggle<CR>
"<Leader>d查看错误或警告的详细信息
nmap <Leader>d :ALEDetail<CR>

" tern_for_vim js自动补全
let g:tern_show_signature_in_pum = 1

" vim-jsbeautify
" js html css json jsx 格式化
map <c-f> :call JsxBeautify()<cr>
" or
autocmd FileType javascript noremap <buffer>  <c-f> :call JsxBeautify()<cr>
" for json
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
" for jsx
autocmd FileType jsx noremap <buffer> <c-f> :call JsxBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

" markdown
" vim-instant-markdown
" let g:instant_markdown_slow = 1

" emmet-vim <c-y>, 重新映射 <c-e>
let g:user_emmet_expandabbr_key = '<C-E>'
let g:user_emmet_settings = {
            \  'javascript' : {
            \      'extends' : 'jsx',
            \  },
            \}
" set guifont=Monaco:h24:b:cDEFAULT
set guifont=Monaco:h14


" ag
let g:ackprg = 'ag --nogroup --nocolor --column'


" flow
" let g:javascript_plugin_flow = 1
" let g:syntastic_javascript_checkers = ['flow']
" let g:syntastic_javascript_flow_exe = 'flow'

" autoformat
" au BufWrite * :Autoformat


" python
au BufNewFile,BufRead *.py set tabstop=4
\ softtabstop=4
\ shiftwidth=4
\ textwidth=79
\ expandtab
\ autoindent
\ fileformat=unix
" au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" python autopep8
" If you want to use 「=」 with autopep8. It's good to set it as follows. But please be careful as "vim-autopep8" setting will not be inherited.
autocmd FileType python set equalprg=autopep8\ -

" ale lint
" Check Python files with flake8 and pylint.
let b:ale_linters = ['flake8', 'pylint']
" Fix Python files with autopep8 and yapf.
let b:ale_fixers = ['autopep8', 'yapf']

" weixin-minprogram
autocmd BufNewFile,BufRead *.wxml set filetype=wxml
autocmd BufNewFile,BufRead *.wxss set filetype=wxss

" wepy
au BufRead,BufNewFile *.wpy setlocal filetype=javascript

" flow
au BufRead,BufNewFile *.flow setlocal filetype=javascript
