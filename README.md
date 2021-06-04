# [GCP]Folders_Recursively

<img src="https://download.logo.wine/logo/Google_Cloud_Platform/Google_Cloud_Platform-Logo.wine.png" width="600px">


## Features

1. Drill structure hierarchy of Organization or Folders(Department).
2. Export as csv file.

## Least Privilege

In order to execute this module you must have a Service Account with the
following roles:

- `roles/resourcemanager.organizationViewer` on the organization level
- `roles/resourcemanager.folderViewer` on the organization level

### Example Result from CSV File

Folder_Name,Folder_ID</br>
[ORGANIZATION_NAME],[ORGANIZATION_ID]</br>
[FOLDER_NAME],[FOLDER_ID]
