# info 0th
Study how postgres authentication work.

Two postgres instances used here will be created with docker as detailed [here](https://github.com/namgivu/postgres-docker)
NOTE that we use SAME DOCKER NETWORK for the two stack

command to create
```bash
: /path/to/git-cloned/for/namgivu/postgres-docker
export NETWORK_NAME='docker_network__test_postgres_auth'; 
    export STACK_ID='postgres_11'; ./docker/down.sh && ./docker/up.sh; 
    export STACK_ID='postgres_10'; ./docker/down.sh && ./docker/up.sh;
```

outcome
```
instance    container                   port
---------   ------------------------    -----------------------
pg_server   nn_postgres__postgres_10    0.0.0.0:20410->5432/tcp
pg_client   nn_postgres__postgres_11    0.0.0.0:20411->5432/tcp

pg xxx aka postgres xxx
```
 
 
# `00` prepare postgres server instance aka pg_server
version postgres:11
commands ref. `00.postgres-server.sh`
we should have 
```
--> SUMMARY
    psql://postgres:postgres@nn_postgres__postgres_11:20411
    c=nn_postgres__postgres_11
    p=20411
    usr/psw=postgres/postgres

Check if-responding port :p ... PASS
```


# `01` prepare postgres client, aka pg_client, to get authenticated against `pg_server`
version postgres:10
command ref. `01.postgres-client.sh`
we should have 
```
--> ENSURE we have postgres instance working
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                     NAMES
8b5a765b7c9b        postgres:10         "docker-entrypoint.s…"   16 minutes ago      Up 16 minutes       0.0.0.0:20410->5432/tcp   nn_postgres__postgres_10

nn_postgres__postgres_10

--> CHECK psql version
psql (PostgreSQL) 10.12 (Debian 10.12-2.pgdg90+1)
PASS
```

 
# `02` connect psql pg_client -> pg_server
commands ref. `02.do-connect.sh`
