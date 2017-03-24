#!/bin/bash
NETWORK_PEER="hyperledger"
NPM_SCRIPT="start"

printf "###################################################\n"
printf "#####     HYPERLEDGER FABRIC SETUP SCRIPT     #####\n"
printf "###################################################\n\n"

clear_all() {
  docker rm -f $(docker ps -a -q) 2>/dev/null
  printf "All docker containers removed\n"
  docker rmi -f `docker images | grep $NETWORK_PEER | awk '{print $3}'` 2>/dev/null
#  docker rmi -f $(docker images -q) 2>/dev/null 
  printf "All images removed\n"
  docker rmi $(docker images -qf "dangling=true") 2>/dev/null
  printf "All untagged images removed\n"
# Delete all containers
#docker rm $(docker ps -a -q)
# Delete all images
##docker rmi $(docker images -q)
}

ask() {
  local response
  local msg="${1:-$1} [y/N] "; shift
  read -r $4 -p "$msg" response || echo
  case "$response" in
    [yY][eE][sS]|[yY]) $1 ;;
    *) $2 ;;
  esac
}

ask "Do you want to clear the environment?" clear_all return

docker pull hyperledger/fabric-peer:x86_64-0.6.1-preview
docker pull hyperledger/fabric-membersrvc:x86_64-0.6.1-preview
docker pull hyperledger/fabric-baseimage:x86_64-0.2.1
docker tag hyperledger/fabric-baseimage:x86_64-0.2.1 hyperledger/fabric-baseimage:latest
docker images

git clone https://github.com/NationalAssociationOfRealtors/EngagementOnChain.git
cd EngagementOnChain
npm install

# run docker-compose
docker-compose up -d 2>/dev/null
printf "Starting docker containers...\n"
sleep 10
printf "Docker containers up and running\n"
printf "Hit ctrl+c to stop\n"

# start server, catch ctrl+c to clean up
trap 'kill -TERM "$PID" 2>/dev/null' SIGINT
npm run $NPM_SCRIPT &
PID=$!
wait $PID

exit 0

