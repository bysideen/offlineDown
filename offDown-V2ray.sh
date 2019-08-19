echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p

wget -O web.zip https://raw.githubusercontent.com/GuNanHai/offlineDown/master/web.zip
wget -O aria2c.zip https://raw.githubusercontent.com/GuNanHai/offlineDown/master/aria2c.zip
wget -O caddy.zip https://raw.githubusercontent.com/GuNanHai/offlineDown/master/caddy.zip
wget -O aria2.service https://raw.githubusercontent.com/GuNanHai/offlineDown/master/aria2.service
wget -O config.json https://raw.githubusercontent.com/GuNanHai/offlineDown/master/config.json

apt-get update
apt-get install zip
apt-get install aria2
apt-get install unzip

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

ulimit -n 8192
caddy -conf /usr/local/bin/Caddyfile  & disown

bash <(curl -L -s https://install.direct/go.sh)
mv config.json /etc/v2ray/
systemctl restart v2ray.service
