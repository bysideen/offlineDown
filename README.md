1.aria2-config file ------->  ~/.aria2/
2.aria2  auto start while power on:
/etc/systemd/system/aria2.service
systemctl enable aria2.service && systemctl start aria2.service

3.caddy                         ------------>  /usr/local/bin/

run(纯净版):
bash <(curl -Ls https://raw.githubusercontent.com/GuNanHai/offlineDown/master/offDown-V2ray.sh)

run(带操作界面):
bash <(curl -Ls https://raw.githubusercontent.com/GuNanHai/offlineDown/master/offDown.sh)

run(客户端v2ray+透明路由):
bash <(curl -Ls https://raw.githubusercontent.com/GuNanHai/offlineDown/master/v2rayScript/tproxy/v2ray-C-tproxy.sh)

