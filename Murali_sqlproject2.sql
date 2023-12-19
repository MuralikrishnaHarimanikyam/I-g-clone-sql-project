#1)Create an ER diagram or draw a schema for the given database.
-- ER model stands for an Entity-Relationship model. It is a high-level data model
-- This model is used to define the data elements and relationship for a specified system.
-- It develops a conceptual design for the database. It also develops a very simple and easy to design view of data.
-- In ER modeling, the database structure is portrayed as a diagram called an entity-relationship diagram.
-- This er diagram i have uploaded a separate file in it
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#2)We want to reward the user who has been around the longest, Find the 5 oldest users.
select * from users;                                                                         -- I USE USERS TABLE
select * from users
order by created_at asc                                                                      -- SORT THE CREATEDAT ASC
limit 5;                                                                                     -- USE LIMIT 5 TO GIVE 5 RECORDS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#3)To target inactive users in an email ad campaign, find the users who have never posted a photo.
select * from users;                                                                       -- I USE USERS AND PHOTOS TABLE
select * from photos;
select * from users 
where id not in (select  user_id from photos);                                             -- USE WHERE CLAUSE TO FILTER NOT IN PARTICULAR RECORDS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#4)Suppose you are running a contest to find out who got the most likes on a photo. Find out who won?
select * from photos;                                                               -- I USE PHOTOS AND LIKES TABLE
select * from likes;
select p.user_id,p.image_url,count(*) as num_likes from photos as p                 -- COUNT ALIAS AS NUM_LIKES USING AGGREGATION
inner join likes as l on p.user_id=l.user_id                                        -- USING JOIN BETWEEN TWO TABLES
group by p.image_url,p.user_id                                                      -- USING GROUP BY CLAUSE
order by num_likes desc                                                             -- USING TO SORT THE ORDER IN DESC
limit 1;                                                                            -- USING LIMIT FUNCTION

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#5)The investors want to know how many times does the average user post.
select * from photos;                                                                    -- USE PHOTOS TABLE
with post as                                                                             -- I USE CTE BY USING WITH FUNCTION
(select count(*) as num_posts from photos group by user_id)                              -- USE COUNT FUNCTION AND GROUP BY CLAUSE 
select  avg(num_posts) as avg_post  from post;                                           -- USE AGGREGATE FUNCTION
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
#6)A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags.
select * from photo_tags;                                                               -- USE PHOTOTAGS TABLE                                       
select tag_id,count(photo_id) as no_of_count from photo_tags                            -- USE COUNT ALIAS AS NO_OF_COUNT
group by tag_id                                                                         -- USE GROUP BY CLAUSE
order by no_of_count desc                                                               -- TO SORT IN DESC ORDER
limit 5;                                                                                -- USE LIMIT 5 TO 5 RECORDS
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------
#7)To find out if there are bots, find users who have liked every single photo on the site.
select  * from likes;                                                                     -- I USE LIKES AND PHOTOS TABLE
select *  from photos;
with like_counts as                                                                       -- I USE CTE BY USING WITH FUNCTION ALIAS AS LIKECOUNTS
(select user_id,count(*) as num_likes from likes group by user_id)                        -- TAKE USERID AND COUNTFUNCTION AND GROUPBY CLAUSE
select user_id,num_likes  from like_counts                                               
where num_likes=(select  count(*) from photos);                                           -- USE WHERE CONDITION 
 
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#8)Find the users who have created instagramid in may and select top 5 newest joinees from it?
select * from users;                                                                      -- I USE USERS TABLE
select * from users
where month(created_at)=5                                                                 -- USE WHERE CLAUSE
order by created_at desc                                                                  -- USE ORDER BY CLAUSE TO SORT DESC
limit 5;                                                                                  -- USE LIMIT 5 FOR 5 RECORDS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#9)Can you help me find the users whose name starts with c and ends with any number and have posted the photos as well as liked the photos?
select * from users;                                                                -- I USE THREE TABLES ARE                         
select * from photos;                                                               -- USERS,PHOTOS AND LIKES TABLE                                     
select * from likes;
-- BY USING VIEWS 
create view liked_postphoto as(                                                     -- I CREATE VIEW TABLENAME AS LIKEDPOSTPHOTO
select l.User_id, u.username, p.image_url from photos as p 
join likes as l on p.user_id=l.user_id                                              -- USE JOIN CONDITION
join users as u on p.id=u.id);

select user_id, username, image_url, count(*) as num_likes from liked_postphoto     -- USING COUNT ALIAS AS LIKE
group by User_id, username                                                          -- uUSE GROUP BY CLAUSE
having username like 'c%';                                                          -- USE HAVING CLAUSE
 --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#10)Demonstrate the top 30 usernames to the company who have posted photos in the range of 3 to 5.
select * from users;                                                                 -- I TAKE USERS AND PHOTOS TABLE
select * from photos;
select u.id,u.username, count(u.username) as no_of_posts                             -- USE COUNT AND ALIAS AS NO_OF_POSTS
from users u inner join photos p                                                     -- USE INNER JOIN 
on u.id=p.user_id group by u.id                                                      -- USE GROUP BY CLAUSE             
having no_of_posts between 3 and 5                                                   -- HAVING CLAUSE TO FILTER 3 AND 5 RECORDS
order by id  desc  limit 30;                                                         -- USE ORDER BY IN ASCENDING FORM AND APPLY LIMIT IN IT

