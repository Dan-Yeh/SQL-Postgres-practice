#
# file: migratios/0001_add_loc_col_to_posts.py
#
from yoyo import step

__depends__ = {"0000_initial_schema"}

steps = [
    step(
        "ALTER TABLE posts\
        ADD COLUMN loc POINT;",
        "ALTER TABLE posts\
        DROP COLUMN loc;",
    )
]