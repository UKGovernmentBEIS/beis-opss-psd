FROM postgres:11

WORKDIR /docker-entrypoint-initdb.d

# Adds configuration to the postgres server to allow pgHero to see query stats
COPY setup-pgHero.sh .
