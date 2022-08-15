# [GCP] Folders_Recursively

<img src="https://download.logo.wine/logo/Google_Cloud_Platform/Google_Cloud_Platform-Logo.wine.png" width="350px">


## Features

1. Drill all structure hierarchy under Organization.
2. Printing the Organization/Folder name and ID
3. Export as csv file.

## Least Privilege

In order to execute this module you must have a Service Account with the
following roles:

- `roles/resourcemanager.organizationViewer` on the organization level
- `roles/resourcemanager.folderViewer` on the organization level

_reference: <https://cloud.google.com/iam/docs/understanding-roles#resource-manager-roles>_

### Example Result from CSV File
```
Folder_Name,Folder_ID
[ORGANIZATION_NAME],[ORGANIZATION_ID]
[FOLDER_NAME],[FOLDER_ID]
[PROJECT_ID],[PROJECT_NUMBER]
```

'# Updated 8/15/2022'
