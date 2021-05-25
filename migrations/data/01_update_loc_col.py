#
# file: migratios/data/01_update_loc_col.py
#
from yoyo import step

__depends__ = {"0000_initial_schema", "0001_add_loc_col_to_posts"}

steps = [
    step(
        "UPDATE posts\
        SET loc=POINT(lng, lat)\
        WHERE loc=NULL;",
    )
]