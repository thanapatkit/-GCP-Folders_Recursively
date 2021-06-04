#!/bin/bash

rm -f $PWD/list_folders.csv

ORGANIZATION_ID="[FILL_IN_ORGANIZATION_ID]"

# gcloud format
FORMAT="csv[no-heading](name,displayName.encode(base64))"

echo Folder_Name,Folder_ID > $PWD/list_folders.csv

# Enumerates Folders recursively
folders()
{
  LINES=("$@")
  for LINE in ${LINES[@]}
  do
    # Parses lines of the form folder,name
    VALUES=(${LINE//,/ })
    FOLDER=${VALUES[0]}

    # Decodes the encoded name
    NAME=$(echo ${VALUES[1]} | base64 --decode)
    printf "Folder: ${NAME},${FOLDER}\n"
    folder_name=${NAME}
    folder_id=${FOLDER}
    echo $folder_name,$folder_id >> $PWD/list_folders.csv
    
    folders $(gcloud resource-manager folders list \
      --folder=${FOLDER} \
      --format="${FORMAT}")

  done
}

# Start at the Org
echo "Organization: [ORGANIZATION_NAME],${ORGANIZATION_ID}"

folder_name="[ORGANIZATION_NAME]"
folder_id=${ORGANIZATION_ID}
echo $folder_name,$folder_id >> $PWD/list_folders.csv

LINES=$(gcloud resource-manager folders list \
  --organization=${ORGANIZATION_ID} \
  --format="${FORMAT}")

# Descend
folders ${LINES[0]}