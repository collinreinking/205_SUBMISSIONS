SELECT
  provider_info.state,
  count(*) as mcount
FROM
  percent_metrics
INNER JOIN provider_info ON percent_metrics.provider_id = provider_info.provider_id
GROUP BY provider_info.state
ORDER BY mcount DESC;
CA  12162
TX	10574
FL	7443
NY	6503
PA	6237
IL	6089
OH	5791
MI	4318
GA	4145
IN	3986
NC	3967
WI	3648
TN	3495
MO	3320
VA	3182
LA	3058
NJ	2880
AL	2821
KY	2761
OK	2720
MN	2703
WA	2566
AZ	2455
MA	2442
SC	2276
IA	2228
MS	2199
KS	2182
CO	2069
AR	2000
OR	1858
MD	1624
WV	1441
NE	1406
CT	1250
UT	1152
ME	1093
NM	1076
NV	1027
NH	832
MT	811
PR	771 Puerto Rico
SD	757
ID	736
ND	545
HI	519
WY	514
RI	469
VT	410
AK	368
DC	328 District of Columbia
DE	288
VI	65  Virgin Islands
GU	29  Guam
MP	8   Norther Mariana Islands


SELECT
  provider_info.state,
  count(*) as mcount,
  cast(avg(percent_metrics.score)as Decimal(10,2)) as state_mean,

  cast(min(percent_metrics.score) as Decimal(10,2)),
  cast(percentile_approx(score, 0.25) as Decimal(10,2)),
  cast(percentile_approx(score, 0.5) as Decimal(10,2)),
  cast(percentile_approx(score, 0.75) as Decimal(10,2)),
  cast(max(percent_metrics.score) as Decimal(10,2)),

  cast(std(percent_metrics.score) as Decimal(10,2))
FROM
  percent_metrics
LEFT JOIN provider_info ON percent_metrics.provider_id = provider_info.provider_id
GROUP BY provider_info.state
ORDER BY state_mean DESC
LIMIT 10;

--------------------------
SELECT
  cast(std(percent_metrics.score) as Decimal(10,2)) as measure_std,
  measures.measure_name
FROM
  percent_metrics
LEFT JOIN measures ON percent_metrics.measure_id = measures.measure_id
GROUP BY measures.measure_name
ORDER BY measure_std DESC
LIMIT 10;
------------------------------------------


corr()
survey_scores.nurse_communication +
survey_scores.doctor_communication +
survey_scores.responsiveness +
survey_scores.pain +
survey_scores.medicine_communication +
survey_scores.environment +
survey_scores.discharge +
survey_scores.overall


(SELECT
  provider_id,
  avg(percent_metrics.score),
  count(*)
FROM percent_metrics
GROUP BY provider_id
) AS provider_means

SELECT
  provider_id,
  (survey_scores.nurse_communication +
  survey_scores.doctor_communication +
  survey_scores.responsiveness +
  survey_scores.pain +
  survey_scores.medicine_communication +
  survey_scores.environment +
  survey_scores.discharge +
  survey_scores.overall)/8
FROM survey_scores
) AS survey_means

SELECT *
FROM
  (
  SELECT
    provider_id,
    avg(percent_metrics.score),
    count(*)
    FROM percent_metrics
    GROUP BY provider_id
  ) AS performance_means
INNER JOIN
  (
  SELECT
    provider_id,
    (survey_scores.nurse_communication +
    survey_scores.doctor_communication +
    survey_scores.responsiveness +
    survey_scores.pain +
    survey_scores.medicine_communication +
    survey_scores.environment +
    survey_scores.discharge +
    survey_scores.overall)/8
  FROM survey_scores
  ) AS survey_means
ON performance_means.provider_id=survey_means.provider_id
LIMIT 10



SELECT
  Communication_with_Nurses_Achievement_Points,
  Communication_with_Doctors_Achievement_Points as doctor_communication,
  Responsiveness_of_Hospital_Staff_Achievement_Points as responsiveness,
  Pain_Management_Achievement_Points as pain,
  Communication_about_Medicines_Achievement_Points as medicine_communication,
  Cleanliness_and_Quietness_of_Hospital_Environment_Achievement_Points as environment,
  Discharge_Information_Achievement_Points as discharge,
  Overall_Rating_of_Hospital_Achievement_Points as overall
FROM
  surveys_responses_raw
WHERE provider_number LIKE "010006"

SELECT
  CAST(substring(Communication_with_Nurses_Achievement_Points,0,2) as DOUBLE) as nurse_communication,
  CAST(substring(Communication_with_Doctors_Achievement_Points,0,2) as DOUBLE) as doctor_communication,
  CAST(substring(Responsiveness_of_Hospital_Staff_Achievement_Points,0,2) as DOUBLE) as responsiveness,
  CAST(substring(Pain_Management_Achievement_Points,0,2) as DOUBLE) as pain,
  CAST(substring(Communication_about_Medicines_Achievement_Points,0,2) as DOUBLE) as medicine_communication,
  CAST(substring(Cleanliness_and_Quietness_of_Hospital_Environment_Achievement_Points,0,2) as DOUBLE) as environment,
  CAST(substring(Discharge_Information_Achievement_Points,0,2) as DOUBLE) as discharge,
  CAST(substring(Overall_Rating_of_Hospital_Achievement_Points,0,2) as DOUBLE) as overall
FROM
  surveys_responses_raw
WHERE provider_number LIKE "010006"



FROM
  surveys_responses_raw
WHERE provider_number LIKE "010006"




SELECT
  corr(quality.provider_mean,survey_means.s_mean),
  corr(quality.provider_std,sqrt(survey_means.sQ_mean-pow(survey_means.s_mean,2))),
  corr(quality.provider_count,survey_means.s_mean),
  corr(quality.provider_count,sqrt(survey_means.sQ_mean-pow(survey_means.s_mean,2))),
  corr(quality.provider_count,quality.provider_mean),
  corr(quality.provider_count,quality.provider_std)
FROM
  (
  SELECT
    provider_id,
    avg(percent_metrics.score) as provider_mean,
    std(percent_metrics.score) as provider_std,
    count(*) as provider_count
    FROM percent_metrics
    GROUP BY provider_id
  ) AS quality
INNER JOIN
  (
  SELECT
    provider_id,
    (survey_scores.nurse_communication +
    survey_scores.doctor_communication +
    survey_scores.responsiveness +
    survey_scores.pain +
    survey_scores.medicine_communication +
    survey_scores.environment +
    survey_scores.discharge +
    survey_scores.overall)/8 as s_mean,
    (pow(survey_scores.nurse_communication,2) +
    pow(survey_scores.doctor_communication,2) +
    pow(survey_scores.responsiveness,2) +
    pow(survey_scores.pain,2) +
    pow(survey_scores.medicine_communication,2) +
    pow(survey_scores.environment,2) +
    pow(survey_scores.discharge,2) +
    pow(survey_scores.overall,2))/8 as sQ_mean
  FROM survey_scores
  ) AS survey_means
ON quality.provider_id=survey_means.provider_id;
--correlation cooefficients
--0.06031228196156869     -0.015237478794997135   -0.48521200308311213    -0.15695892191098698	0.2656358390400835	-0.20236983568888053
