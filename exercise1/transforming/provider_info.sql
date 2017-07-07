-- create provier_info table to serve as dictionary for provider_id
DROP TABLE provider_info;
CREATE TABLE provider_info
ROW FORMAT DELIMITED
AS SELECT
  provider_id,
  hospital_name,
  state
FROM hospitals_raw;
