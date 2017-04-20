# Usage: `sudo chef-apply chef_apply.rb`

cache_dir = Chef::Config['file_cache_path']

case node['platform']
when 'ubuntu'
  codename = node['lsb']['codename']

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

  package 'fish' do
    notifies :run, 'execute[install-fish]'
  end
  Chef::Log.info 'After install fish, enter `chsh -s /usr/bin/fish` and restart terminal.'

  execute 'install-fish' do
    command 'curl -L https://get.oh-my.fish | fish'
    action :nothing
  end
end
