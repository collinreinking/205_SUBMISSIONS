DROP TABLE hospitals;
CREATE EXTERNAL TABLE hospitals (
Provider_ID string,
Hospital_Name string,
Address string,
City string,
State string,
ZIP_Code string,
County_Name string,
Phone_Number string,
Hospital_Type string,
Hospital_Ownership string,
Emergency_Services string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "quoteChar" = '"',
  "escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/hositals';


DROP TABLE effective_care;
CREATE EXTERNAL TABLE effective_care (
Provider_ID String,
Hospital_Name String,
Address String,
City String,
State String,
ZIP_Code String,
County_Name String,
Phone_Number String,
Condition String,
Measure_ID String,
Measure_Name String,
Score String,
Sample String,
Footnote String,
Measure_Start_Date String,
Measure_End_Date String
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "quoteChar" = '"',
  "escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/effective_care';
