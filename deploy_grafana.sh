docker service create --name grafana \
	--network func_functions \
	-p 3000:3000 \
	-e GF_AUTH_ANONYMOUS_ENABLED=true \
	-e GF_AUTH_ANONYMOUS_ORG_NAME="Main Org." \
	-e GR_AUTH_ANONYMOUS_ORG_ROLE=View \
	-e GR_AUTH_DISABLE_LOGIN_FORM=true \
	-e GR_AUTH_DISABLE_SIGNOUT_MENU=true \
	thomasjpfan/grafana-openfaas
