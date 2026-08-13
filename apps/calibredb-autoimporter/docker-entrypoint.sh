#!/usr/bin/env bash

CALIBRE_LIBRARY_DIRECTORY=${CALIBRE_LIBRARY_DIRECTORY:-/opt/calibredb/library}
CALIBREDB_AUTOIMPORT_DIRECTORY=${CALIBREDB_AUTOIMPORT_DIRECTORY:-/opt/calibredb/import}
CALIBREDB_IMPORT_TIMEOUT=${CALIBREDB_IMPORT_TIMEOUT:-15}
CALIBREDB_IMPORT_TAG=${CALIBREDB_IMPORT_TAG:-}

CALIBREDB_IMPORT_TAG_CMD=""
if [ -n "$CALIBREDB_IMPORT_TAG" ]; then
    CALIBREDB_IMPORT_TAG_CMD="--tag \"$CALIBREDB_IMPORT_TAG\""
fi

echo "Starting auto-importer process."
while true
do
    count=`find $CALIBREDB_AUTOIMPORT_DIRECTORY -mindepth 1 -maxdepth 1 | wc -l`
    if [ $count -gt 0 ]; then
      echo "Attempting import of $count new files/directories."
      
      /opt/calibre/calibredb add -r $CALIBREDB_AUTOIMPORT_DIRECTORY \
        --with-library $CALIBRE_LIBRARY_DIRECTORY \
        --automerge ignore --timeout 15 $CALIBREDB_IMPORT_TAG_CMD
    fi
done
