FROM alpine:3.12
# Inspired from: https://github.com/xordiv/docker-alpine-cron

LABEL maintainer="Just van den Broecke <justb4@gmail.com>"

ARG EXTRA_APK_PACKAGES="docker docker-compose"

ENV CRON_DEBUG_LEVEL="notice"

RUN apk update && \
	apk add dcron ca-certificates ${EXTRA_APK_PACKAGES} && \
	rm -rf /var/cache/apk/* && \
	mkdir -m 0644 -p /var/spool/cron/crontabs && \
	touch /var/log/cron.log && \
	mkdir -m 0644 -p /etc/cron.d

COPY /scripts/* /

ENTRYPOINT ["/docker-entry.sh"]

CMD ["/docker-cmd.sh"]
