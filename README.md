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

#Introduction
Initially we need to dumb the large set of data. So, we will
make use of stack exchange, the platform where anyone can
post any queries from any field and the people who know the
answer can post them at this site. The data is available in:
https://data.stackexchange.com/stackoverflow/query/new. SQL
queries which are required to fetch the top 200,000 top scored
posts are executed in the stackexchange and all posts will have
similar Database Schema in the website.

#A. Download file from StackExchnage
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
