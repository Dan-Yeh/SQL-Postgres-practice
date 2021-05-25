# SQL-Postgres-practice
An instagram like database schema

![](dbio.png?raw=true)

## To play with
#### install packages
```
pip install -y psycopg2 yoyo-migrations
```
```
brew install postgresql
```
#### create database
```
psql -c "CREATE DATABASE instdb"
```
#### start the service
```
pg_start
```
#### setup connection config
```
echo "[local]
host=127.0.0.1
dbname=instdb
" >> ~/.pg_service.conf
```
### create schema
```python
python scripts/apply_initial_schema.py
```
### restore data
```
pg_restore -d instdb -v -a -1 --disable-triggers data.sql
```
## Have Fun !!!