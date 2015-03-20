# ----
# install vim
# ----
vim_version = '7.4'
%w{
  ruby-devel
  lua
  lua-devel
  ctags
  mercurial
  python
  python-devel
  tcl-devel
  perl
  perl-devel
  perl-ExtUtils-ParseXS
  perl-ExtUtils-CBuilder
  perl-ExtUtils-Embed
}.each do |pkg|
  package pkg
end

execute 'install-vim-from-source' do
  cwd '/tmp/'
  command <<-CMD
    hg clone https://code.google.com/p/vim/
    cd vim
    ./configure --with-features=huge \
      --enable-multibyte \
      --enable-rubyinterp \
      --enable-pythoninterp \
      --with-python-config-dir=/usr/lib/python2.7/config \
      --enable-perlinterp \
      --enable-luainterp \
      --enable-cscope \
      --prefix=/usr
    make VIMRUNTIMEDIR=/usr/share/vim/vim74
    make install
  CMD
  not_if { "which vim | grep #{vim_version}" }
end


# ----
# install tmux
# ----


