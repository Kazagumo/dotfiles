#!/bin/sh
cd /usr/share/v2ray
SOURCE="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download"
download() {
	wget -O geoip.dat.1 $SOURCE/geoip.dat 
	wget -O geoip.dat.1.sha256sum $SOURCE/geoip.dat.sha256sum 
	wget -O geosite.dat.1 $SOURCE/geosite.dat 	
	wget -O geosite.dat.1.sha256sum $SOURCE/geosite.dat.sha256sum 
}

replace() {
	sed -i "s/geoip.dat/geoip.dat.1/g" geoip.dat.1.sha256sum
	sed -i "s/geosite.dat/geosite.dat.1/g" geosite.dat.1.sha256sum
	sha256sum -cs geosite.dat.1.sha256sum && echo "geosite valid" && rm geosite.dat && mv geosite.dat.1 geosite.dat
	sha256sum -cs geoip.dat.1.sha256sum && echo "geoip valid" && rm geoip.dat && mv geoip.dat.1 geoip.dat
}

cleanup() {
	rm *.1 *.sha256sum
}

download && replace && /etc/init.d/daed restart
cleanup

