echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p


wget -O web.zip https://raw.githubusercontent.com/GuNanHai/offlineDown/master/web.zip
wget -O aria2c.zip https://raw.githubusercontent.com/GuNanHai/offlineDown/master/aria2c.zip
wget -O aria2.service https://raw.githubusercontent.com/GuNanHai/offlineDown/master/aria2.service

wget -O caddy.zip https://raw.githubusercontent.com/GuNanHai/offlineDown/master/caddy.zip
wget -O Caddyfile https://raw.githubusercontent.com/GuNanHai/offlineDown/master/Caddyfile


wget -O config.json https://raw.githubusercontent.com/GuNanHai/offlineDown/master/v2rayScript/config.json


wget -O config.yaml https://raw.githubusercontent.com/GuNanHai/offlineDown/master/webdav/config.yaml
wget -O webdav https://raw.githubusercontent.com/GuNanHai/offlineDown/master/webdav/webdav.txt
wget -O webdav.service https://raw.githubusercontent.com/GuNanHai/offlineDown/master/webdav/webdav.service

wget -O sshd_config https://raw.githubusercontent.com/GuNanHai/offlineDown/master/systemInitConf/sshd_config
wget -O 50-default.conf https://raw.githubusercontent.com/GuNanHai/offlineDown/master/systemInitConf/50-default.conf



sudo apt-get update
sudo apt-get -y install zip
sudo apt-get -y install aria2
sudo apt-get -y install unzip
sudo apt-get -y install git

git config --global user.email "bysideen@gmail.com"
git config --global user.name "bysideen"



mv 50-default.conf /etc/rsyslog.d/50-default.conf
mv sshd_config /etc/ssh/sshd_config
service ssh restart
service rsyslog restart

chmod +x webdav
mv webdav /usr/bin/webdav
mv webdav.service  /etc/systemd/system/webdav.service
systemctl enable webdav.service && systemctl start webdav.service





unzip web.zip
mv web ~/
rm web.zip

echo "export PATH=$PATH:/root/web/down/daily_stock/fileHost/CMDs" >> ~/.bashrc
echo "export SYNC_USER1=bysideen:bysideen" >> ~/.bashrc
echo "export SYNC_BASE=/root/web/down/daily_stock/fileHost/anki" >> ~/.bashrc
echo "export SYNC_PORT=8002" >> ~/.bashrc
source ~/.bashrc

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

bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install
mv config.json /usr/local/etc/xray/config.json
systemctl restart xray.service



