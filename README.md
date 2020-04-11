# info 0th
Study how postgres authentication work.

Two postgres instances used here will be created with docker as detailed [here](https://github.com/namgivu/postgres-docker)
instance    container                   port
---------   ------------------------    -----------------------
pg server   nn_postgres__postgres_10    0.0.0.0:20410->5432/tcp
pg client   nn_postgres__postgres_11    0.0.0.0:20411->5432/tcp

pg xxx aka postgres xxx
 
 
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
