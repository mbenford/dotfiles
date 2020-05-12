" Turn off vi compatibility
set nocompatible

" Show line numbers
set number

" Turn on syntax highlighting
syntax on

" Show file stats
set ruler

" Show status bar
set laststatus=2

" Set default encoding
set encoding=utf-8

set tabstop=2

" Plugin manager
call plug#begin('~/.vim/plugged')
call plug#end()
