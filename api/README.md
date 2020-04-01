# Managing Credentials
```
export EDITOR="vim"; rbenv exec rails credentials:edit
```

# Test
```
rspec -fd
```

# Updating
```
cd api/
git pull
bundler
service nginx restart
./start_unicorn.sh
```
