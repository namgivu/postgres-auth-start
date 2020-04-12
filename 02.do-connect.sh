#!/usr/bin/env bash

pg_server='nn_postgres__postgres_10'
pg_client='nn_postgres__postgres_11'

echo; echo '--> Load pg_server connection info ... '
      c=$pg_server  # c aka container
      #p=`docker ps --format '{{.Names}} {{.Ports}}' | grep -E "$c" | cut -d' ' -f2 | cut -d'-' -f1 | cut -d':' -f2 `; echo $p  # p aka port
    usr=`docker exec -it $c bash -c 'echo $POSTGRES_USER' `     ; usr=${usr::-1}; echo "usr=$usr"  # remove LF as ending character ref. https://stackoverflow.com/a/27658733/248616
    psw=`docker exec -it $c bash -c 'echo $POSTGRES_PASSWORD' ` ; psw=${psw::-1}; echo "psw=$psw"  # remove LF as ending character ref. https://stackoverflow.com/a/27658733/248616

echo; echo '--> CHECK connection from pg_client to pg_server ... '
docker exec -it $pg_client bash -c "
    PGPASSWORD=$psw  psql -U $usr -h $pg_server -c \"select 'test psql $pg_client -> $usr:$psw@$pg_server'; \" -t;
    [[ $? == 0 ]] && echo 'PASS' || echo 'FAIL'
"
