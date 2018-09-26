TAG?=master
CIRCLE_SHA1?=master

.PHONY: image

image:
	docker image build -t thomasjpfan/grafana-openfaas:$(TAG) \
	--label "org.opencontainers.image.revision=$(CIRCLE_SHA1)" .
