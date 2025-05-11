" Set .bu (Butane) to be read as YAML &
" Set YAML indentation
au BufNewFile,BufRead *.bu setf yaml
au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Set .bashrc (Custom for ~/.bashrc.d/) to be read as Bash
au BufNewFile,BufRead *.bashrc setf sh
