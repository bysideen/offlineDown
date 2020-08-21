export https_proxy=http://127.0.0.1:8080 http_proxy=http://127.0.0.1:8080 all_proxy=socks5://127.0.0.1:1080
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p


wget -O config.json https://raw.githubusercontent.com/GuNanHai/offlineDown/master/v2rayScript/tproxy/configC-tproxy.json
wget -O v2ray.service https://raw.githubusercontent.com/GuNanHai/offlineDown/master/v2rayScript/v2ray.service
wget -O v2ray-linux-64.zip https://github.com/GuNanHai/offlineDown/raw/master/v2rayScript/v2ray-linux-64.zip
wget -O tproxyrule.service https://raw.githubusercontent.com/GuNanHai/offlineDown/master/v2rayScript/tproxy/tproxyrule.service

apt-get update
apt-get install zip
apt-get install unzip


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
