echo "Are you shore to remove all containers and images? [y/n]"

read shore

if  [ $shore == y ]; then
    docker stop $(docker ps -a -q)
    docker rm $(docker ps -a -q)
    docker rmi $(docker images -q)
    exit 0
else
    exit 0
fi


