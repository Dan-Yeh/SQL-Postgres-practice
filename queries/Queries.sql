/* select 3 users with highest ID */
SELECT *
FROM users
ORDER BY id DESC
LIMIT 3;
/* Join the users and posts table. Show the username of  user id 200 and captoions of all posts they have created*/
SELECT username, caption
FROM users 
JOIN posts ON posts.user_id = users.id
WHERE users.id = 200;
/*show each username nad the # of likes they created*/
SELECT username, COUNT(*)
FROM users
JOIN likes ON likes.user_id = users.id
GROUP BY users.id;