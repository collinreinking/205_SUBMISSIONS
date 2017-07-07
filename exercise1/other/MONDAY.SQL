SELECT
  Communication_with_Nurses_Achievement_Points String,
  Communication_with_Nurses_Improvement_Points String,
  Communication_with_Nurses_Dimension_Score String,
  Communication_with_Doctors_Achievement_Points String,
  Communication_with_Doctors_Improvement_Points String,
  Communication_with_Doctors_Dimension_Score String
FROM
  surveys_responses_raw
LIMIT 10;
-- 0 out of 10	2 out of 9	2 out of 10	4 out of 10	0 out of 9	4 out of 10
-- 7 out of 10	3 out of 9	7 out of 10	10 out of 10	9 out of 9	10 out of 10
-- 1 out of 10	1 out of 9	1 out of 10	2 out of 10	0 out of 9	2 out of 10
-- 0 out of 10	0 out of 9	0 out of 10	10 out of 10	9 out of 9	10 out of 10
-- 0 out of 10	0 out of 9	0 out of 10	10 out of 10	9 out of 9	10 out of 10
-- 0 out of 10	0 out of 9	0 out of 10	4 out of 10	0 out of 9	4 out of 10
--This shows that the dimention score is the hgigher of the two scores (between
--achievement and improvment) which matches what I found at:
--http://www.hcahpsonline.org/files/August%202013%20HCAHPS%20Fact%20Sheet2.pdf

SELECT
  DISTINCT CAST(substring(Communication_with_Nurses_Achievement_Points,0,2) as DOUBLE)
FROM
  surveys_responses_raw
WHERE NOT
  Communication_with_Nurses_Achievement_Points LIKE "%Not Available%";

SELECT
  *
FROM
  surveys_responses_raw
WHERE
  Communication_with_Nurses_Achievement_Points LIKE "%Not Available%";


;;;;;
SELECT
  Provider_Number,
  Communication_with_Nurses_Achievement_Points,
  Communication_with_Doctors_Achievement_Points,
  Responsiveness_of_Hospital_Staff_Achievement_Points,
  Pain_Management_Achievement_Points,
  Communication_about_Medicines_Achievement_Points,
  Cleanliness_and_Quietness_of_Hospital_Environment_Achievement_Points,
  Discharge_Information_Achievement_Points,
  Overall_Rating_of_Hospital_Achievement_Points
FROM surveys_responses_raw
  WHERE (
      Communication_with_Nurses_Achievement_Points LIKE "%Not Available%" OR
      Communication_with_Doctors_Achievement_Points LIKE "%Not Available%" OR
      Responsiveness_of_Hospital_Staff_Achievement_Points LIKE "%Not Available%" OR
      Pain_Management_Achievement_Points LIKE "%Not Available%" OR
      Communication_about_Medicines_Achievement_Points LIKE "%Not Available%" OR
      Cleanliness_and_Quietness_of_Hospital_Environment_Achievement_Points LIKE "%Not Available%" OR
      Discharge_Information_Achievement_Points LIKE "%Not Available%" OR
      Overall_Rating_of_Hospital_Achievement_Points LIKE "%Not Available%"
);
-- 010109	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available
-- 050158	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available
-- 050205	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available
-- 050758	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available
-- 070039	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available
-- 140019	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available
-- 140083	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available
-- 140197	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available
-- 190145	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available
-- 190297	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available
-- 230301	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available
-- 260080	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available
-- 330144	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available
-- 360361	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available
-- 370083	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available
-- 370225	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available
-- 430096	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available
-- 440010	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available
-- 440016	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available
-- 440040	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available
-- 440070	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available
-- 450214	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available
-- 450235	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available
-- 450497	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available
-- 450498	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available
-- 450584	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available
-- 450586	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available
-- 450620	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available
-- 450641	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available
-- 450749	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available
-- 450796	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available
-- 460039	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available	Not Available



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
);

select * from survey_scores limit 10;
-- 010001	0.0	4.0	0.0	0.0	1.0	3.0	2.0	3.0
-- 010005	7.0	10.0	5.0	7.0	7.0	4.0	6.0	5.0
-- 010006	1.0	2.0	0.0	0.0	0.0	0.0	1.0	0.0
-- 010007	0.0	10.0	3.0	0.0	8.0	6.0	5.0	2.0
-- 010008	0.0	10.0	4.0	4.0	10.0	1.0	0.0	0.0
--- that doesn't make sense. yes it does, overall score is a survey question, not a statistic

SELECT
  Provider_Number,
  Communication_with_Nurses_Achievement_Points,
  Communication_with_Doctors_Achievement_Points,
  Responsiveness_of_Hospital_Staff_Achievement_Points,
  Pain_Management_Achievement_Points,
  Communication_about_Medicines_Achievement_Points,
  Cleanliness_and_Quietness_of_Hospital_Environment_Achievement_Points,
  Discharge_Information_Achievement_Points,
  Overall_Rating_of_Hospital_Achievement_Points
FROM surveys_responses_raw
WHERE Provider_Number LIKE "010008"
--010008	0 out of 10	10 out of 10	4 out of 10	4 out of 10	10 out of 10	1 out of 10	0 out of 10	0 out of 10


SELECT avg(measures_count), percentile_approx(measures_count, 0.5), percentile_approx(measures_count, 0.6), percentile_approx(measures_count, 0.7), percentile_approx(measures_count, 0.8), percentile_approx(measures_count, 0.9) FROM provider_percent_summary;
--29.961278036394415      35.17910447761194       41.10503597122302       44.04408602150538	46.08449848024316	47.42216748768473


DROP TABLE provider_percent_summary;
CREATE TABLE provider_percent_summary
ROW FORMAT DELIMITED
AS SELECT
  provider_id,
  count(*) as measures_count,
  avg(score) as provider_mean,
  percentile_approx(score, 0.5) FROM provider_median;
  STD(score) as provider_std
from percent_metrics GROUP BY provider_id;



SELECT
  *
FROM (
  SELECT
    provider_id as provider_id,
    cast(avg(score)as Decimal(10,2)) as provider_mean,

    cast(min(score) as Decimal(10,2)),
    cast(percentile_approx(score, 0.25) as Decimal(10,2)),
    cast(percentile_approx(score, 0.5) as Decimal(10,2)),
    cast(percentile_approx(score, 0.75) as Decimal(10,2)),
    cast(max(score) as Decimal(10,2)),
    cast(std(score) as Decimal(10,2))
  FROM percent_metrics
  GROUP BY provider_id
) AS pmetrics
LEFT JOIN provider_info ON pmetrics.provider_id = provider_info.provider_id
LIMIT 10;
