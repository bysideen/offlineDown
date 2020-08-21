export https_proxy=http://127.0.0.1:8080 http_proxy=http://127.0.0.1:8080 all_proxy=socks5://127.0.0.1:1080
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p

wget -O config.json https://raw.githubusercontent.com/GuNanHai/offlineDown/master/v2rayScript/tproxy/configC-tproxy.json
wget -O v2ray.service https://raw.githubusercontent.com/GuNanHai/offlineDown/master/v2rayScript/v2ray.service
wget -O v2ray-linux-64.zip https://github.com/GuNanHai/offlineDown/raw/master/v2rayScript/v2ray-linux-64.zip
wget -O tproxyrule.service https://raw.githubusercontent.com/GuNanHai/offlineDown/master/v2rayScript/tproxy/tproxyrule.service
apt-get update
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

# 设置策略路由
ip rule add fwmark 1 table 100
ip route add local 0.0.0.0/0 dev lo table 100

# 代理局域网设备
iptables -t mangle -N V2RAY
iptables -t mangle -A V2RAY -d 127.0.0.1/32 -j RETURN
iptables -t mangle -A V2RAY -d 224.0.0.0/4 -j RETURN
iptables -t mangle -A V2RAY -d 255.255.255.255/32 -j RETURN
iptables -t mangle -A V2RAY -d 192.168.0.0/16 -p tcp -j RETURN # 直连局域网，避免 V2Ray 无法启动时无法连网关的 SSH，如果你配置的是其他网段（如 10.x.x.x 等），则修改成自己的
iptables -t mangle -A V2RAY -d 192.168.0.0/16 -p udp ! --dport 53 -j RETURN # 直连局域网，53 端口除外（因为要使用 V2Ray 的 
iptables -t mangle -A V2RAY -p udp -j TPROXY --on-port 12345 --tproxy-mark 1 # 给 UDP 打标记 1，转发至 12345 端口
iptables -t mangle -A V2RAY -p tcp -j TPROXY --on-port 12345 --tproxy-mark 1 # 给 TCP 打标记 1，转发至 12345 端口
iptables -t mangle -A PREROUTING -j V2RAY # 应用规则

# 代理网关本机
iptables -t mangle -N V2RAY_MASK
iptables -t mangle -A V2RAY_MASK -d 224.0.0.0/4 -j RETURN
iptables -t mangle -A V2RAY_MASK -d 255.255.255.255/32 -j RETURN
iptables -t mangle -A V2RAY_MASK -d 192.168.0.0/16 -p tcp -j RETURN # 直连局域网
iptables -t mangle -A V2RAY_MASK -d 192.168.0.0/16 -p udp ! --dport 53 -j RETURN # 直连局域网，53 端口除外（因为要使用 V2Ray 的 DNS）
iptables -t mangle -A V2RAY_MASK -j RETURN -m mark --mark 0xff    # 直连 SO_MARK 为 0xff 的流量(0xff 是 16 进制数，数值上等同与上面V2Ray 配置的 255)，此规则目的是避免代理本机(网关)流量出现回环问题
iptables -t mangle -A V2RAY_MASK -p udp -j MARK --set-mark 1   # 给 UDP 打标记,重路由
iptables -t mangle -A V2RAY_MASK -p tcp -j MARK --set-mark 1   # 给 TCP 打标记，重路由
iptables -t mangle -A OUTPUT -j V2RAY_MASK # 应用规则

iptables -t mangle -A V2RAY_MASK -p udp -j MARK --set-mark 1
iptables -t mangle -A V2RAY_MASK -p tcp -j MARK --set-mark 1
iptables -t mangle -A OUTPUT -j V2RAY_MASK

mkdir -p /etc/iptables && iptables-save > /etc/iptables/rules.v4
mv tproxyrule.service /etc/systemd/system/
systemctl enable tproxyrule

