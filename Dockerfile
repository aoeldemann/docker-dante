FROM alpine:latest
MAINTAINER Andreas Oeldemann <hey@aoel.io>

ENV DANTE_VERSION 1.4.2
ENV DANTE_URL http://www.inet.no/dante/files/dante-1.4.2.tar.gz
ENV DANTE_SHA256 4c97cff23e5c9b00ca1ec8a95ab22972813921d7fbf60fc453e3e06382fc38a7

RUN apk add --no-cache curl build-base

RUN mkdir /src && curl -sSL $DANTE_URL -o /src/dante.tar.gz && \
    echo "$DANTE_SHA256 */src/dante.tar.gz" | sha256sum -c && \
    tar -C /src -xzf /src/dante.tar.gz

RUN cd /src/dante-$DANTE_VERSION && \
    ac_cv_func_sched_setscheduler=no ./configure && make install

EXPOSE 1080/tcp

ENTRYPOINT ["sockd"]
