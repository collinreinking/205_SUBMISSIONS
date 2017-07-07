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
