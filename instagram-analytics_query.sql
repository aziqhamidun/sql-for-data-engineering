-- updating the caption of post_id 3

SELECT * FROM posts;

UPDATE posts
SET caption = 'Best Pizza Ever'
WHERE post_id = 3;

-- selecting all the posts where user_id is 1

SELECT * FROM posts WHERE user_id = 1;

-- selecting all the posts and ordering them by created_at in descending order

SELECT * FROM posts
ORDER BY created_at DESC;

-- counting the number of likes for each post and
-- showing only the posts with more than and equal to 2 likes

SELECT p.post_id, COUNT(l.like_id)AS number_likes FROM posts AS p
JOIN likes AS l ON p.post_id = l.post_id
GROUP BY p.post_id
HAVING count(l.like_id) >= 2;

-- finding the total number of likes for all posts

SELECT SUM(number_likes) FROM(
SELECT p.post_id, COUNT(l.like_id)AS number_likes FROM posts AS p
JOIN likes AS l ON p.post_id = l.post_id
GROUP BY p.post_id) AS likes_by_post;

-- finding all the users who have commented on post_id 1

SELECT name FROM users WHERE user_id IN(
SELECT user_id FROM comments WHERE post_id = 1);

-- ranking the posts based on the number of likes

WITH cte AS (
SELECT p.post_id, COUNT(l.like_id)AS number_likes FROM posts AS p
JOIN likes AS l ON p.post_id = l.post_id
GROUP BY p.post_id
)
SELECT 
post_id,
number_likes,
RANK() OVER(ORDER BY number_likes DESC) AS rank_by_likes
FROM cte;

-- or using DENSE_RANK

WITH cte AS (
SELECT p.post_id, COUNT(l.like_id)AS number_likes FROM posts AS p
JOIN likes AS l ON p.post_id = l.post_id
GROUP BY p.post_id
)
SELECT 
post_id,
number_likes,
DENSE_RANK() OVER(ORDER BY number_likes DESC) AS rank_by_likes
FROM cte;

-- finding all the posts and their comments
-- using a Common Table Expression (CTE)

WITH cte AS(
SELECT p.post_id, p.caption, c.comment_text FROM posts AS p
LEFT JOIN comments AS c ON p.post_id = c.post_id
)
SELECT * FROM cte;

-- categorizing the posts based on the number of likes

WITH cte AS (
SELECT p.post_id, COUNT(l.like_id)AS number_likes FROM posts AS p
JOIN likes AS l ON p.post_id = l.post_id
GROUP BY p.post_id
)
SELECT 
post_id,
number_likes,
CASE WHEN number_likes < 2 THEN 'low_likes'
	 WHEN number_likes = 2 THEN 'few_likes'
	 WHEN number_likes > 2 THEN 'lot of likes'
	 ELSE 'no data' 
	 END AS like_category
FROM cte;