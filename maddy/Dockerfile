ARG TAG
FROM zerotens/maddy-base:${TAG}
COPY maddy.conf /etc/maddy.conf
ENTRYPOINT ["/bin/maddy", "-config", "/etc/maddy.conf"]