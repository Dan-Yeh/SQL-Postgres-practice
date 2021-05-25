EXPLAIN ANALYSE SELECT username, contents
FROM users
JOIN comments ON comments.user_id = users.id
WHERE username = 'Alyson14';

-- "Hash Join  (cost=8.31..1756.11 rows=11 width=81) (actual time=0.099..14.969 rows=7 loops=1)"
-- "  Hash Cond: (comments.user_id = users.id)"
-- "  ->  Seq Scan on comments  (cost=0.00..1589.10 rows=60410 width=72) (actual time=0.014..5.984 rows=60410 loops=1)"
-- "  ->  Hash  (cost=8.30..8.30 rows=1 width=17) (actual time=0.011..0.012 rows=1 loops=1)"
-- "        Buckets: 1024  Batches: 1  Memory Usage: 9kB"
-- "        ->  Index Scan using users_username_idx2 on users  (cost=0.28..8.30 rows=1 width=17) (actual time=0.008..0.009 rows=1 loops=1)"
-- "              Index Cond: ((username)::text = 'Alyson14'::text)"
-- "Planning Time: 0.186 ms"
-- "Execution Time: 14.996 ms"

-- statistics from pg_stats
SELECT *
FROM pg_stats
WHERE tablename = 'users';