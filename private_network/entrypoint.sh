#!/bin/sh

mkdir -p /root/.ethereum/keystore
cp /root/keystore/* /root/.ethereum/keystore/
geth init genesis.json
exec "${@}"
