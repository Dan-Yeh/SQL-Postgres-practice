/* 
Query that gets executed only at very specific times
but hte results are saved and can be referenced without 
rerunning the query
*/

-- scenario: For each week, show the total number of likes that posts
-- and comments recieved. Use the post and comment created_at
-- date , not when the like was received

-- slow version
SELECT 
	date_trunc('week', COALESCE(posts.created_at, comments.created_at)) AS week, 
	COUNT(posts.id) AS num_likes_for_posts,
	COUNT(comments.id) AS num_likes_for_comments
FROM likes 
LEFT JOIN posts ON posts.id = likes.post_id
LEFT JOIN comments ON comments.id = likes.comment_id
GROUP BY week
ORDER BY week;

-- materialized view
CREATE MATERIALIZED VIEW weekly_likes AS (
SELECT 
	date_trunc('week', COALESCE(posts.created_at, comments.created_at)) AS week, 
	COUNT(posts.id) AS num_likes_for_posts,
	COUNT(comments.id) AS num_likes_for_comments
FROM likes 
LEFT JOIN posts ON posts.id = likes.post_id
LEFT JOIN comments ON comments.id = likes.comment_id
GROUP BY week
ORDER BY week
) WITH DATA;

SELECT * FROM weekly_likes;

-- change data
DELETE FROM posts
WHERE created_at < '2010-02-01';

-- we need to refresh the view if we change the data
REFRESH MATERIALIZED VIEW weekly_likes;