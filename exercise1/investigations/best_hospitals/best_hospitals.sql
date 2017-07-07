SELECT
  RPAD(provider_info.hospital_name, 40, "."),
  cast(provider_score_summary.provider_mean as Decimal(10,2)),

  cast(provider_score_summary.low_score as Decimal(10,2)),
  cast(provider_score_summary.provider_median as Decimal(10,2)),
  cast(provider_score_summary.high_score as Decimal(10,2)),

  cast(provider_score_summary.provider_std as Decimal(10,2)),
  provider_score_summary.measures_count
FROM(
  SELECT
    provider_id,
    count(*) as measures_count,
    avg(score) as provider_mean,
    percentile_approx(score, 0.5) as provider_median,
    STD(score) as provider_std,
    min(score) as low_score,
    max(score) as high_score
  from percent_metrics
  GROUP BY provider_id
) AS provider_score_summary

INNER JOIN provider_info ON provider_score_summary.provider_id = provider_info.provider_id
WHERE provider_score_summary.measures_count > 46
ORDER BY provider_score_summary.provider_mean DESC
LIMIT 10;
