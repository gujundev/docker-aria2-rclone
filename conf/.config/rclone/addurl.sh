#!/bin/bash

apipath="http://localhost:6800/jsonrpc"
apitoken="token:mayikissyou"

cookie=`cat $2`

cat $1 | while read line
do
url=${line}
down="/home/aria2"
file=$(echo -n $url | sed 's/\\/\\\\/g;s/\(%\)\([0-9a-fA-F][0-9a-fA-F]\)/\\x\2/g')
file=`printf $file`
dir="$down/${file#*/Documents/}"
curl ${apipath} \
  -H 'Content-Type: application/json;charset=UTF-8' \
  --data-raw "{\"jsonrpc\":\"2.0\",\"method\":\"aria2.addUri\",\"id\":\"shell\",\"params\":[\"${apitoken}\",[\"${url}\"],{\"dir\":\"${dir}\",\"header\":[\"${cookie}\"],\"pause\":\"true\"}]}" \
  --compressed 
echo ""
done