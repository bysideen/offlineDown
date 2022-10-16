echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p

wget -O web.zip https://raw.githubusercontent.com/GuNanHai/offlineDown/master/web.zip
wget -O aria2c.zip https://raw.githubusercontent.com/GuNanHai/offlineDown/master/aria2c.zip
wget -O caddy.zip https://raw.githubusercontent.com/GuNanHai/offlineDown/master/caddy.zip
wget -O aria2.service https://raw.githubusercontent.com/GuNanHai/offlineDown/master/aria2.service

wget -O config.json https://raw.githubusercontent.com/GuNanHai/offlineDown/master/v2rayScript/config.json
wget -O v2ray.service https://raw.githubusercontent.com/GuNanHai/offlineDown/master/v2rayScript/v2ray.service
wget -O v2ray-linux-64.zip https://github.com/GuNanHai/offlineDown/raw/master/v2rayScript/v2ray-linux-64.zip

wget -O config.yaml https://raw.githubusercontent.com/GuNanHai/offlineDown/master/webdav/config.yaml
wget -O webdav https://github.com/GuNanHai/offlineDown/blob/master/webdav/webdav.bin
wget -O webdav.service https://raw.githubusercontent.com/GuNanHai/offlineDown/master/webdav/webdav.service

wget -O sshd_config https://raw.githubusercontent.com/GuNanHai/offlineDown/master/systemInitConf/sshd_config
wget -O 50-default.conf https://raw.githubusercontent.com/GuNanHai/offlineDown/master/systemInitConf/50-default.conf

mv 50-default.conf /etc/rsyslog.d/50-default.conf
mv sshd_config /etc/ssh/sshd_config
service ssh restart
service rsyslog restart

chmod +x webdav
mv webdav /usr/bin/webdav
mv webdav.service  /etc/systemd/system/webdav.service
systemctl enable webdav.service && systemctl start webdav.service


sudo apt-get update
sudo apt-get -y install zip
sudo apt-get -y install aria2
sudo apt-get -y install unzip

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

unzip v2ray-linux-64.zip
rm v2ray-linux-64.zip
mkdir /usr/bin/v2ray
chmod +x v2ray v2ctl
mv v2ray /usr/bin/v2ray/v2ray
mv v2ctl /usr/bin/v2ray/v2ctl
mkdir /etc/v2ray
mkdir /var/log/v2ray
mv config.json /etc/v2ray/
mv geoip.dat /usr/bin/v2ray/geoip.dat
mv geosite.dat  /usr/bin/v2ray/geosite.dat
mv v2ray.service /etc/systemd/system/v2ray.service
systemctl enable v2ray.service
systemctl start v2ray.service
