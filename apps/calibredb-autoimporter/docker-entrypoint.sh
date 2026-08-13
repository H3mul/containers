#!/usr/bin/env bash

CALIBRE_LIBRARY_DIRECTORY=${CALIBRE_LIBRARY_DIRECTORY:-/opt/calibredb/library}
CALIBREDB_AUTOIMPORT_DIRECTORY=${CALIBREDB_AUTOIMPORT_DIRECTORY:-/opt/calibredb/import}

echo "Starting auto-importer process."
while true
do
    count=`find $CALIBREDB_AUTOIMPORT_DIRECTORY -mindepth 1 -maxdepth 1 | wc -l`
    if [ $count -gt 0 ]; then
      echo "Attempting import of $count new files/directories."
      
      /opt/calibre/calibredb add -r $CALIBREDB_AUTOIMPORT_DIRECTORY \
        --with-library $CALIBRE_LIBRARY_DIRECTORY \
        --automerge ignore
    fi
done
