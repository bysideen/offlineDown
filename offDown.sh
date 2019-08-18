wget -O web.zip https://raw.githubusercontent.com/GuNanHai/offlineDown/master/web.zip
wget -O aria2c.zip https://raw.githubusercontent.com/GuNanHai/offlineDown/master/aria2c.zip
wget -O caddy.zip https://raw.githubusercontent.com/GuNanHai/offlineDown/master/caddy.zip
wget -O aria2.service https://raw.githubusercontent.com/GuNanHai/offlineDown/master/aria2.service
apt install zip
apt install aria2

unzip web.zip
mv web ~/
rm web.zip

unzip aria2c.zip
mv .aria2 ~/
rm aria2c.zip

unzip caddy.zip
mv caddy /usr/local/bin/
mv Caddyfile /usr/local/bin/
rm caddy.zip

mv aria2.service /etc/systemd/system/aria2.service
systemctl enable aria2.service && systemctl start aria2.service

caddy & disown

bash <(curl -Ls https://blog.sprov.xyz/v2-ui.sh)

