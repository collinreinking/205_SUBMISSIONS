--create measures table to serve as dictionary for measure_id:measure_name
DROP TABLE measures;
CREATE TABLE measures
ROW FORMAT DELIMITED
AS SELECT
  measure_id,
  measure_name
FROM measures_raw;
