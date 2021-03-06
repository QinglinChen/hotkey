set nu
syntax on
set tabstop=8	  "tab等于的空格数
set softtabstop=8 "貌似可以根据这个数进位
set shiftwidth=8 "自动缩进列数，符号移位数
set backspace=2  "启用backspace
set nocompatible "不兼容vi

" 你在此设置运行时路径
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" 在这里面输入安装的插件
" Vundle 本身就是一个插件
Plugin 'gmarik/Vundle.vim' 
Plugin 'godlygeek/tabular' "注释对齐插件
Plugin 'suan/vim-instant-markdown' "markdown预览
Plugin 'skywind3000/vim-keysound' "键盘声
"Plugin 'Valloric/YouCompleteMe' "补全
"所有插件都应该在这一行之前
call vundle#end()

"keysound plugin=======================
let g:keysound_enable=1
let g:keysound_theme='typewriter'
let g:keysound_py_version = 3
let g:keysound_volume=800
"======================================
set so=6 "上下总有6行
" filetype off
let g:netrw_liststyle = 3 "树型展示目录
"let g:netrw_altv = 2 "想设置目录中文件的打开方式,还没搞好
let g:netrw_winsize= 24   "目录宽度24字符
filetype plugin indent on "打开基于文件类型的插件
set showcmd "显示输入的命令
