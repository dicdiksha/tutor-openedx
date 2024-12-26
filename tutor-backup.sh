#!/bin/bash

BACKUPS_DIRECTORY="/tmp/backups/"
WORKING_DIRECTORY="/tmp/backup-tmp/"
NUMBER_OF_BACKUPS_TO_RETAIN="10"            # Note: this only regards local storage (i.e., on the ncertx_prod_user server). All backups are retained in the S3 bucket forever.

NOW="$(date +%Y%m%dT%H%M%S)"
SQL_FILE="openedx-mysql-${NOW}.sql"
SQL_TARBALL="openedx-mysql-${NOW}.tgz"

# Ensure working and backup directories exist
mkdir -p "$WORKING_DIRECTORY"
mkdir -p "$BACKUPS_DIRECTORY"

# Clean working directory
rm -rf "${WORKING_DIRECTORY:?}"/*

echo "Backing up MySQL databases"
tutor local exec -e MYSQL_ROOT_PASSWORD="$(tutor config printvalue MYSQL_ROOT_PASSWORD)" mysql \
    sh -c 'mysqldump --all-databases -u root --password=$MYSQL_ROOT_PASSWORD > /var/lib/mysql/dump.sql'

sudo mv $(tutor config printroot)/data/mysql/dump.sql ${WORKING_DIRECTORY}/${SQL_FILE}
sudo chown ncertx_prod_user ${WORKING_DIRECTORY}/${SQL_FILE}
sudo chgrp ncertx_prod_user ${WORKING_DIRECTORY}/${SQL_FILE}


# Tarball the MySQL backup file
echo "Compressing MySQL backup into a single tarball archive"
cd "$WORKING_DIRECTORY" || exit
tar -czf "${BACKUPS_DIRECTORY}${SQL_TARBALL}" "${SQL_FILE}"
rm "${SQL_FILE}"
echo "Created tarball of MySQL backup data: ${SQL_TARBALL}"

# End Backup MySQL databases

# Begin Backup MongoDB
echo "Backing up MongoDB"
tutor local exec mongodb mongodump --out=/data/db/dump.mongodb

# Move the MongoDB dump to the backup directory
sudo mv "$(tutor config printroot)/data/mongodb/dump.mongodb" "${WORKING_DIRECTORY}/mongo-dump"
sudo chown -R ncertx_prod_user "${WORKING_DIRECTORY}/mongo-dump"
sudo chgrp -R ncertx_prod_user "${WORKING_DIRECTORY}/mongo-dump"

# Tarball the MongoDB backup files
echo "Compressing MongoDB backup into a single tarball archive"
tar -czf "${BACKUPS_DIRECTORY}openedx-mongo-${NOW}.tgz" -C "${WORKING_DIRECTORY}" "mongo-dump"
rm -rf "${WORKING_DIRECTORY}/mongo-dump"
echo "Created tarball of MongoDB backup data: openedx-mongo-${NOW}.tgz"

# End Backup MongoDB

# Prune the Backups Directory
echo "Pruning the local backup folder archive"
if [ -d "${BACKUPS_DIRECTORY}" ]; then
  cd "${BACKUPS_DIRECTORY}" || exit
  ls -1tr | grep ".tgz" | head -n -"${NUMBER_OF_BACKUPS_TO_RETAIN}" | xargs -d '\n' rm -f --
fi

# Clean up the working folder
echo "Cleaning up"
rm -rf "${WORKING_DIRECTORY}"

echo "Backup process completed successfully."
