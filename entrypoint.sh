#!/bin/bash
cd /home/container

# Output current Java version
java -version

# Force UTF-8 encoding for Java
export JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8 -Dconsole.encoding=UTF-8"

# Replace startup variables
MODIFIED_STARTUP=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run the server
eval "${MODIFIED_STARTUP}"
