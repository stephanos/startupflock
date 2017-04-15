set -e

docker build \
    -f Dockerfile . \
    -t stephanos/startupflock

docker run --rm --entrypoint cat stephanos/startupflock /opt/yarn.lock > /tmp/yarn.lock
if ! diff -q yarn.lock /tmp/yarn.lock > /dev/null 2>&1; then
  echo "there is a new yarn.lock"
  cp /tmp/yarn.lock yarn.lock
fi