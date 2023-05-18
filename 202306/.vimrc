" 事前に以下のコマンドを実行して、vim-plugを導入する
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin()
  Plug 'vim-jp/vimdoc-ja'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

set helplang=ja,en
source ~/.vim/coc-keybindings.vim
