#!/bin/bash
cd /root/ticker

touch /var/log/tick.log /var/log/rdb.log /var/log/hdb.log

# Tickerplant
nohup /root/q/l32/q tick.q sym /data -p 5010 < /dev/null > /var/log/tick.log 2>&1 &

sleep 2 # wait for tick to start

# RDB
nohup /root/q/l32/q tick/r.q :5010 -p 5011 < /dev/null > /var/log/rdb.log 2>&1 &

# HDB
nohup /root/q/l32/q tick/hdb.q /data/sym -p 5012 < /dev/null > /var/log/hdb.log 2>&1 &

# Feedhandler (uncomment when ready)
# nohup /root/q/l32/q tick/feed.q < /dev/null > /var/log/feed.log 2>&1 &

tail -f /var/log/tick.log /var/log/rdb.log /var/log/hdb.log