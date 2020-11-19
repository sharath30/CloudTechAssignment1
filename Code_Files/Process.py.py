#python program to clean the data of all four files

import pandas as pd;
import re;
import glob;

#The path where 4 csv files are avilable
folderPath = '/home/sharath_madhumanjunath2/project/stackexchange';

#The path where the cleaned files will be stored
folderPathToStore = '/home/sharath_madhumanjunath2/project/stackexchange/preprocessed';

allFiles = glob.glob(folderPath + "/*.csv");

#Regular expression is used to clean the data with special characters and later stored in preprocessed directory
for completeFilePath in allFiles:
    filename = completeFilePath.split('/')[5];
    df = pd.read_csv(completeFilePath);
    df['Body'] = df['Body'].apply(lambda b: re.sub('<.*?>|\\t*\\r*\\n*\\s+',' ',b));
    df['Title'] = df['Title'].apply(lambda t: re.sub('<.*?>|\\t*\\r*\\n*\\s+',' ',t));
    df.to_csv(folderPathToStore+'/cleaned_'+filename,index=False);
