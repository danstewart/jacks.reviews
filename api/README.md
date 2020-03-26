# Setup

## Fresh Install (Fedora/Cent OS)
```
# prerequisites
yum install git openssl-devel readline-devel zlib-devel gcc-c++ make bzip2 httpie

# rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src
ln -s /home/dstewart/.rbenv/bin/rbenv /home/dstewart/bin/rbenv
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc

# ruby-build
mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

# install ruby
rbenv install 2.5.1

# clone the repo
git clone git@github.com:danstewart/jacks.reviews.git

# copy master.key
cp /path/to/master.key config/master.key

# install DB
dnf install mariadb mariadb-server mariadb-devel
systemctl start mariadb.service
/usr/bin/mysql_secure_installation

# install ruby deps and setup database
bundler
rake db:create db:migrate db:seed
```

## Development
```
rails s
http GET 127.0.0.1:3000/movies
```

## Production
```
# copy nginx config files
cp nginx/* /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/jacks.reviews /etc/nginx/sites-enabled/
ln -s /etc/nginx/sites-available/api.jacks.reviews /etc/nginx/sites-enabled/

# start unicorn
./start_unicorn.sh

# start nginx
service nginx start
```

# Managing Credentials
```
export EDITOR="vim"; rbenv exec rails credentials:edit
```

# Updating Live Server
```
ssh ...
git reset --hard
git pull
bundler
service nginx restart
```

# Restarting after reboot (Should be automatic...)
```
sudo service start mariadb
/var/www/api.jacks.reviews/start_unicorn.sh
```
