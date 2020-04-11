#!/usr/bin/env bash
export v='postgres_10'  # v aka version

echo '--> ENSURE we have postgres instance working'
    docker ps | grep -E "nn.+$v|IMAGE" --color=always; echo
    o='
    CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                     NAMES
    xxxxxxxxxxxx        postgres:10         "docker-entrypoint.s…"   17 minutes ago      Up 17 minutes       0.0.0.0:20410->5432/tcp   nn_postgres__postgres_10
    '

    # nail the :c the instance; c aka container
    export c=`docker ps --format '{{.Names}}' | grep -E "nn.+$v" | head -n1 `; echo $c  # c aka container

echo; echo '--> CHECK psql version'
    docker exec -it $c bash -c "psql --version"
    [[ $? == 0 ]] && echo 'PASS' || echo 'FAIL'
