" Set .bu (Butane) to be read as YAML &
" Set YAML indentation
au BufNewFile,BufRead *.bu setf yaml
au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Set .bashrc (Custom for ~/.bashrc.d/) to be read as Bash
au BufNewFile,BufRead *.bashrc setf sh

" Map F12 to execute current Python file
nnoremap <F12> :w<CR>:exec '!python' shellescape(@%, 1)<CR>
