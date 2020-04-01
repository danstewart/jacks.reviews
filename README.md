# jacks.reviews

## Project setup

```
# deps
dnf install git openssl-devel readline-devel zlib-devel gcc-c++ make bzip2 httpie ruby mariadb mariadb-server mariadb-devel nginx certbot certbot-nginx

# clone
git clone git@github.com:danstewart/jacks.reviews.git
cd jacks.reviews
chmod 755 /home/dstewart/
```

### API Setup
```
cd ./api

# copy master.key
cp /path/to/master.key config/master.key

# install ruby deps and setup database
bundler
RAILS_ENV=development rake db:drop db:create db:migrate db:seed
RAILS_ENV=production rake db:drop db:create db:migrate db:seed

# link to web dir
mkdir -p /www/data
ln -s $(pwd)/api /data/www/api.jacks.reviews
```

### Frontend Setup
```
cd ./frontend

# install deps and build
npm install
npm run build

# link to web dir
ln -s $(pwd)/dist/ /data/www/jacks.reviews
```

### Database
```
systemctl enable mariadb.service
systemctl start mariadb.service
/usr/bin/mysql_secure_installation
```

### nginx
```
cp nginx/nginx.conf /etc/nginx/
mkdir -p /etc/nginx/sites-{available,enabled}
cp nginx/{api.,}jacks.reviews /etc/nginx/sites-available
ln -s /etc/nginx/sites-available/jacks.reviews /etc/nginx/sites-enabled/
ln -s /etc/nginx/sites-available/api.jacks.reviews /etc/nginx/sites-enabled/

systemctl enable nginx
systemctl start nginx

# SELinux
setsebool -P httpd_can_network_connect on
chcon -Rt httpd_sys_content_t /data/www
semodule -i mynginx.pp

# See here: https://axilleas.me/en/blog/2013/selinux-policy-for-nginx-and-gitlab-unix-socket-in-fedora-19/
grep nginx /var/log/audit/audit.log | audit2allow -m nginx > nginx.te
grep nginx /var/log/audit/audit.log | audit2allow -M nginx
semodule -i nginx.pp
```

### Certbot
```
sudo certbot --nginx
echo "0 0,12 * * * root python -c 'import random; import time; time.sleep(random.random() * 3600)' && certbot renew -q" | sudo tee -a /etc/crontab > /dev/null
```

### Start server
```
/www/data/api.jacks.reviews/start_unicorn.sh
systemctl restart nginx

# check
http -h GET https://jacks.reviews
http -h GET https://api.jacks.reviews/movies
```

---

## Screenshots
![alt text](screenshots/1.png "Jacks Reviews")
![alt text](screenshots/2.png "Review")
