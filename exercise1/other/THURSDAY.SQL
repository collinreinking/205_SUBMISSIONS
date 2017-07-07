SELECT count(score), score FROM effective_care_low_percent_metrics; GROUP BY score;

SELECT provider_id, score FROM effective_care_high_percent_metrics
UNION
SELECT provider_id,score FROM effective_care_low_percent_metrics
UNION
SELECT provider_id, score FROM readmissions_low_percent_metrics
LIMIT 50;


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



SELECT count(distinct provider_id) FROM percent_metrics GROUP BY provider_id;

SELECT distinct count(distinct provider_id) FROM percent_metrics GROUP BY provider_id;


-----------------
SELECT * FROM percent_metrics ORDER BY RAND() LIMIT 50

---------------

select count(*) from percent_metrics where provider_id like "100040";
--47

select * from percent_metrics where provider_id like "100040" ORDER BY measure_id;

select provider_id, count(*) from percent_metrics WHERE provider_id like "100040" GROUP BY provider_id;
--100040  47

DROP TABLE provider_percent_summary;
CREATE TABLE provider_percent_summary
ROW FORMAT DELIMITED
AS SELECT
  provider_id,
  count(*) as measure_count,
  avg(score) as provider_mean,
  STD(score) as Provider_std
  from percent_metrics GROUP BY provider_id;

select max(measure_count), min(measure_count), avg(measure_count), STD(measure_count) from provider_percent_summary;
--53      1       29.961278036394415      16.534578304387004

--
--  cut off at minimum of 30 measures
--

SELECT provider_id, measure_count, provider_mean, provider_std from provider_percent_summary where measure_count>=30 ORDER BY provider_mean desc LIMIT 10;
-- 050411  30      98.96333333333334       3.075546925164512
-- 050609	30	98.4	4.127953488110059
-- 050772	32	98.290625	4.4671970640856
-- 050677	31	98.09677419354838	3.1556895745537026
-- 050748	30	98.09333333333333	3.4155461577258133
-- 050515	31	98.07096774193548	3.8465899056417774
-- 050139	30	97.94333333333334	3.8626142557714584
-- 050541	33	97.60909090909091	5.6592302526352105
-- 050072	32	97.509375	3.4305028216538473
-- 050076	32	97.475	4.348203652084385
----OBSERVATION: They're all from california

SELECT * FROM provider_info where provider_id like "050411"
-- 050411	KAISER FOUNDATION HOSPITAL - SOUTH BAY	CA	Acute Care Hospitals	Voluntary non-profit - Other

SELECT provider_id, measure_count, provider_mean, provider_std from provider_percent_summary where measure_count>=40 ORDER BY provider_mean desc LIMIT 10;
-- 420065  40      96.57749999999999       5.870625499041818
-- 100307	44	96.1	6.537096936992471
-- 170176	46	96.09565217391304	6.565256262482106
-- 230072	48	96.03958333333333	6.45757757674828
-- 100055	44	96.00227272727274	6.8360172029001784
-- 170123	50	95.97200000000001	6.461332370339725
-- 340014	48	95.95416666666667	6.532067001000186
-- 390057	45	95.95333333333335	5.757568931415412
-- 450822	41	95.94146341463414	6.730417868727461
-- 490048	48	95.90625	6.757847483050108


SELECT * FROM provider_info where provider_id like "420065";
420065	BON SECOURS-ST FRANCIS XAVIER HOSPITAL	SC	Acute Care Hospitals	Voluntary non-profit - Private



SELECT * FROM provider_percent_summary where provider_id like "050411"

SELECT * FROM provider_percent_summary where provider_id like "240043"
