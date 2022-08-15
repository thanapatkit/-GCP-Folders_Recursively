#!/bin/bash

rm -f $PWD/list_resource_hierarchy.csv

ORGANIZATION_ID="[Fil_in_Organization_ID]"
project_uf_arr=()

# gcloud format
FORMAT="csv[no-heading](name,displayName.encode(base64))"

echo Name,ID,type > $PWD/list_resource_hierarchy.csv

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
    folder_name=${NAME}
    folder_id=${FOLDER}
    type2="Folder"
    printf "Folder: ${NAME},${FOLDER},${type2}\n"
    echo $folder_name,$folder_id,$type2 >> $PWD/list_resource_hierarchy.csv

    for listproject in $(gcloud projects list --filter 'parent.id='${FOLDER}' AND parent.type=folder' --format='value(projectId)')
	do
        project_id=$(gcloud projects describe $listproject --format='value(projectId)')
        project_number=$(gcloud projects describe $listproject --format='value(projectNumber)')
        type3="Project"
        printf "Project: ${project_id},${project_number},${type3}\n"
        echo $project_id,$project_number,$type3 >> $PWD/list_resource_hierarchy.csv
        project_uf_arr+=($listproject)
    done
    
    folders $(gcloud resource-manager folders list \
      --folder=${FOLDER} \
      --format="${FORMAT}")

  done
}

# Start at the Org
ORGANIZATION_NAME=$(gcloud organizations describe ${ORGANIZATION_ID} --format='value(displayName)')
folder_name=${ORGANIZATION_NAME}
folder_id=${ORGANIZATION_ID}
type1="Organization"
echo "Organization: ${ORGANIZATION_NAME},${ORGANIZATION_ID},${type1}"
echo $folder_name,$folder_id,$type1 >> $PWD/list_resource_hierarchy.csv

LINES=$(gcloud resource-manager folders list \
  --organization=${ORGANIZATION_ID} \
  --format="${FORMAT}")

# Descend
folders ${LINES[0]}

# Projects that are not under the folder.
project_nuf_arr=($(gcloud projects list --filter 'parent.id='${ORGANIZATION_ID}' AND parent.type=organization' --format='value(projectId)'))

for project_nuf in "${project_nuf_arr[@]}"
do

    project_id=$(gcloud projects describe $project_nuf --format='value(projectId)')
    project_number=$(gcloud projects describe $project_nuf --format='value(projectNumber)')
    type3="Project"
    printf "Project: ${project_id},${project_number},${type3}\n"
    echo $project_id,$project_number,$type3 >> $PWD/list_resource_hierarchy.csv

done
