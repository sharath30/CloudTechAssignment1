
-- pig file to further process the data and store to hdfs

--piggy bank jar package will already be avilable in dataproc location 
REGISTER '/usr/local/share/google/dataproc/dataproc-agent.jar'

DEFINE CSVLoader
org.apache.pig.piggybank.storage.CSVLoader();

-- load the data from /project1
A = LOAD '/project1' USING CSVLoader(',') AS
(Id:int, PostTypeId:int, AcceptedAnswerId:int,
ParentId:int, CreationDate:datetime,
DeletionDate:datetime, Score:int,
ViewCount:int, Body:chararray, OwnerUserId:int,
OwnerDisplayName:chararray, LastEditorUserId:int,
LastEditorDisplayName: chararray,
LastEditDate:datetime, LastActivityDate:datetime,
Title:chararray, Tags:chararray, AnswerCount:int,
CommentCount:int, FavoriteCount:int,
ClosedDate:chararray);

-- keep Id, PostTypeId, OwnerUserId and title for the further operation
B = FOREACH A GENERATE Id,PostTypeId,
OwnerUserId,Title;

--DUMP B Replace DUMP B with STORE B like below to store it in /FinalHive_project

STORE B INTO '/FinalHive_project'
USING org.apache.pig.piggybank.storage.CSVExcelStorage(',');
