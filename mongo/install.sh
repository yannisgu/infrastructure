if [ ! -x "./envsubst" ]; then
    sudo curl -L https://github.com/a8m/envsubst/releases/download/v1.2.0/envsubst-`uname -s`-`uname -m` -o ./envsubst
    sudo chmod +x ./envsubst
fi
if [ -f .env ]; then
    echo ".env file not found."
    exit 1
fi

set -a && source .env && set +a
docker network create $DOCKER_NETWORK --driver overlay
./envsubst < docker-compose-template.yml | docker stack deploy -c - coollabs-mongodb