#!/usr/bin/env bash
export v='postgres_11'  # v aka version

echo '--> ENSURE we have postgres instance working'
    docker ps | grep -E "nn.+$v|IMAGE" --color=always; echo
    o='
    CONTAINER ID        IMAGE                COMMAND                  CREATED             STATUS              PORTS                     NAMES
    xxxxxxxxxxxx        postgres:10          "docker-entrypoint.s…"   28 minutes ago      Up 28 minutes       0.0.0.0:20410->5432/tcp   nn_postgres__postgres_10
    '

    # nail the :c :p of the instance; c aka container, p aka port
    export c=`docker ps --format '{{.Names}}' | grep -E "nn.+$v" | head -n1 `; echo $c  # c aka container
    export p=`docker ps --format '{{.Names}} {{.Ports}}' | grep -E "$c" | cut -d' ' -f2 | cut -d'-' -f1 | cut -d':' -f2 `; echo $p  # p aka port

    # nail the :user :pass of the instance
    usr=`docker exec -it $c bash -c 'echo $POSTGRES_USER' `     ; usr=${usr::-1}; echo "usr=$usr"  # remove LF as ending character ref. https://stackoverflow.com/a/27658733/248616
    psw=`docker exec -it $c bash -c 'echo $POSTGRES_PASSWORD' ` ; psw=${psw::-1}; echo "psw=$psw"  # remove LF as ending character ref. https://stackoverflow.com/a/27658733/248616


echo; echo "--> SUMMARY
    psql://$usr:$psw@$c:$p
    c=$c
    p=$p
    usr/psw=$usr/$psw
"
    printf 'Check if-responding port :p ... '
    echo 'QUIT' | nc -w 1 localhost $p && echo 'PASS' || echo 'FAIL'  # check responding port ref. https://gist.github.com/namgivu/414b71b4a4c894dcf01494f4f4c225d1
