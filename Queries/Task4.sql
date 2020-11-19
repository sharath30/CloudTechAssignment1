-- Store top users in a separate table called TopUsersTable:

CREATE TABLE TopUsersTable
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',' AS
SELECT OwnerUserId, SUM(Score) AS TotalScore
FROM assignment1table
GROUP BY OwnerUserId
ORDER BY TotalScore DESC LIMIT 10;

-- Fetch tag and title of the users in TopUsersTable and store it in a separate table called TopUserPosts

CREATE TABLE TopUserPosts AS
SELECT OwnerUserId, Title, Tags
FROM assignment1table
WHERE OwnerUserId in (SELECT OwnerUserId FROM TopUsersTable)
GROUP BY OwnerUserId, Body, Title, Tags;

-- Store the TopUserPosts results into an HDFS directory

INSERT OVERWRITE DIRECTORY '/HiveFile'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

-- Fetch the data from TopUserPosts

SELECT OwnerUserId, Title
FROM TopUserPosts
GROUP BY OwnerUserId, Title;