#!/usr/bin/env bash
SH=$(cd `dirname $BASH_SOURCE` && pwd)  # SH aka SCRIPT_HOME
source "$SH/.config.sh"

# load param :POSTGRES_DOCKER_REPO
    if [[ -z $POSTGRES_DOCKER_REPO ]];   then echo 'Undefined environment variable POSTGRES_DOCKER_REPO; please define one'; exit 1; fi

    POSTGRES_DOCKER_REPO=`cd $POSTGRES_DOCKER_REPO && pwd`
    if [[ ! -d $POSTGRES_DOCKER_REPO ]]; then echo 'Repo folder path not found at $POSTGRES_DOCKER_REPO'; exit 1; fi
    echo "POSTGRES_DOCKER_REPO=$POSTGRES_DOCKER_REPO"

echo '--> WIRE up a postgres instances ...'
    cd $POSTGRES_DOCKER_REPO;  export STACK_ID='postgres_11'; export CONTAINER_NAME=$PG_SERVER; ./docker/down.sh && ./docker/up.sh;  cd - 1>/dev/null
    cd $POSTGRES_DOCKER_REPO;  export STACK_ID='postgres_10'; export CONTAINER_NAME=$PG_CLIENT; ./docker/down.sh && ./docker/up.sh;  cd - 1>/dev/null

    # print result
    echo; docker ps | grep -E "$PG_CLIENT|$PG_SERVER" --color=always

#TODO Try to connect with the custom user+pass in 02.do-connect.sh
#PGPASSWORD=my_pg_pass psql -U my_pg_user -p 20410 -c 'select 1' -t
##          #pass              #user
