#!/bin/bash 
# Inspiré d'un script trouvé sur phpnews.fr (plus en ligne)
# Version 0.4 16/09/2020 
# Script sous licence BEERWARE 
set -eu
## Paramètres
# Répertoire de stockage des sauvegardes
DATADIR="/mnt/diskstation/git/backup/postgres/"
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
EXCLUSIONS='(postgres|template1|template0)'
# Email pour les erreurs (0 pour désactiver
EMAIL=0
# Log d'erreur
exec 2> ${DATATMP}/error.log
 
## Début du script
 
ionice -c3 -p$$ &>/dev/null
renice -n 19 -p $$ &>/dev/null
 
function cleanup {
    if [ "`stat --format %s ${DATATMP}/error.log`" != "0" ] && [ "$EMAIL" != "0" ] ; then
        cat ${DATATMP}/error.log | mail -s "Backup Postgres $DATANAME - Log error" ${EMAIL}
    fi
}
trap cleanup EXIT
 
# On crée sur le disque un répertoire temporaire
mkdir -p ${DATATMP}/last
 
# On place dans un tableau le nom de toutes les bases de données du serveur 
databases="$(psql -d postgres -c 'select datname from pg_catalog.pg_database;' -t|grep -v -E $EXCLUSIONS)"
 
# Pour chacune des bases de données trouvées ... 
for database in ${databases[@]} 
do
    echo "dump : $database"
    pg_dump $database  > ${DATATMP}/last/${database}.sql
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
