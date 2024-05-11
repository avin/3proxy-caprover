#!/bin/sh

CONFIG=/usr/local/etc/3proxy/3proxy.cfg

sed -i "s|_LOGIN_|$LOGIN|g" $CONFIG
sed -i "s|_PASSWORD_|$PASSWORD|g" $CONFIG
sed -i "s|_PORT_|$PORT|g" $CONFIG

3proxy $CONFIG
