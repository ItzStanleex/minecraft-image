#!/bin/bash
cd /home/container

# Output current Java version
java -version

# Replace startup variables
MODIFIED_STARTUP=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run the server
eval "${MODIFIED_STARTUP}"
