FROM grafana/grafana:5.3.1

COPY src work

ENV PROMETHEUS_ENDPOINT=http://prometheus:9090

ENTRYPOINT ["/work/entrypoint.sh"]
