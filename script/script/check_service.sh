SERVICES=("mariadb" "nginx" "php-fpm" "gitea" "tt-rss" "named" "autofs" "rsyncd.socket")
HOST=$(hostname)
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

#attend 60s pour que les autre service est le temps de démarrer
sleep 60

echo "device $HOST have reboot curent status of critic service:"
for service in ${SERVICES[@]}
do
    status=$(systemctl is-active $service)
    
    if [ $status = "active" ]
    then
        echo -e "$service is $status"
    else
        echo -e "$service is $status"
        echo $(journalctl -u $service --lines=10 -q)
    fi
    echo ""
done
