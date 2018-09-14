-- Reading relationship information in a table format can be difficult, whiteboarding the the relationship model in UML/ERD format is ~~highly recommended~~ required.

-- ## Queries across multiple tables

-- Write the following SQL statements in `joins.sql`

-- 1. Create a query to get all fields from the `users` table
SELECT * FROM users;
-- 371 ms

-- 1. Create a query to get all fields from the `posts` table where the `user_id` is 100
SELECT * FROM posts WHERE postsusersid = 100;
-- 24 ms

-- 1. Create a query to get all posts fields, the user's first name, and the user's last name, from the `posts` table where the user's id is 200
SELECT 
    posts.*, 
    users.first_name, 
    users.last_name, 
    users.id 
FROM posts 
LEFT OUTER JOIN users 
ON posts.postsusersid = posts.id 
WHERE users.id = 200;
-- 21 ms

-- 1. Create a query to get all posts fields, and the user's username, from the `posts` table where the user's first name is 'Norene' and the user's last_name is 'Schmitt'
SELECT 
    posts.*, 
    users.username 
FROM posts 
LEFT OUTER JOIN users 
ON posts.postsusersid = users.id 
WHERE users.first_name = 'Norene' 
AND users.last_name = 'Schmitt';
-- 28 ms

-- 1. Create a query to get usernames from the `users` table where the user has created a post after January 1, 2015
SELECT username 
FROM users 
LEFT JOIN posts 
ON posts.postsusersid = users.id 
WHERE posts.created_at > '2015-01-01';
-- 159 ms

-- 1. Create a query to get the post title, post content, and user's username where the user who created the post joined before January 1, 2015
SELECT 
    posts.title, 
    posts.content, 
    users.username 
FROM posts 
LEFT JOIN users 
ON posts.postsusersid = users.id 
WHERE users.created_at < '2015-01-01';
-- 295 ms

-- 1. Create a query to get the all rows in the `comments` table, showing post title (aliased as 'Post Title'), and the all the comment's fields
SELECT 
    comments.*, 
    posts.title AS "Post Title"
FROM comments 
LEFT JOIN posts 
ON comments.commentspostsid = posts.id;
-- 239 ms

-- 1. Create a query to get the all rows in the `comments` table, showing post title (aliased as post_title), post url (ailased as post_url), and the comment body (aliased as comment_body) where the post was created before January 1, 2015
SELECT 
    comments.*, 
    posts.title AS "post_title", 
    posts.url AS "post_url", 
    comments.body AS "comment_body" 
FROM comments 
LEFT JOIN posts 
ON comments.commentspostsid = posts.id 
WHERE posts.created_at < '2015-01-01';
-- 141 ms

-- 1. Create a query to get the all rows in the `comments` table, showing post title (aliased as post_title), post url (ailased as post_url), and the comment body (aliased as comment_body) where the post was created after January 1, 2015
SELECT 
    comments.*, 
    posts.title AS "post_title", 
    posts.url AS "post_url", 
    comments.body AS "comment_body"
FROM comments 
LEFT JOIN posts 
ON comments.commentspostsid = posts.id 
WHERE posts.created_at > '2015-01-01';

-- 1. Create a query to get the all rows in the `comments` table, showing post title (aliased as post_title), post url (ailased as post_url), and the comment body (aliased as comment_body) where the comment body contains the word 'USB'
SELECT 
    comments.*, 
    posts.title AS post_title, 
    posts.url AS post_url, 
    comments.body AS comment_body 
FROM comments 
LEFT JOIN posts 
ON comments.commentspostsid = posts.id 
WHERE comments.body 
LIKE '%USB%';
-- 36 ms

-- 1. Create a query to get the post title (aliased as post_title), first name of the author of the post, last name of the author of the post, and comment body (aliased to comment_body), where the comment body contains the word 'matrix' ( should have 855 results )
SELECT 
    posts.title AS "post_title", 
    users.first_name, 
    users.last_name, 
    comments.body AS "comment_body" 
FROM comments 
LEFT JOIN posts 
ON comments.commentspostsid = posts.id 
LEFT JOIN users
ON comments.commentsusersid = users.id
WHERE comments.body LIKE '%matrix%';
-- 41 ms

-- 1. Create a query to get the first name of the author of the comment, last name of the author of the comment, and comment body (aliased to comment_body), where the comment body contains the word 'SSL' and the post content contains the word 'dolorum' ( should have 102 results )
SELECT 
    users.first_name, 
    users.last_name, 
    comments.body AS "comment_body"
FROM comments
LEFT JOIN users
ON comments.commentsusersid = users.id
LEFT JOIN posts
ON comments.commentspostsid = posts.id
WHERE comments.body LIKE '%SSL%'
AND posts.content LIKE '%dolorum%'; 
-- 349 ms

-- 1. Create a query to get the first name of the author of the post (aliased to post_author_first_name), last name of the author of the post (aliased to post_author_last_name), the post title (aliased to post_title), username of the author of the comment (aliased to comment_author_username), and comment body (aliased to comment_body), 
-- where the comment body contains the word 'SSL' or 'firewall' and the post content contains the word 'nemo' ( should have 218 results )
SELECT 
    users.first_name AS "post_author_first_name", 
    users.last_name AS "post_author_last_name", 
    posts.title AS "post_title", 
    users.username AS "comment_author_username", 
    comments.body AS "comment_body"
FROM comments
LEFT JOIN users
ON comments.commentsusersid = users.id
LEFT JOIN posts
ON comments.commentspostsid = posts.id
WHERE comments.body 
LIKE '%SSL%' 
AND posts.content 
LIKE '%nemo%'  
OR comments.body 
LIKE '%firewall%' 
AND posts.content 
LIKE '%nemo%';
-- 165 ms

-- ### Additional Queries

-- If you finish early, perform and record the following SQL statements in `joins.sql` using these higher level requirements.

-- 1. Count how many comments have been written on posts that have been created after July 14, 2015 ( should have one result, the value of the count should be 27)
SELECT COUNT(*) 
FROM comments 
LEFT JOIN posts 
ON comments.commentspostsid = posts.id 
WHERE posts.created_at > '2015-07-14';
-- 25 ms

-- 1. Find all users who comment about 'programming' ( should have 337 results)
SELECT users.username AS "users"
FROM comments 
LEFT JOIN users 
ON comments.commentsusersid = users.id 
WHERE comments.body 
LIKE '%programming%';
-- 22 ms
