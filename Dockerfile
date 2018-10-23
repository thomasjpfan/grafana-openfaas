FROM grafana/grafana:5.3.1

USER root
RUN apt-get update && apt-get install -qq -y curl && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

USER grafana
COPY src src

ENV PROMETHEUS_ENDPOINT=http://prometheus:9090

ENTRYPOINT ["./src/entrypoint.sh"]
