#!/bin/bash 
# Inspiré d'un script trouvé sur phpnews.fr (plus en ligne)
# Version 0.3 13/05/2013 
# Script sous licence BEERWARE 
set -eu
## Paramètres
USER='dump'
PASS='wg4KAKkbywiLs8pQ' 
# Répertoire de stockage des sauvegardes
DATADIR="/mnt/diskstation/git/backup/mysql/"
# Répertoire de travail (création/compression)
DATATMP=$DATADIR
# Nom du dump
DATANAME="dump_$(date +%d.%m.%y@%Hh%M)"
# Compression
COMPRESSIONCMD="tar -czf" 
COMPRESSIONEXT=".tar.gz"
# Rétention / rotation des sauvegardes
RETENTION=30
# Exclure des bases
EXCLUSIONS='(information_schema|performance_schema|mysql)'
# Email pour les erreurs (0 pour désactiver
EMAIL=0
# Log d'erreur
exec 2> ${DATATMP}/error.log
 
## Début du script
 
ionice -c3 -p$$ &>/dev/null
renice -n 19 -p $$ &>/dev/null
 
function cleanup {
    if [ "`stat --format %s ${DATATMP}/error.log`" != "0" ] && [ "$EMAIL" != "0" ] ; then
        cat ${DATATMP}/error.log | mail -s "Backup MySQL $DATANAME - Log error" ${EMAIL}
    fi
}
trap cleanup EXIT
 
# On crée sur le disque un répertoire temporaire
mkdir -p ${DATATMP}/last
 
# On place dans un tableau le nom de toutes les bases de données du serveur 
databases="$(mysql -u $USER -p$PASS -Bse 'show databases' | grep -v -E $EXCLUSIONS)"
 
# Pour chacune des bases de données trouvées ... 
for database in ${databases[@]} 
do
    echo "dump : $database"
    mysqldump -u $USER -p$PASS --quick --add-locks --lock-tables --extended-insert $database  > ${DATATMP}/last/${database}.sql
done 
 
# On tar tous
cd ${DATATMP}
${COMPRESSIONCMD} ${DATANAME}${COMPRESSIONEXT} last/
chmod 600 ${DATANAME}${COMPRESSIONEXT}
 
# On le déplace dans le répertoire
if [ "$DATATMP" != "$DATADIR" ] ; then
    mv ${DATANAME}${COMPRESSIONEXT} ${DATADIR}
fi
 
# Lien symbolique sur la dernier version
#cd ${DATADIR}
#set +eu
#unlink last${COMPRESSIONEXT}
#set -eu
#ln ${DATANAME}${COMPRESSIONEXT} last${COMPRESSIONEXT}
 
# On supprime le répertoire temporaire 
#rm -rf ${DATATMP}/${DATANAME}
 
echo "Suppression des vieux backup : "
find ${DATADIR} -name "*${COMPRESSIONEXT}" -mtime +${RETENTION} -print -exec rm {} \;
