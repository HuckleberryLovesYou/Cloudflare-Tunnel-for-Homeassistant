#!/bin/bash
# This script updates all cloudflard instances running in all contains where their name includes 'cloudflared-' 

echo "This script updates all cloudflard instances running in all contains where their name includes 'cloudflared-'"
echo "Starting updating"

docker container ps -a | grep "cloudflared-" | while read -r container; do
    containerID=$(echo "$container" | head -c 12)
    updateFrom=$(docker exec "$containerID" cloudflared -v)
    echo -e "Updating $containerID from $updateFrom"
    docker exec $containerID cloudflared update
    updateTo=$(docker exec "$containerID" cloudflared -v)
    echo -e "Updated $containerID to $updateTo"
done

echo "Updating finished."