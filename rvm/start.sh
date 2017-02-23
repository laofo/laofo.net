#!/bin/bash
echo 'export PATH=/usr/local/rvm/bin:$PATH' >>/root/.bashrc
source /root/.bashrc
cd /root/jekyll

#sed -i "s/RUBY_VERSION/'2.2.1'/g" /root/my/Gemfile
#bundle exec jekyll serve > 1.log &
rvm --default use 2.2.2
bundle install
gem pristine executable-hooks --version 1.3.2
gem pristine gem-wrappers --version 1.2.7
/usr/local/rvm/gems/ruby-2.2.2/bin/jekyll serve --host=0.0.0.0 --port=4567 --watch --force_polling
