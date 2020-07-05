SERVICES=("syncthing@vincent" "mariadb" "nginx" "php-fpm" "gitea" "tt-rss" "gunicorn-chainetv.socket" "gunicorn-supysonic" "rsyncd.service" "fail2ban" "supysonic-daemon" "home-assistant" "radicale")
CONTAINER=("pihole")
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
for container in ${CONTAINER[@]}
do
   status=$(docker ps | grep $container  >/dev/null && (echo active) || (echo inactive))
   echo -e "$container is $status"
done
