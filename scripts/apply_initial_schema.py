from yoyo import backends, migrations, read_migrations, get_backend

backend = get_backend("postgres://yehchenchen:850423@127.0.0.1/instdb")
migrations = read_migrations('./migrations')
backend.apply_migrations(backend.to_apply(migrations))