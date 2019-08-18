1.aria2-config file ------->  ~/.aria2/
2.aria2  auto start while power on:
/etc/systemd/system/aria2.service
systemctl enable aria2.service && systemctl start aria2.service

3.caddy                         ------------>  /usr/local/bin/


run:
bash <(curl -Ls https://raw.githubusercontent.com/GuNanHai/offlineDown/master/offDown.sh)
