FROM ethereum/client-go:latest
MAINTAINER findcoo <thirdlif2@gmail.com>

COPY genesis.json /home/dev/genesis.json
COPY entrypoint.sh /home/dev/entrypoint.sh
ENTRYPOINT ["/home/dev/entrypoint.sh"]
CMD ["geth", "-nodiscover", "--networkid", "1"]


