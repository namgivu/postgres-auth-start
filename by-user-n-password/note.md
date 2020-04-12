Study how postgres authentication work.

Two postgres instances used here, i.e. :pg_client and :pg_server, will be created with docker as detailed [here](https://github.com/namgivu/postgres-docker)
Let's git clone that postgres-docker repo to the same folder we git clone this repo
NOTE that we use SAME DOCKER NETWORK for the two instance stacks so that from :pg_client we can connect to :pg_server

pg_xxx aka postgres_xxx

Expected instances info
```
container   stack id       port
---------   -----------    -----------------------
pg_server   postgres_10    0.0.0.0:20410->5432/tcp
pg_client   postgres_11    0.0.0.0:20411->5432/tcp
```

Create pg_xxx instances
```bash
POSTGRES_DOCKER_REPO=../../postgres-docker ./00.create-pg-instances.sh
```
