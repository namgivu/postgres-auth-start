Study how postgres authentication work.
 
`00` Prepare postgres server instance ref. `00.postgres-server.sh`
**TODO** `01` Prepare postgres client to get authenticated against `00` ref. `01.postgres-client.sh`


# Prepare postgres server
Postgres instance created with docker as detailed [here](https://github.com/namgivu/postgres-docker)
Starting with PostgreSQL 10 


**TODO**
printf 'Check if-working psql instance ... '
psql -U postgres -h localhost -p $p -c 'select 1' -t && echo 'PASS' || echo 'FAIL'
