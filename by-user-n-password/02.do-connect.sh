#!/usr/bin/env bash
SH=$(cd `dirname $BASH_SOURCE` && pwd)  # SH aka SCRIPT_HOME
source "$SH/.config.sh"
    if [[ -z $PG_SERVER ]];         then echo "Undefined environment variable PG_SERVER; please define one in $SH/.config.sh";         exit 1; fi
    if [[ -z $PG_CLIENT ]];         then echo "Undefined environment variable PG_CLIENT; please define one in $SH/.config.sh";         exit 1; fi
    if [[ -z $POSTGRES_PASSWORD ]]; then echo "Undefined environment variable POSTGRES_PASSWORD; please define one in $SH/.config.sh"; exit 1; fi
    if [[ -z $POSTGRES_USER ]];     then echo "Undefined environment variable POSTGRES_USER; please define one in $SH/.config.sh";     exit 1; fi

pg_server_port=`docker ps --format '{{.Names}} {{.Ports}}' | grep -E "$PG_SERVER" | cut -d' ' -f2 | cut -d'-' -f1 | cut -d':' -f2 `; echo "pg_server_port=$pg_server_port"

echo; echo '--> CHECK connection from pg_client to pg_server ... '
docker exec -it $PG_CLIENT bash -c "
    PGPASSWORD=$POSTGRES_PASSWORD  psql -U $POSTGRES_USER -h $PG_SERVER -p 5432  -c \"select 'test psql $PG_CLIENT -> $POSTGRES_USER:$POSTGRES_PASSWORD@$PG_SERVER'; \" -t;
    #          #pass                    #user             #host         #port    #query
    [[ \$? == 0 ]] && echo 'PASS' || echo 'FAIL'
"
