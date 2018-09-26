docker service create --name grafana \
	--network func_functions \
	-p 3000:3000 \
	-e GF_AUTH_ANONYMOUS_ENABLED=true \
	-e GF_AUTH_ANONYMOUS_ORG_NAME="Main Org." \
	-e GF_AUTH_DISABLE_LOGIN_FORM=true \
	thomasjpfan/grafana-openfaas
