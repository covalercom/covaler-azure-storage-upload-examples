#!/bin/bash
# Simple bash script to upload a file to Azure Blob Storage
# Equivalent to the PowerShell script

# Configuration - replace with your actual values
STORAGE_ACCOUNT="datastoreenergyreporting"
CONTAINER="energy-data-container"
FILE_PATH=""     # populate with name of upload file
SAS_TOKEN=""     # populate with Azure sourced SAS token


# Construct the URL
URI="https://${STORAGE_ACCOUNT}.blob.core.windows.net/${CONTAINER}/${FILE_PATH}?${SAS_TOKEN}"

# Check if file exists
if [ ! -f "$FILE_PATH" ]; then
    echo "File not found: $FILE_PATH"
    exit 1
fi

# Upload the file using curl
echo "Uploading $FILE_PATH to $CONTAINER..."

HTTP_STATUS=$(curl -X PUT \
    -H "x-ms-blob-type: BlockBlob" \
    -H "Content-Type: application/octet-stream" \
    --data-binary "@${FILE_PATH}" \
    -w "%{http_code}" \
    -o /dev/null \
    -s \
    "$URI")

# Check the response
if [ "$HTTP_STATUS" -eq 201 ]; then
    echo "Successfully uploaded $FILE_PATH to $CONTAINER"
else
    echo "Failed to upload file. HTTP Status: $HTTP_STATUS"
    exit 1
fi
