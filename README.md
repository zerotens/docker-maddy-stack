# Docker Maddy Stack

Docker Maddy Stack is my personal docker-compose mail service stack which utilizes the maddy mail server and is built for my Raspberry Pi Server.
Due to missing support for specific upstream images for ARM64 architecture most images are build manually with docker-compose.

## Low Resource usage info

```
CONTAINER ID   NAME               CPU %     MEM USAGE    NET I/O           BLOCK I/O     PIDS
565b1a341b3b   hs_maddy_1         0.02%     8.914MiB     54kB / 70.1kB     0B / 12.3kB   9
badc3f9d3aa3   hs_rspamd_1        0.11%     77.09MiB     5.86MB / 2.75MB   0B / 4.1kB    6
7c42ffbf1fba   hs_unbound_1       1.20%     8.504MiB     25.2MB / 5.39MB   0B / 8.19kB   1
d3c65ac44ffc   hs_dnsrobocert_1   0.01%     46.49MiB     9.32kB / 0B       0B / 0B       1
e31db1bb5097   hs_redis_1         0.16%     4.008MiB     8.07MB / 8.45MB   0B / 152kB    6
467db863d3b3   hs_mta-sts_1       0.00%     1.438MiB     9.17kB / 0B       0B / 0B       5
af19b5d724f0   traefik            0.61%     16.22MiB     9.33MB / 9.51MB   0B / 0B       12
```

## Build Images

```docker-compose -f docker-build.yml build```

## Related Links

* [Maddy Docs](https://maddy.email/)
* [DNSRoboCert Docs](https://dnsrobocert.readthedocs.io/en/latest/)
* [RSPAMD Docs](https://rspamd.com/doc/index.html)