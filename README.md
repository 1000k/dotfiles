1000k dotfiles
==============

Required
--------
- git
- chef-apply
  - `curl -L https://www.chef.io/chef/install.sh | sudo bash`


Setup
-----

### Linux

```
curl -L http://bit.ly/1000k_dotfiles | bash
cd dotfiles
sudo chef-apply chef_apply.rb
```

### Windows

```
git clone https://github.com/1000k/dotfiles
cd dotfiles
setup.cmd
```

