SERVICES=("mariadb" "nginx" "php-fpm" "gitea" "tt-rss" "named" "autofs" "rsyncd.socket")
HOST=$(hostname)
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo "device $HOST have reboot curent status of critic service:"
for service in ${SERVICES[@]}
do
    status=$(systemctl is-active $service)
    
    if [ $status = "inactive" ]
    then
        echo -e "${RED}$service is $status${NC}"
        echo $(journalctl -u $service --lines=10 -q)
    else
        echo -e "${GREEN}$service is $status${NC}"
    fi
    echo ""
done
