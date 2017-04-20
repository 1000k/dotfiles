# Usage: `sudo chef-apply chef_apply.rb`

cache_dir = Chef::Config['file_cache_path']

case node['platform']
when 'ubuntu'
  codename = node['lsb']['codename']

  # Vim 8
  apt_repository 'vim' do
    uri 'ppa:jonathonf/vim'
    distribution codename
  end

  package 'vim' do
    action :upgrade
  end

  # Peco
  src_path = "#{cache_dir}/peco.tar.gz"
  remote_file src_path do
    source 'https://github.com/peco/peco/releases/download/v0.5.1/peco_linux_amd64.tar.gz'
    not_if 'which peco'
    notifies :run, 'bash[extract_peco]'
  end

  bash 'extract_peco' do
    cwd ::File.dirname(src_path)
    code <<-EOH
      tar xzf #{src_path} peco_linux_amd64/peco --strip=1 --no-same-owner --no-same-permission
      mv peco /usr/local/bin/
    EOH
    not_if 'which peco'
  end

  # Fish
  apt_repository 'fish' do
    uri 'ppa:fish-shell/release-2'
    distribution codename
  end

  package 'fish' do
    notifies :run, 'execute[install_fish]'
  end
  Chef::Log.info 'After install fish, enter `chsh -s /usr/bin/fish` and restart terminal.'

  execute 'install_fish' do
    command 'curl -L https://get.oh-my.fish | fish'
    action :nothing
  end
end
