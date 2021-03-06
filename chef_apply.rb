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

  package 'fish'
  Chef::Log.info 'After install fish, enter `chsh -s /usr/bin/fish` and restart terminal.'

  # Direnv
  remote_file '/usr/local/bin/direnv' do
    source 'https://github.com/direnv/direnv/releases/download/v2.11.3/direnv.linux-amd64'
    not_if 'which direnv'
    mode 0755
  end

  # ghq
  src_path = "#{cache_dir}/ghq.zip"
  remote_file src_path do
    source 'https://github.com/motemen/ghq/releases/download/v0.7.4/ghq_linux_amd64.zip'
    not_if 'which ghq'
  end

  execute 'extract_ghq'do
    cwd ::File.dirname(src_path)
    command <<-EOH
      unzip -j #{src_path} ghq -d /usr/local/bin/
      chmod +x /usr/local/bin/ghq
    EOH
    not_if 'which ghq'
  end
when 'mac_os_x'
  %w{fish peco ghq direnv ansible}.each { |pkg| homebrew_package pkg }
  homebrew_package 'vim' do
    options '--with-override-system-vi'
  end

end
