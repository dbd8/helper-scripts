#!/bin/sh -e
#put this in crontab
#token=<your-token> ./dynv4.sh <your-zone-name> >> ~/dynv4.log 2>&1

hostname=$1

if [ -e /usr/bin/curl ]; then
  bin="curl -fsS"
elif [ -e /usr/bin/wget ]; then
  bin="wget -O-"
else
  echo "neither curl nor wget found"
  exit 1
fi

ipv4=$(curl -s http://checkip.amazonaws.com)

# send addresses to dynv6
$bin "https://dynv6.com/api/update?hostname=$hostname&ipv4=$ipv4&token=$token"

echo $(date +"; -> %Y-%m-%d_%H:%M:%S")

