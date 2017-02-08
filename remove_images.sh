echo "Are you shore to remove all containers and images? [y/n]"

read shore

if  [ $shore == y ]; then
    docker stop $(docker ps -a -q)
    docker rm -f $(docker ps -a -q)
    docker rmi -f $(docker images -q)
    exit 0
else
    exit 0
fi


