# CloudTechAssignment1
TASK
1. Acquire the top 200,000 posts by viewcount.
2. Using Pig or MapReduce, extract, transform and load the
data as applicable
3. Using Hive and/or MapReduce, get:
i. The top 10 posts by score
ii. The top 10 users by post score
iii. The number of distinct users, who used the word hadoop
in one of their posts
4. Using Mapreduce/Pig/Hive calculate the per-user TF-IDF
(just submit the top 10 terms for each of the top 10 users
from Query 3.II)

# I. Introduction
Initially we need to dumb the large set of data. So, we will
make use of stack exchange, the platform where anyone can
post any queries from any field and the people who know the
answer can post them at this site. The data is available in:
https://data.stackexchange.com/stackoverflow/query/new. SQL
queries which are required to fetch the top 200,000 top scored
posts are executed in the stackexchange and all posts will have
similar Database Schema in the website.

# A. Download file from StackExchnage
On StackExchange, we can only dump 50K posts, since
the website allows only a download of 50K records at the
single instance. So, the below SQL query is executed to fetch
the 50K records:

SELECT top 50000 *
FROM posts WHERE posts.ViewCount <9000000
ORDER BY posts.ViewCount DESC;

The above SQL query will be executed 3 more times to
capture 200,000 posts. While querying after the first time, the
value of last ViewCount should be filtered and passed to the
successive query like below:

SELECT top 50000 *
FROM posts WHERE posts.ViewCount <lastValue
ORDER BY posts.ViewCount DESC;

# B. Task2:ETL and PIG
The Body column looks inconsistent and fishy. The special
characters and ‘’ character is removed from each file and a
new cleaned file are generated (Refer to Process.py).

Now, we should create a single file which contains all
200,000 posts by appending all posts to the single file.
When each file is dumped there is a header of schema and
each value are separated by “,”. All files are merged into
cleanedFirstResult.csv (File size: 202MB).
Copy the file from local system to hdfs path before processing
it with pig.
grunt>copyFromLocal cleaned FirstResult.csv \FinalFile

# II. PIG PROCESS
The file “MainPig.pig” was executed in map-reduce
mode: (Refer to MainPig.pig). “pig x mapred MainPig.pig”.
Here I have used CSVLoader, function which is available in
PiggyBank and then it is dumped and stored in HDFS path
\HiveFile

So now, we will be able to see 2 files divided by Pig in hdfs
and a log file. The log file can be deleted.
Now copy the files from HDFS to local sub directory and
merge the file. grunt>copyToLocal hdfs local

# III. TASK 3: HIVE AND QUERY
Table is created before executing the Hive queries:


# A. Query1: The top 10 posts by score
Id, Title and score are selected from assignment1table
sorted out by Score for the top 10 users.

SELECT id, title, score
FROM assignment1table
ORDER BY score DESC LIMIT 10;


# B. Query2: The top 10 users by post score
Id, owneruserid and score are selected from
assignment1table sorted out by Score for the top 10
users.

SELECT Id,Score, Owneruserid
FROM assignment1table
SORT BY Score
DESC LIMIT 10;

# C. Query3: The number of distinct users, who used the word
hadoop in one of their posts
For this query all distinct users who used the word
“Hadoop” in title of their post are fetched.

SELECT COUNT(DISTINCT owneruserid)
FROM assignment1table
WHERE Tags like ’%Hadoop%’;

IV. TASK 4: TF-IDF USING HIVE/MAPRREDUCE/PIG
For the task4, top 10 users’ details are stored in a table
stacktopusers. The table schema Title and tags are used in a
table topuserpost by using Owner’s ID from stackTopUser table. Then this table is stored in HDFS and later queried to
by selecting owner’s ID, Title from toppost table. Refer to
Task4.sql file in attachment.

SELECT OwnerUserId, Title
FROM TopUserPosts
GROUP BY OwnerUserId, Title;

# V. TASK ACHIEVED
Platform:
Google Cloud platform is used to achieve this task by
creating the clusters from DataProc and running it from the
VM instances from compute engine. Once the tasks are end
the clusters are stopped.
Languages used:
Pig and Python is used for Data processing and cleaning.
Most of the major works are done in Pig language in
MapReduce mode.
Queries are executed in Hive
Files are transferred to hdfs through Pig Grunt console.
