FROM ethereum/client-go:latest
MAINTAINER findcoo <thirdlif2@gmail.com>

COPY genesis.json /root/genesis.json
COPY entrypoint.sh /root/entrypoint.sh
COPY keystore/ /root/keystore/

ENTRYPOINT ["/root/entrypoint.sh"]
CMD ["geth", "--nodiscover", "--networkid", "333"]
