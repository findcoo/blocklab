#!/bin/sh

mkdir -p /root/.ethereum/keystore
cp /root/keystore/* /root/.ethereum/keystore/
geth init /root/genesis.json
exec "${@}"
