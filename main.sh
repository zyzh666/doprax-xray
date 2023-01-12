var=`curl -LI "https://github.com/XTLS/Xray-core/releases/latest"`
vvv=${var%%cache-control*}
vvv2=${vvv:0-8}
xrayurl0=${vvv2:0:6}
xrayurl="https://github.com/XTLS/Xray-core/releases/download/"$xrayurl0"/Xray-linux-64.zip"
if [[ $xrayurl0 == "" ]]
then
xrayurl=`curl -s "https://ppxx.zyzh.tk"`
fi
if [[ $xrayurl == "" ]]
then
xrayurl="https://github.com/XTLS/Xray-core/releases/download/1.7.2/Xray-linux-64.zip"
fi
wget -O m.zip $xrayurl
unzip m.zip
chmod a+x xray
sed -i "s/uuid/$uuid/g" ./config.yaml
sed -i "s/uuid/$uuid/g" /etc/nginx/nginx.conf
[ -n "${www}" ] && rm -rf /usr/share/nginx/* && wget -c -P /usr/share/nginx "https://github.com/yonggekkk/doprax-xray/raw/main/3w/html${www}.zip" && unzip -o "/usr/share/nginx/html${www}.zip" -d /usr/share/nginx/html
xpid=$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c 6)
mv xray $xpid
cat config.yaml | base64 > config
rm -f config.yaml
nginx
base64 -d config > config.yaml; ./$xpid -config=config.yaml
