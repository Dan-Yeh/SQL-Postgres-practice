
#
# file: migratios/data/01_update_loc_col.py
#
from yoyo import step

__depends__ = {"0000_initial_schema", "0001_add_loc_col_to_posts"}

steps = [
    step(
        "ALTER TABLE posts\
        DROP COLUMN lat,\
        DROP COLUMN lnt;",
        "ALTER TABLE posts\
        ADD COLUMN lat numeric,\
        ADD COLUMN lng numeric;"
    )
]