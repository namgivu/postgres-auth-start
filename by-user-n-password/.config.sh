#!/usr/bin/env bash

# common for two instances
    export      NETWORK_NAME='docker_network__tpa'  # tpa aka test_postgres_auth
    export     POSTGRES_USER='tpa_user'
    export POSTGRES_PASSWORD='tpa_pass'
    export       POSTGRES_DB='tpa_db'

# pg_xxx instance
    export PG_SERVER='pg_server'
    export PG_CLIENT='pg_client'
