" Set .bu (Butane) to be read as YAML
au BufNewFile,BufRead *.bu setf yaml

" Set YAML indentation
au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
