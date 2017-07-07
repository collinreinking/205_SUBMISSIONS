--create readmissions_low_percent_metrics table
-- this table will be deleted later but is one step in making the percent_metrics table
DROP TABLE readmissions_low_percent_metrics;
CREATE TABLE readmissions_low_percent_metrics
ROW FORMAT DELIMITED
AS SELECT
  provider_id,
  measure_id,
  CAST(score as double) as score
FROM readmissions_raw
WHERE compared_to_national NOT LIKE 'Not_Available'
AND compared_to_national NOT LIKE 'Number_of_Cases_Too_Small';

--create effective_care_high_percent
-- this table will be deleted later but is one step in making the percent_metrics table
DROP TABLE effective_care_high_percent_metrics;
CREATE TABLE effective_care_high_percent_metrics
ROW FORMAT DELIMITED
AS SELECT
  provider_id,
  measure_id,
  CAST(score as double) as score
FROM effective_care_raw
WHERE cast(score as double) is not  NULL
AND measure_id RLIKE '(^AMI.*|^CAC.*|^HF.*|^IMM.*|^OP_[2|4|6|7]$|^OP_23$|^PN_6|^SCIP.*|^STK.*|^VTE_[1-5]$)';

--create_effective_care_low_percent_metrics
-- this table will be deleted later but is one step in making the percent_metrics table
DROP TABLE effective_care_low_percent_metrics;
CREATE TABLE effective_care_low_percent_metrics
ROW FORMAT DELIMITED
AS SELECT
  provider_id,
  measure_id,
  CAST(score as double) as score
FROM effective_care_raw
WHERE cast(score as double) is not  NULL
AND measure_id RLIKE '(^OP_22$|^PC_01$|^VTE_6$)';

--create_effective_care_low_time_metrics
--  I decided not to use the time data in my rankings
-- DROP TABLE effective_care_low_time_metrics;
-- CREATE TABLE effective_care_low_time_metrics
-- ROW FORMAT DELIMITED
-- AS SELECT
--   provider_id,
--   measure_id,
--   CAST(score as double)
-- FROM effective_care_raw
-- WHERE cast(score as double) is not  NULL
-- AND measure_id RLIKE '(^ED_1b$|^ED_2b$|^OP_1$|^OP_3b$|^OP_5$|^OP_18b$|^OP_20$|^OP_21$)';

--create percent metrics table (for all scores HIGHer should indicate better)
DROP TABLE percent_metrics;
CREATE TABLE percent_metrics
ROW FORMAT DELIMITED
AS SELECT
    provider_id,
    measure_id,
    score
  FROM effective_care_high_percent_metrics
UNION
SELECT
  provider_id,
  measure_id,
  100 - score as score
FROM effective_care_low_percent_metrics
UNION
SELECT
 provider_id,
 measure_id,
 100 - score as score
FROM readmissions_low_percent_metrics;
);

-- drop the tables that won't be needed moving forward
DROP TABLE readmissions_low_percent_metrics;
DROP TABLE effective_care_high_percent_metrics;
DROP TABLE effective_care_low_percent_metrics;


--create measures table to serve as dictionary for measure_id:measure_name
DROP TABLE measures;
CREATE TABLE measures
ROW FORMAT DELIMITED
AS SELECT
  measure_id,
  measure_name
FROM measures_raw;

--create survey_scores (all scores cast as doubles)
-- only need to use achievement points based on information here:
-- http://www.hcahpsonline.org/files/August%202013%20HCAHPS%20Fact%20Sheet2.pdf
DROP TABLE survey_scores;
CREATE TABLE survey_scores
ROW FORMAT DELIMITED
AS SELECT
  Provider_Number as provider_id,
  CAST(substring(Communication_with_Nurses_Achievement_Points,0,2) as DOUBLE) as nurse_communication,
  CAST(substring(Communication_with_Doctors_Achievement_Points,0,2) as DOUBLE) as doctor_communication,
  CAST(substring(Responsiveness_of_Hospital_Staff_Achievement_Points,0,2) as DOUBLE) as responsiveness,
  CAST(substring(Pain_Management_Achievement_Points,0,2) as DOUBLE) as pain,
  CAST(substring(Communication_about_Medicines_Achievement_Points,0,2) as DOUBLE) as medicine_communication,
  CAST(substring(Cleanliness_and_Quietness_of_Hospital_Environment_Achievement_Points,0,2) as DOUBLE) as environment,
  CAST(substring(Discharge_Information_Achievement_Points,0,2) as DOUBLE) as discharge,
  CAST(substring(Overall_Rating_of_Hospital_Achievement_Points,0,2) as DOUBLE) as overall
FROM surveys_responses_raw
WHERE NOT (
  Communication_with_Nurses_Achievement_Points LIKE "%Not Available%" OR
  Communication_with_Doctors_Achievement_Points LIKE "%Not Available%" OR
  Responsiveness_of_Hospital_Staff_Achievement_Points LIKE "%Not Available%" OR
  Pain_Management_Achievement_Points LIKE "%Not Available%" OR
  Communication_about_Medicines_Achievement_Points LIKE "%Not Available%" OR
  Cleanliness_and_Quietness_of_Hospital_Environment_Achievement_Points LIKE "%Not Available%" OR
  Discharge_Information_Achievement_Points LIKE "%Not Available%" OR
  Overall_Rating_of_Hospital_Achievement_Points LIKE "%Not Available%"

-- create provier_info table to serve as dictionary for provider_id
DROP TABLE provider_info;
CREATE TABLE provider_info
ROW FORMAT DELIMITED
AS SELECT
  provider_id,
  hospital_name,
  state
FROM hospitals_raw;


-- drop all of the raw data tables
--DROP TABLE effective_care_raw;
--DROP TABLE hospitals_raw;
--DROP TABLE measures_raw;
--DROP TABLE readmissions_raw;
--DROP TABLE surveys_responses_rawl;
