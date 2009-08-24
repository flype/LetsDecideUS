#second version!

apt-get update -y && apt-get upgrade -y --force-yes && apt-get install -y git-core

### bootstrap with ruby+deps.
apt-get install -y ruby ruby1.8-dev rubygems libopenssl-ruby1.8 libsqlite3-ruby irb build-essential

### upgrade rubygems, debian's version is old.
gem source -a http://gems.rubyforge.org && gem source -a http://gems.github.com && gem source -a http://gems.opscode.com 
gem install rubygems-update --version=1.3.4 && /var/lib/gems/1.8/bin/update_rubygems

### download the chef-solo repo.
cd /tmp && git clone git://github.com/flype/chef_solo_railsrumble.git && cd /tmp/chef_solo_railsrumble

### Run chef solo.
gem install chef ohai &&
chef-solo -l debug -c config/solo.rb -j config/dna.json

# server {
#      listen 80;
#      server_name www.yourhost.com;
#      root /somewhere/public;   # <--- be sure to point to 'public'!
#      passenger_enabled on;
#   }
