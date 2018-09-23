#!/bin/bash

sudo yum -y install golang
git clone https://github.com/ericharris/wttr.in.git
export WTTR_MYDIR="/home/ec2-user/wttr.in"
export WTTR_GEOLITE="/home/ec2-user/wttr.in/GeoLite2-City.mmdb"
export WTTR_WEGO="/home/ec2-user/go/bin/wego"
export WTTR_LISTEN_HOST="0.0.0.0"
export WTTR_LISTEN_PORT="8002"
go get -u github.com/schachmat/wego
go install github.com/schachmat/wego
# put forecast.io API key in the echo output
echo "forecast-api-key=YOUR_FORECAST.IO_API_KEY_HERE" > /home/ec2-user/.wegorc
cd wttr.in/ 
wget -qO- http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz | tar --transform="s,.*/,," "*/GeoLite2-City.mmdb" -zxv 
virtualenv ve 
ve/bin/pip install -r requirements.txt  
ve/bin/python bin/srv.py &
