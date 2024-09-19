1. Downloading data from https://edu.postgrespro.ru/mail_messages.sql.gz
2. Start the Postgres: <br>

``` bash
docker-compose -f docker-compose-pg.yml up -d
```

3. Load the archive with data into database: <br>

``` bash
zcat data/mail_messages.sql.gz | docker exec -i postgres_container psql -U postgres
```
