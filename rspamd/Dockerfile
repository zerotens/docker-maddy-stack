ARG RSPAMD_VERSION=2.7
ARG ALPINE_VERSION=latest
FROM alpine:${ALPINE_VERSION} as build
ARG RSPAMD_VERSION

RUN	apk add --no-cache curl \
                       g++ \
                       make \
                       cmake \
                       curl-dev \
                       file-dev \
                       gd-dev \
                       glib-dev \
                       icu-dev \libevent-dev \
                       libsodium-dev \
                       openssl-dev \
                       pcre2-dev \
                       perl \
                       ragel \
                       sqlite-dev \
                       zstd-dev \
                       luajit-dev

RUN mkdir /rspamd-source && \
    chown mail:mail /rspamd-source && \
    mkdir /rspamd/ && \
    chown mail:mail /rspamd/

USER mail

RUN cd /rspamd-source && \
    curl -L https://github.com/rspamd/rspamd/archive/refs/tags/${RSPAMD_VERSION}.tar.gz --output rspamd-${RSPAMD_VERSION}.tar.gz && \
    tar xf rspamd-${RSPAMD_VERSION}.tar.gz && \
    cd rspamd-${RSPAMD_VERSION}/ && \
    cmake . && \
    make DESTDIR=/rspamd/ install


FROM alpine:${ALPINE_VERSION}

RUN apk --no-cache add tini \
                       luajit \
                       sqlite-libs \
                       libsodium \
                       glib \
                       libstdc++ \
                       icu-libs
COPY --from=build /rspamd /
COPY ./entrypoint.sh /
RUN mkdir /var/lib/rspamd && \
    chown mail:mail /var/lib/rspamd
RUN chmod +x /entrypoint.sh

RUN mkdir -p /usr/local/etc/rspamd/local.d/ && mkdir -p /usr/local/etc/rspamd/override.d/ \
    && echo 'type = "console";' > /usr/local/etc/rspamd/override.d/logging.inc \
    && echo 'bind_socket = "*:11334";' > /usr/local/etc/rspamd/override.d/worker-controller.inc \
	&& echo 'pidfile = false;' > /usr/local/etc/rspamd/options.inc \
	&& echo 'servers = "redis:6379";' >/usr/local/etc/rspamd/local.d/redis.conf \
	&& echo 'enabled = true;' > /usr/local/etc/rspamd/local.d/worker-normal.inc \
	&& echo 'bind_socket = "*:11333";' > /usr/local/etc/rspamd/override.d/worker-normal.inc \
	&& echo 'upstream "local" {' > /usr/local/etc/rspamd/local.d/worker-proxy.inc \
	&& echo '  self_scan = yes;' >> /usr/local/etc/rspamd/local.d/worker-proxy.inc \
	&& echo '}' >> /usr/local/etc/rspamd/local.d/worker-proxy.inc \
	&& echo 'bind_socket = "*:11332";' >> /usr/local/etc/rspamd/local.d/worker-proxy.inc \
	&& echo 'password = "";' > /usr/local/etc/rspamd/local.d/worker-controller.inc \
	&& echo 'enable_password = "";' >> /usr/local/etc/rspamd/local.d/worker-controller.inc

ENTRYPOINT [ "tini", "--", "./entrypoint.sh" ]
CMD	[ "rspamd", "-f", "-u", "mail", "-g", "mail" ]

EXPOSE	11333/tcp 11334/tcp