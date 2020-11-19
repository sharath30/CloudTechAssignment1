-- Create Table

create table Assignment1Table(Id int, Score int, Body String, OwnerUserId Int, Title String, Tags String) 
row format delimited 
FIELDS TERMINATED BY ',';

--load the dataset
hive> load data local inpath 'Query.csv' overwrite into table Assignment1Table;

--Query 1: The top 10 posts by score
SELECT id, title, score 
FROM Assignment1Table
ORDER BY score DESC LIMIT 10;

--Query 2: The top 10 users by post score
SELECT Id,Score, Owneruserid
FROM assignment1table
SORT BY Score
DESC LIMIT 10;

--Query 3: The number of distinct users, who used the word 'hadoop' in one of their posts
SELECT COUNT(DISTINCT owneruserid)
FROM assignment1table
WHERE Tags like ’%Hadoop%’;