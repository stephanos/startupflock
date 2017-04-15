set -e

$(pwd)/scripts/build-docker.sh

docker run \
    --rm \
    --name run-server \
    -it \
    -p 8080:8080 \
    -v $(pwd):/app \
    stephanos/startupflock \
    /bin/bash -c "yarn start"