SELECT username, COUNT(*)
FROM users
JOIN (
	SELECT user_id FROM photo_tags
	UNION ALL
	SELECT user_id FROM caption_tags
) AS tags ON tags.user_id = users.id
GROUP BY users.username
ORDER BY COUNT(*) DESC;

-- we use JOIN too much, should we redesign tables or ?
-- create view ! fake tables have ref to other tables in db
-- but gets executed every time we refer to views

CREATE VIEW tags AS (
	SELECT id, created_at, user_id, post_id, 'photo_tag' AS type FROM photo_tags
	UNION ALL
	SELECT id, created_at, user_id, post_id, 'caption_tag' AS type FROM photo_tags
);

-- query above become
SELECT username, COUNT(*)
FROM users
JOIN tags ON tags.user_id = users.id
GROUP BY users.username
ORDER BY COUNT(*) DESC;

-- scenario: ten most recent posts
CREATE VIEW recent_posts AS (
	SELECT *
	FROM posts
	ORDER BY created_at DESC
	LIMIT 10
);

-- users created the posts
SELECT username
FROM recent_posts
JOIN users ON users.id = recent_posts.user_id;

-- replace the view
CREATE OR REPLACE VIEW recent_posts AS (
	SELECT * 
	FROM posts
	ORDER BY created_at DESC
	LIMIT 15
);

-- delete the view
-- DROP VIEW recent_posts;