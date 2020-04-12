#!/usr/bin/env bash
SH=$(cd `dirname $BASH_SOURCE` && pwd)  # SH aka SCRIPT_HOME
source "$SH/.config.sh"
    if [[ -z $PG_SERVER ]];         then echo "Undefined environment variable PG_SERVER; please define one in $SH/.config.sh";         exit 1; fi
    if [[ -z $PG_CLIENT ]];         then echo "Undefined environment variable PG_CLIENT; please define one in $SH/.config.sh";         exit 1; fi
    if [[ -z $POSTGRES_PASSWORD ]]; then echo "Undefined environment variable POSTGRES_PASSWORD; please define one in $SH/.config.sh"; exit 1; fi
    if [[ -z $POSTGRES_USER ]];     then echo "Undefined environment variable POSTGRES_USER; please define one in $SH/.config.sh";     exit 1; fi
    if [[ -z $POSTGRES_DB ]];       then echo "Undefined environment variable POSTGRES_DB; please define one in $SH/.config.sh";       exit 1; fi

pg_server_port=`docker ps --format '{{.Names}} {{.Ports}}' | grep -E "$PG_SERVER" | cut -d' ' -f2 | cut -d'-' -f1 | cut -d':' -f2 `; echo "pg_server_port=$pg_server_port"
if [[ -z $pg_server_port ]]; then echo 'Something wrong; cannot get :pg_server port'; exit 1; fi

echo; echo '--> CHECK connection from pg_client to pg_server ... '
    docker exec -it $PG_CLIENT bash -c "
        PGPASSWORD=$POSTGRES_PASSWORD  psql -U $POSTGRES_USER -h $PG_SERVER -p 5432  $POSTGRES_DB -c \"select 'test psql $PG_CLIENT -> $POSTGRES_USER:$POSTGRES_PASSWORD@$PG_SERVER'; \" -t;
        #          #pass                    #user             #host         #port    #db          #query
        [[ \$? == 0 ]] && echo 'PASS' || echo 'FAIL'
    "

    #NOTE pg_client call to pg_server via port=5432
    #TODO pg_client call to pg_server via port=pg_server_port, how? hint:use network=host to act as host instead of same network with pg_server


echo; echo "--> CHECK connection from localhost's psql to pg_server ... "
    has_localhost_psql=`psql --version 1>/dev/null 2>&1; [[ $? == 0 ]] && echo 1 || echo 0`; echo "has_localhost_psql=$has_localhost_psql"
    if [[ $has_localhost_psql == 1 ]]; then
        PGPASSWORD=$POSTGRES_PASSWORD  psql -U $POSTGRES_USER -h localhost  -p $pg_server_port  $POSTGRES_DB  -c "select 'test psql $PG_CLIENT -> $POSTGRES_USER:$POSTGRES_PASSWORD@$PG_SERVER'; " -t
        #          #pass                    #user             #host         #port               #db           #query
        [[ $? == 0 ]] && echo 'PASS' || echo 'FAIL'

        # check for invalid user+pass
        echo
        PGPASSWORD="invalid_$POSTGRES_PASSWORD"  psql -U "invalid_$POSTGRES_USER" -h localhost  -p $pg_server_port  $POSTGRES_DB  -c "select 'test psql $PG_CLIENT -> $POSTGRES_USER:$POSTGRES_PASSWORD@$PG_SERVER'; " -t
        #          #pass                              #user                      #host         #port               #db           #query
        [[ $? != 0 ]] && echo 'PASS' || echo 'FAIL'
    fi


