FROM debian:9.6-slim

LABEL name="Check_MK agent" \
      maintainer="Wellington Oliveira <wvoliveira@oliveira.it>" \
      app_repository="https://github.com/wvoliveira/check-mk-agent.git"

COPY app /app

RUN apt-get update \
    && apt-get install --no-install-recommends xinetd curl -y \
    && rm -fr /var/lib/apt/lists/*

RUN cp /app/xinetd.d/check_mk /etc/xinetd.d/check_mk \
    && cp /app/bin/check_mk_agent /usr/bin/check_mk_agent \
    && chmod +x /usr/bin/check_mk_agent

EXPOSE 6556

ENTRYPOINT [ "xinetd", "-f", "/etc/xinetd.conf", "-dontfork"]

