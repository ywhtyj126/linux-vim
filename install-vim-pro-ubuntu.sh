#!/bin/bash
# =========================================
# Ubuntu Vim 专业版全自动配置脚本 by XSimple
# =========================================

set -e

echo "🚀 开始安装 Ubuntu Vim 专业版配置..."

# 1. 安装必要工具
echo "📦 安装必备包: vim, nodejs, npm, fzf, curl, git..."
sudo apt update
sudo apt install -y vim nodejs npm fzf curl git

# 2. 安装 vim-plug
echo "🔌 安装 vim-plug 插件管理器..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# 3. 写入优化版 .vimrc
echo "📝 写入终极版 .vimrc 配置..."
cat > ~/.vimrc <<'EOF'
" ================================
" Vim 终极专业配置 by XSimple
" ================================
set nocompatible
filetype off

" -------------------------------
" 插件管理（vim-plug）
" -------------------------------
call plug#begin('~/.vim/plugged')

" 文件树
Plug 'preservim/nerdtree'
" 状态栏
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" 补全 / LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Git 集成
Plug 'tpope/vim-fugitive'
" 全局搜索
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" 彩色括号
Plug 'luochen1990/rainbow'
" 语法高亮增强
Plug 'sheerun/vim-polyglot'
" 快速注释
Plug 'preservim/nerdcommenter'

call plug#end()

" -------------------------------
" 基础设置
" -------------------------------
set number
set relativenumber
set cursorline
set ruler
set encoding=utf-8
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
syntax enable
set background=dark
colorscheme desert
set clipboard=unnamedplus
set hlsearch
set incsearch
set ignorecase
set smartcase
set pastetoggle=<F2>

" 自动保存光标位置
augroup resCur
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g'\"" |
        \ endif
augroup END

" -------------------------------
" 快捷键
" -------------------------------
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-p> :Files<CR>
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>a
nnoremap <C-q> :q<CR>
nnoremap <C-a> ggVG

" -------------------------------
" COC.nvim 配置
" -------------------------------
" 检查回退
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~ '\s'
endfunction

" Tab 补全
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ coc#expandable() ? "\<Plug>(coc-snippets-expand)" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" K 显示文档
nnoremap <silent> K :call CocActionAsync('doHover')<CR>

" 格式化代码
nnoremap <silent> <leader>f :call CocAction('format')<CR>

" Rainbow 括号
let g:rainbow_active = 1

" Airline 状态栏
let g:airline_theme='dark'
let g:airline_powerline_fonts = 1

" 代码注释
let g:NERDCreateDefaultMappings = 1

" -------------------------------
" 自动安装 Coc.nvim 常用扩展
" -------------------------------
augroup MyCocSetup
  autocmd!
  autocmd VimEnter * call CocInstallIfMissing()
augroup END

function! CocInstallIfMissing() abort
  let l:ext_list = [
        \ 'coc-json',
        \ 'coc-tsserver',
        \ 'coc-html',
        \ 'coc-css',
        \ 'coc-pyright',
        \ 'coc-go',
        \ 'coc-rust-analyzer',
        \ 'coc-vetur',
        \ 'coc-sh',
        \ 'coc-yaml'
        \ ]
  let l:missing = []
  for l:ext in l:ext_list
    if index(coc#util#installed_extensions(), l:ext) < 0
      call add(l:missing, l:ext)
    endif
  endfor
  if !empty(l:missing)
    execute 'CocInstall -sync' join(l:missing) '|q'
  endif
endfunction
EOF

# 4. 自动安装插件
echo "🔍 启动 Vim 并安装插件..."
vim +PlugInstall +qall

echo "✅ Vim 专业版安装完成！"
echo "💡 第一次启动 Vim 时，会自动安装 Coc.nvim 常用语言扩展（Python、Go、Rust、Vue 等）。"
echo "   安装好后，按 Ctrl+N 打开文件树，Ctrl+P 搜索文件，F2 切换粘贴模式。"