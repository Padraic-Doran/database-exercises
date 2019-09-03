show databases;
-- mysql.user means use the mysql database and read from the user table
select * from mysql.user;

-- selecting user and host columns from the user table 
select user, host from mysql.user;

SELECT * FROM mysql.help_topic;

SELECT help_topic_id, help_category_id, url FROM mysql.help_topic;