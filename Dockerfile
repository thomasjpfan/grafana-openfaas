FROM grafana/grafana:5.3.1

COPY src src

ENV PROMETHEUS_ENDPOINT=http://func_prometheus:9090

ENTRYPOINT ["/src/entrypoint.sh"]
