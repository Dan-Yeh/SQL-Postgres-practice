SELECT users.username, tags.created_at
FROM users
JOIN (
	SELECT user_id, created_at FROM caption_tags
	UNION ALL
	SELECT user_id, created_at FROM photo_tags
) AS tags ON tags.user_id = users.id
WHERE tags.created_at < '2010-01-07';

-- simple common table expression same stuff but more readable
WITH tags AS (
	SELECT user_id, created_at FROM caption_tags
	UNION ALL
	SELECT user_id, created_at FROM photo_tags
)
SELECT users.username, tags.created_at
FROM users
JOIN tags ON tags.user_id = users.id
WHERE tags.created_at < '2010-01-07';

-- recursive common table expression
-- who you should follow
WITH RECURSIVE suggestions(leader_id, follower_id, depth) AS (
	SELECT leader_id, follower_id, 1 AS depth
	FROM followers
	WHERE followers.id = 1000
	UNION
	SELECT followers.leader_id, followers.follower_id, depth + 1 
	FROM followers
	JOIN suggestions ON suggestions.leader_id = followers.follower_id
	WHERE depth < 3
)

SELECT DISTINCT users.id, users.username
FROM suggestions
JOIN users ON users.id = suggestions.leader_id
WHERE depth > 1
LIMIT 30;