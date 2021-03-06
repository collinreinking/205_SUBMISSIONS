#get data from internet, unzip into new directory, delete zip file
wget -O Hospital_Revised_Flatfiles.zip http://data.medicare.gov/views/bg9k-emty/files/Nqcy71p9Ss2RSBWDmP77H1DQXcyacr2khotGbDHHW_s?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip
unzip Hospital_Revised_Flatfiles.zip -d ./Hospital_Revised_Flatfiles
rm Hospital_Revised_Flatfiles.zip

#Create a directory for base data
mkdir base_data

#Create headerless (and renamed) data files in base_data from original data files
tail -n +2 Hospital_Revised_Flatfiles/Hospital\ General\ Information.csv > base_data/hospitals.csv
tail -n +2 Hospital_Revised_Flatfiles/Timely\ and\ Effective\ Care\ \-\ Hospital.csv > base_data/effective_care.csv
tail -n +2 Hospital_Revised_Flatfiles/Readmissions\ and\ Deaths\ \-\ Hospital.csv > base_data/readmissions.csv
tail -n +2 Hospital_Revised_Flatfiles/Measure\ Dates.csv > base_data/measures.csv
tail -n +2 Hospital_Revised_Flatfiles/hvbp_hcahps_05_28_2015.csv > base_data/surveys_responses.csv

#Remove original data files
rm -rf Hospital_Revised_Flatfiles

#Create hdfs directory for data
hdfs dfs -mkdir /user/w205/hospital_compare

#Create hdfs directory for each data table
hdfs dfs -mkdir /user/w205/hospital_compare/hospitals
hdfs dfs -mkdir /user/w205/hospital_compare/effective_care
hdfs dfs -mkdir /user/w205/hospital_compare/readmissions
hdfs dfs -mkdir /user/w205/hospital_compare/measures
hdfs dfs -mkdir /user/w205/hospital_compare/surveys_responses

#Load data into hdfs
hdfs dfs -put base_data/hospitals.csv hospital_compare/hospitals/hospitals
hdfs dfs -put base_data/effective_care.csv hospital_compare/effective_care/effective_care
hdfs dfs -put base_data/readmissions.csv hospital_compare/readmissions/readmissions
hdfs dfs -put base_data/measures.csv hospital_compare/measures/measures
hdfs dfs -put base_data/surveys_responses.csv hospital_compare/surveys_responses/surveys_responses
