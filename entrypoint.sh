#!/bin/sh -l
set -eu

# Create tmp ssh key file
TEMP_SSH_PRIVATE_KEY_FILE='../ssh_key'
printf "%s" "$4" > $TEMP_SSH_PRIVATE_KEY_FILE
chmod 600 $TEMP_SSH_PRIVATE_KEY_FILE

echo 'Start Deployment'

# Create deployment folder if it does not exist
ssh -o StrictHostKeyChecking=no -p $3 -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2 mkdir -p $6

# Remove potential existig files in deployment folder
ssh -o StrictHostKeyChecking=no -p $3 -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2 rm -r $6/*

# Copy new files to folder
scp -i $TEMP_SSH_PRIVATE_KEY_FILE -P $3 -r $5 $1@$2:$6

echo 'Deployment success'
exit 0

