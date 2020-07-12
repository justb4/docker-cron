FROM alpine:3.12
# Inspired from: https://github.com/xordiv/docker-alpine-cron

LABEL maintainer="Just van den Broecke <justb4@gmail.com>"

RUN apk update && \
	apk add dcron ca-certificates docker docker-compose && \
	rm -rf /var/cache/apk/* && \
	mkdir -p /var/log/cron && \
	mkdir -m 0644 -p /var/spool/cron/crontabs && \
	touch /var/log/cron/cron.log && \
	mkdir -m 0644 -p /etc/cron.d

COPY /scripts/* /

ENTRYPOINT ["/docker-entry.sh"]

CMD ["/docker-cmd.sh"]
