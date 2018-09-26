#!/bin/bash
set -m

exec /run.sh "$@" &

# Set up grafana
grafana_admin_user=${GF_SECURITY_ADMIN_PASSWORD:-admin}
grafana_admin_password=${GF_SECURITY_ADMIN_USER:-admin}

for i in {0..90}; do
	if curl -sf "http://localhost:3000"; then
		break
	fi
	printf "."
	sleep 1
done

if [ "$i" = 0 ]; then
	echo "Grafana did not start!"
	exit 1
fi
echo "Grafana is ready!"

# Import from prometheus
curl -s "http://${grafana_admin_user}:${grafana_admin_password}@localhost:3000/api/datasources" \
	-X POST -H 'Content-Type: application/json;charset=UTF-8' \
	--data-binary @- <<EOF
{
    "name": "OpenFaas",
    "type": "prometheus",
    "url": "${PROMETHEUS_ENDPOINT}",
    "access": "proxy",
    "isDefault": true
}
EOF

# Import databoards
for f in /src/dashboards/*; do
	case "$f" in
	*.json)
		echo "{ \"dashboard\": $(cat $f), \"overwrite\":true }" >/tmp/dashboard_data.json
		sed -i "s@\${DS_FAAS}@OpenFaas@g" /tmp/dashboard_data.json
		curl \
			-X POST -H 'Content-Type: application/json;charset=UTF-8' \
			-d @/tmp/dashboard_data.json \
			"http://${grafana_admin_user}:${grafana_admin_password}@localhost:3000/api/dashboards/db"
		;;
	*)
		echo "$0; ignoring $f"
		;;
	esac
done

jobs

fg %1
