#!/bin/bash

function set_dir {
    if [ ! -d ./var ]; then
        mkdir -p ./var/main
        cp -r keystore ./var/main/
        mkdir ./var/log
    fi
}

function gen_pnet {
    if [ ! -d ./var/main/geth ]; then
        geth --datadir ./var/main init genesis.json
        echo "init private network"
    fi

    if [ -f .pnet ]; then
        running_pid=$(cat .pnet)

        kill -15 $running_pid
        rm .pnet
        echo "kill already running private network process: $running_pid"
    fi

    {
        geth --unlock "0x6e1a9ec327f437fb1ef62900842e7ca1864580c3" --password ".password" --nodiscover --rpc --rpccorsdomain "http://localhost:8080" --mine --datadir ./var/main --networkid 333 2> ./var/log/pnet.log &
        pnet_pid=$! 
        echo $pnet_pid > .pnet
        echo "start private network"
    } || {
        kill -15 $pnet_pid
        rm .pnet
        echo "error: generate private network: kill process: $pnet_pid"
    }
}

function gen_discover {
    if [ -f .bootnode ]; then
        running_pid=$(cat .bootnode)
        kill -15 $running_pid
        rm .bootnode
        echo "kill already running bootnode process: $running_pid"
    fi

    {
        bootnode --nodekey=pnet.key 2> ./var/log/discover.log &
        bootnode_pid=$!
        echo $bootnode_pid > .bootnode
        echo "start discovery"
    } || {
        kill -15 $bootnode_pid
        rm .bootnode
        echo "error: generate bootnode: kill process: $bootnode_pid"
    }
}

function list_process {
    if [ -f .pnet ]; then
        echo "private network process: $(cat .pnet)"
    fi

    if [ -f .bootnode ]; then
        echo "bootnode process: $(cat .bootnode)"
    fi

    if [ -f .node ]; then
        echo "node process: $(cat .node)"
    fi
}

function kill_process {
    if [ -f .pnet ]; then
        local pnet_pid=$(cat .pnet)

        if [ ! -z $pnet_pid ]; then
            kill -15 $pnet_pid
            echo "shutdown private network node"
            rm .pnet    
        fi
    fi

    if [ -f .bootnode ]; then
        local bootnode_pid=$(cat .bootnode)

        if [ ! -z $bootnode_pid ]; then
            kill -15 $bootnode_pid
            echo "shutdown bootnode"
            rm .bootnode
        fi
    fi

    if [ -f .node ]; then
        local node_pid=$(cat .node)

        if [ ! -z $node_pid ]; then
            kill -15 $node_pid
            echo "shutdown node"
            rm .node
        fi
    fi
}

function add_node {
    if [ -f .node ]; then 
        node_pid=$(cat .node)
        kill -15 $node_pid   
        echo "kill already running node process: $node_pid"
    fi

    {
        geth --datadir ./var/node --port 30304 --networkid 333 --bootnodes "enode://26168c13637850b7b15c41a1f9cf1904cb93edde0c7479b0eaf6d018a4337842@localhost:30301" 2> ./var/log/node.log &
        node_pid=$! 
        echo $node_pid > .node
        echo "start node"
    } || {
        kill -15 $node_pid
        rm .node
    }
}

function attach_pnet {
    geth --datadir ./var/main attach ipc:./var/main/geth.ipc
}

case $1 in
    clear) kill_process
        rm -rf ./var
        ;;
    attach) attach_pnet
        ;;
    ps) list_process
        ;;
    shutdown) kill_process
        ;;
    add) add_node
        ;;
    *)
        set_dir
        gen_pnet
        gen_discover
        ;;
esac

