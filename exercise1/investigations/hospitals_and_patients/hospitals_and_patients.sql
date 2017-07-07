SELECT
  cast(corr(quality.provider_mean,survey_means.s_mean) as Decimal(10,4)),
  cast(corr(quality.provider_std,sqrt(survey_means.sQ_mean-pow(survey_means.s_mean,2))) as Decimal(10,4)),
  cast(corr(quality.provider_count,survey_means.s_mean) as Decimal(10,4)),
  cast(corr(quality.provider_count,sqrt(survey_means.sQ_mean-pow(survey_means.s_mean,2))) as Decimal(10,4)),
  cast(corr(quality.provider_count,quality.provider_mean) as Decimal(10,4)),
  cast(corr(quality.provider_count,quality.provider_std) as Decimal(10,4))
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
--0.0603  -0.0152 -0.4852 -0.157  0.2656  -0.2024
