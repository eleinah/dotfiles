" Set .bu (Butane) to be read as YAML &
" Set YAML indentation
au BufNewFile,BufRead *.bu set filetype=yaml
au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
