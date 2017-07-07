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
-- UT      1152    93.72   14      88.26   96.97   99.18   100     8.52
-- ME	1093	93.58	25	87.46	97.65	99.34	100	7.95
-- VA	3182	93.55	6	87.96	97.9	99.25	100	8.43
-- DE	288	93.34	27	88.5	96	99.09	100	8.15
-- CO	2069	93.28	0	87.88	96.95	99.16	100	8.91
-- CT	1250	93.26	16	88.02	96.92	98.97	100	8.19
-- NH	832	93.24	0	87.48	96.95	99.25	100	9
-- NC	3967	93.22	19	87.75	96.87	99.15	100	8.75
-- SC	2276	93.19	0	87.81	96.96	99.18	100	9.1
-- MA	2442	93.19	22	88.04	95.99	99.07	100	8.31
