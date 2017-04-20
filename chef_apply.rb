# Usage: `sudo chef-apply chef_apply.rb`

cache_dir = Chef::Config['file_cache_path']

case node['platform']
when 'ubuntu'
  codename = node['lsb']['codename']
  #%w{zsh ctags}.each {|pkg| package pkg}
  #Chef::Log.info 'After install zsh, enter `chsh -s /bin/zsh` and restart terminal.'

  # install Vim 8
  apt_repository 'vim' do
    uri 'ppa:jonathonf/vim'
    distribution codename
  end

  package 'vim' do
    action :upgrade
  end

  apt_repository 'fish' do
    uri 'ppa:fish-shell/release-2'
    distribution codename
  end

  package 'fish'
end
