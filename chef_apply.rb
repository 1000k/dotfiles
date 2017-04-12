# Usage: `sudo chef-apply chef_apply.rb`

cache_dir = Chef::Config['file_cache_path']

%w{zsh ctags}.each {|pkg| package pkg}
Chef::Log.info 'After install zsh, enter `chsh -s /bin/zsh` and restart terminal.'

case node['platform']
when 'ubuntu'
  # install Vim 8
  apt_repository 'add-vim-repo' do
    uri 'ppa:jonathonf/vim'
    distribution node['lsb']['codename']
  end

  package 'vim' do
    action :upgrade
  end
end
