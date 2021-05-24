#!/bin/sh -e
hostname=$1
device=$2
file=$HOME/.dynv6.addr6
#[ -e $file ] && old=`cat $file`

old=$(nslookup db-cloud.dynv6.net | sed -n 's/.*Address: \([0-9a-f:]\+\).*/\1/p')

date=$(date)

if [ -z "$hostname" -o -z "$token" ]; then
  echo "Usage: token=<your-authentication-token> [netmask=64] $0 your-name.dynv6.net [device]"
  exit 1
fi

if [ -z "$netmask" ]; then
  netmask=128
fi

if [ -n "$device" ]; then
  device="dev $device"
fi
address=$(ip -6 addr list scope global $device | grep -v " fd" | sed -n 's/.*inet6 \([0-9a-f:]\+\).*/\1/p' | head -n 1)

if [ -e /usr/bin/curl ]; then
  bin="curl -fsS"
elif [ -e /usr/bin/wget ]; then
  bin="wget -O-"
else
  echo "neither curl nor wget found"
  exit 1
fi

if [ -z "$address" ]; then
  echo "no IPv6 address found"
  exit 1
fi

# address with netmask
current=$address/$netmask

if [ "$old" = "$address" ]; then
  echo "IPv6 address unchanged - $date - $current"
  exit
fi

echo "IPv6 address changed - $date - $old -> $current"

# send addresses to dynv6
$bin "https://ipv6.dynv6.com/api/update?hostname=$hostname&ipv6=$current&token=$token"
# new line
echo ""
# save current address
echo $current > $file
