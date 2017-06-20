#!/bin/sh

geth init genesis.json
exec "${@}"
