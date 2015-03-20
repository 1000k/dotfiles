# Usage: `sudo chef-apply chef_apply.rb`

cache_dir = Chef::Config['file_cache_path']

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

execute 'install_vim_from_source' do
  cwd cache_dir
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
  not_if "which vim | grep #{vim_version}"
end


# ----
# install tmux
# ----
tmux_version = '1.9a'

%w{wget gcc make ncurses ncurses-devel}.each { |pkg| package pkg }

# tmux 1.9 needs recent libevent (not yum version)
libevent_version = '2.0.22-stable'

remote_file "#{cache_dir}/libevent-#{libevent_version}.tar.gz" do
  source 'https://sourceforge.net/projects/levent/files/libevent/libevent-2.0/libevent-2.0.22-stable.tar.gz'
  mode '0644'
  not_if { File.exists?("#{cache_dir}/libevent-#{libevent_version}.tar.gz") }
end

execute "install_libevent-#{libevent_version}" do
  cwd cache_dir
  command <<-CMD
    tar zxvf libevent-#{libevent_version}.tar.gz
    cd libevent-#{libevent_version}
    ./configure && make && make install
    echo '/usr/local/lib' > /etc/ld.so.conf.d/libevent.conf
    ldconfig
  CMD
  not_if { File.exists? '/etc/ld.so.conf.d/libevent.conf' }
end

remote_file "#{cache_dir}/tmux-#{tmux_version}.tar.gz" do
  source "http://downloads.sourceforge.net/tmux/tmux-#{tmux_version}.tar.gz"
  mode '0644'
  not_if { File.exists?("#{cache_dir}/tmux-#{tmux_version}.tar.gz") }
end

execute "install_tmux-#{tmux_version}" do
  cwd cache_dir
  command <<-CMD
    tar zxvf tmux-#{tmux_version}.tar.gz
    cd tmux-#{tmux_version}
    ./configure && make && make install
  CMD
  not_if "tmux -V | grep #{tmux_version}"
end

