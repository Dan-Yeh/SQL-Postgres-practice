/* 
Never create indexes on primary key or column with Unique constaint
Because PostgreSQL create then automatically
*/
-- CREATE INDEX ON users (username);

-- DROP INDEX users_username_idx;

-- With index: 0.030ms
-- Without index: 0.789ms
EXPLAIN ANALYSE SELECT *
FROM users
WHERE username = 'Emil30';

-- 184kb for index
SELECT pg_size_pretty(pg_relation_size('users_username_idx'));
-- 872 kb for table
SELECT pg_size_pretty(pg_relation_size('users'));

-- inspect all indexes in pg
SELECT relname, relkind
FROM pg_class
WHERE relkind = 'i';
-- 'i' means index

-- take a look at data store on different pages
CREATE EXTENSION pageinspect;
-- inspect meta page
SELECT *
FROM bt_metap('users_username_idx');
-- inspect root node page
SELECT *
FROM bt_page_items('users_username_idx', 3);