#!/bin/bash

#starting directory
start_dir=$(pwd)

#make a staging directory
mkdir /data/staging
mkdir /data/staging/exercise_1
cd /data/staging/exercise_1

#get data from internet, unzip into new directory, delete zip file
wget -O Hospital_Revised_Flatfiles.zip http://data.medicare.gov/views/bg9k-emty/files/Nqcy71p9Ss2RSBWDmP77H1DQXcyacr2khotGbDHHW_s?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip
wait
unzip Hospital_Revised_Flatfiles.zip -d ./Hospital_Revised_Flatfiles
rm Hospital_Revised_Flatfiles.zip

tail -n +2 Hospital_Revised_Flatfiles/Hospital\ General\ Information.csv > hospitals.csv
tail -n +2 Hospital_Revised_Flatfiles/Timely\ and\ Effective\ Care\ \-\ Hospital.csv > effective_care.csv
tail -n +2 Hospital_Revised_Flatfiles/Readmissions\ and\ Deaths\ \-\ Hospital.csv > readmissions.csv
tail -n +2 Hospital_Revised_Flatfiles/Measure\ Dates.csv > measures.csv
tail -n +2 Hospital_Revised_Flatfiles/hvbp_hcahps_05_28_2015.csv > surveys_responses.csv

rm -rf Hospital_Revised_Flatfiles

#Create hdfs directory for data
hdfs dfs -mkdir /user/w205/hospital_compare
hdfs dfs -mkdir /user/w205/hospital_compare/hospitals
hdfs dfs -mkdir /user/w205/hospital_compare/effective_care
hdfs dfs -mkdir /user/w205/hospital_compare/readmissions
hdfs dfs -mkdir /user/w205/hospital_compare/measures
hdfs dfs -mkdir /user/w205/hospital_compare/surveys_responses


#Load data into hdfs
hdfs dfs -put hospitals.csv hospital_compare/hospitals/
hdfs dfs -put effective_care.csv hospital_compare/effective_care/
hdfs dfs -put readmissions.csv hospital_compare/readmissions/
hdfs dfs -put measures.csv hospital_compare/measures/
hdfs dfs -put surveys_responses.csv hospital_compare/surveys_responses/

cd $start_dir

exit