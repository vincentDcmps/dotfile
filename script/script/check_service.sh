SERVICES=("mariadb" "nginx" "php-fpm" "gitea" "tt-rss" "named" "autofs" "rsyncd")
HOST=$(hostname)

echo "device $HOST have reboot curent status of critic service:"
for service in ${SERVICES[@]}
do
    status=$(systemctl is-active $service)
    echo "$service is $status"
    if [ $status = "inactive" ]
    then
     echo $(journalctl -u $service --lines=10 )
    fi

done
