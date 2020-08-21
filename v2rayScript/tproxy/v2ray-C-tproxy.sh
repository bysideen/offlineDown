echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p

wget -O config.json https://raw.githubusercontent.com/GuNanHai/offlineDown/master/v2rayScript/config.json
wget -O v2ray.service https://raw.githubusercontent.com/GuNanHai/offlineDown/master/v2rayScript/v2ray.service
wget -O v2ray-linux-64.zip https://github.com/GuNanHai/offlineDown/raw/master/v2rayScript/v2ray-linux-64.zip
