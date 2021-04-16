1.aria2-config file ------->  ~/.aria2/

2.aria2  auto start while power on:
/etc/systemd/system/aria2.service
systemctl enable aria2.service && systemctl start aria2.service

3.caddy                         ------------>  /usr/local/bin/

4.做bt种子示例：transmission-create -o fileName.torrent -t tracker1.com -t tracker2.com fileName

run(纯净版):
```
bash <(curl -Ls https://raw.githubusercontent.com/GuNanHai/offlineDown/master/offDown-V2ray.sh)
```

run(带操作界面):
```
bash <(curl -Ls https://raw.githubusercontent.com/GuNanHai/offlineDown/master/offDown.sh)
```

run(客户端v2ray+透明路由):  
注1：脚本运行不用翻墙，可直接将raw.githubusercontent.com及github.com的ip映射到/etc/hosts                          
注2：需要设置静态地址作为其他需翻墙设备的网关，最后重启生效。
```
bash <(curl -Ls https://raw.githubusercontent.com/GuNanHai/offlineDown/master/v2rayScript/tproxy/v2rayC_tproxy.sh)
```

