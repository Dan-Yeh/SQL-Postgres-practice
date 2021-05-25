#
# rollback last migration
#
from yoyo import read_migrations, get_backend

backend = get_backend("postgres://yehchenchen:850423@127.0.0.1/instdb")
migrations = read_migrations('./migrations')
backend.rollback_one(migrations[-1])