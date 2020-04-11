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
pg server   nn_postgres__postgres_10    0.0.0.0:20410->5432/tcp
pg client   nn_postgres__postgres_11    0.0.0.0:20411->5432/tcp

pg xxx aka postgres xxx
```
 
 
# `00` prepare postgres server instance aka pg server
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


# `01` prepare postgres client, aka pg client, to get authenticated against `pg server`
version postgres:10
command ref. `01.postgres-client.sh`
