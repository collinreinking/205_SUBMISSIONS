SELECT DISTINCT Provider_Id FROM hospitals_raw LIMIT 3

SELECT COUNT (DISTINCT Provider_Id) FROM hospitals_raw
-- 4824

SELECT Provider_Id FROM hospitals_raw WHERE Provider_Id REGEXP '.*[a-zA-Z].*'
--Some provider ID's end in the letter F.

SELECT DISTINCT HOSPITAL_TYPE FROM hospitals_raw WHERE Provider_Id REGEXP '.*[a-zA-Z].*'
--ACUTE CARE - VETERANS ADMINISTRATION

SELECT HOSPITAL_TYPE FROM hospitals_raw WHERE HOSPITAL_TYPE REGEXP '.*VETERANS.*'
--ACUTE CARE - VETERANS ADMINISTRATION

SELECT DISTINCT HOSPITAL_OWNERSHIP FROM hospitals_raw WHERE HOSPITAL_TYPE REGEXP '.*VETERANS.*'
--Government Federal

SELECT Provider_Id FROM hospitals_raw WHERE HOSPITAL_OWNERSHIP REGEXP '.*Federal.*'
--By inspection, some but not all have an F at the end
SELECT DISTINCT Hospital_type FROM hospitals_raw WHERE HOSPITAL_OWNERSHIP REGEXP '.*Federal.*'
--The Federal Government owns three kinds of hospitals:
  --ACUTE CARE - VETERANS ADMINISTRATION
  --Acute Care Hospitals
  --Critical Access Hospitals

SELECT DISTINCT HOSPITAL_OWNERSHIP FROM hospitals_raw WHERE HOSPITAL_OWNERSHIP REGEXP '.*Federal.*'
--Government - Federal
--Government Federal

SELECT DISTINCT HOSPITAL_TYpe FROM hospitals_raw WHERE HOSPITAL_OWNERSHIP REGEXP 'Government\ \-\ Federal'
--Acute Care Hospitals
--Critical Access Hospitals

SELECT DISTINCT HOSPITAL_TYpe FROM hospitals_raw WHERE HOSPITAL_OWNERSHIP REGEXP 'Government\ Federal'
--ACUTE CARE - VETERANS ADMINISTRATION

SELECT DISTINCT Hospital_type FROM hospitals_raw WHERE Provider_Id REGEXP '.*[a-zA-Z].*'
--All hospitals whose provider_id are Hospital_type = ACUTE CARE - VETERANS ADMINISTRATION

SELECT count(DISTINCT Provider_Number) FROM surveys_responses_raw;
--3074
SELECT count(*) FROM surveys_responses_raw;
--3074

======

SELECT COUNT(*) FROM effective_care_raw
--217821

SELECT condition, count(condition) FROM effective_care_raw GROUP BY condition;
-- Blood Clot Prevention and Treatment	27936
-- Children's Asthma	308
-- Emergency Department	34546
-- Heart Attack or Chest Pain	39437
-- Heart Failure	14097
-- Pneumonia	4785
-- Pregnancy and Delivery Care	4656
-- Preventive Care	8435
-- Stroke Care	37248
-- Surgical Care Improvement Project	46373

SELECT Measure_Name, count(Measure_Name) FROM effective_care_raw GROUP BY Measure_Name;
-- ACEI or ARB for LVSD	4656
-- Anticoagulation Therapy for Atrial Fibrillation/Flutter	4656
-- Anticoagulation overlap therapy	4656
-- Antithrombotic Therapy by End of Hospital Day 2	4656
-- Aspirin at Arrival	4111
-- Aspirin prescribed at discharge	4656
-- Assessed for Rehabilitation	4656
-- Cardiac surgery patients with controlled 6 a.m. postoperative blood glucose	4785
-- Discharge instructions	4656
-- Discharged on Antithrombotic Therapy	4656
-- Discharged on Statin Medication	4656
-- Door to diagnostic eval	4111
-- ED1	4656
-- ED2	4656
-- Emergency department volume	4679
-- Evaluation of LVS Function	4785
-- Fibrinolytic Therapy Received Within 30 Minutes Of Hospital Arrival	4785
-- Fibrinolytic Therapy Received Within 30 Minutes of ED Arrival	4111
-- Head CT results	4111
-- Healthcare workers given influenza vaccination	3657
-- Home Management Plan of Care Document	102
-- ICU venous thromboembolism prophylaxis	4656
-- Immunization for influenza	4778
-- Incidence of potentially preventable VTE	4656
-- Initial antibiotic selection for CAP in immunocompetent patient	4785
-- Left before being seen	4111
-- Median Time to ECG	4111
-- Median Time to Fibrinolysis	4111
-- Median Time to Transfer to Another Facility for Acute Coronary Intervention	4111
-- Median time to pain med	4111
-- OP 18	4111
-- Percent of newborns whose deliveries were scheduled early (1-3 weeks early), when a scheduled delivery was not medically necessary	4656
-- Postoperative Urinary Catheter Removal	4785
-- Primary PCI Received Within 90 Minutes of Hospital Arrival	4785
-- Prophylactic Antibiotic Initiated Within One Hour Prior to Surgical Incision	4111
-- Prophylactic Antibiotic Selection for Surgical Patients	8896
-- Prophylactic antibiotic received within 1 hour prior to surgical incision	4785
-- Prophylactic antibiotics discontinued within 24 hours after surgery end time	4785
-- Relievers for Inpatient Asthma	103
-- Statin at Discharge	4656
-- Stroke Education	4656
-- Surgery Patients Who Received Appropriate Venous Thromboembolism Prophylaxis Within 24 Hours Prior to Surgery to 24 Hours After Surgery	4785
-- Surgery Patients on a Beta Blocker Prior to Arrival Who Received a Beta Blocker During the Perioperative Period	4785
-- Surgery Patients with Perioperative Temperature Management	4656
-- Systemic Corticosteroids for Inpatient Asthma	103
-- Thrombolytic Therapy	4656
-- Unfractionated heparin with dosages/platelet count monitoring	4656
-- Venous Thromboembolism (VTE) Prophylaxis	4656
-- Venous thromboembolism prophylaxis	4656
-- Warfarin therapy discharge instructions	4656


SELECT Measure_Name, count(Measure_Name) FROM effective_care_raw WHERE condition = "Children's Asthma" GROUP BY Measure_Name;
-- Home Management Plan of Care Document	102
-- Relievers for Inpatient Asthma	103
-- Systemic Corticosteroids for Inpatient Asthma	103

SELECT footnote, count(footnote) FROM effective_care_raw GROUP BY footnote;
-- 1 - The number of cases/patients is too few to report.	12021
-- 1 - The number of cases/patients is too few to report., 2 - Data submitted were based on a sample of cases/patients.	4627
-- 1 - The number of cases/patients is too few to report., 2 - Data submitted were based on a sample of cases/patients., 3 - Results are based on a shorter time period than required.	905
-- 1 - The number of cases/patients is too few to report., 3 - Results are based on a shorter time period than required.	9791
-- 11 - There were discrepancies in the data collection process.	10
-- 2 - Data submitted were based on a sample of cases/patients.	44709
-- 2 - Data submitted were based on a sample of cases/patients., 3 - Results are based on a shorter time period than required.	2948
-- 2 - Data submitted were based on a sample of cases/patients., 3 - Results are based on a shorter time period than required., 7 - No cases met the criteria for this measure.	600
-- 2 - Data submitted were based on a sample of cases/patients., 7 - No cases met the criteria for this measure.	2379
-- 3 - Results are based on a shorter time period than required.	5743
-- 3 - Results are based on a shorter time period than required., 7 - No cases met the criteria for this measure.	7317
-- 4 - Data suppressed by CMS for one or more quarters.	4785
-- 5 - Results are not available for this reporting period.	46523
-- 7 - No cases met the criteria for this measure.	7758

---------------- measures
---------------- readmissions_state
SELECT compared_to_national, count(compared_to_national) FROM readmissions_raw GROUP BY compared_to_national;
-- Better than the National Rate	901
-- No different than the National Rate	41004
-- Not Available	12448
-- Number of Cases Too Small	11399
-- Worse than the National Rate	1238


select
score,
denominator,
measure_name
from readmissions_raw tablesample(0.02 percent);


select
score,
Measure_Id,
measure_name
from effective_care_raw
where provider_id="010001"
order by MEASURE_id;


select
denominator,
Measure_Id
from readmissions_raw
where provider_id="010001";

select distinct footnote from readmissions_raw;
-- 1 - The number of cases/patients is too few to report.
-- 5 - Results are not available for this reporting period.

SELECT Measure_Name, count(Measure_Name) FROM effective_care_raw where measure;

SELECT Measure_Id, Measure_Name FROM measures_raw WHERE measure_name LIKE '%ime%'
-- ED_1b	Median Time from ED Arrival to ED Departure for Admitted ED Patients
-- ED_2b	Admit Decision Time to ED Departure Time for Admitted Patients
-- OP_1	Median Time to Fibrinolysis
-- OP_18b	Median Time from ED Arrival to ED Departure for Discharged ED Patients
-- OP_20	Median Time from ED Arrival to Provider Contact for ED patients
-- OP_21	Median Time to Pain Management for Long Bone Fracture
-- OP_3b	Median Time to Transfer to Another Facility for Acute Coronary Intervention- Reporting Rate
-- OP_5	Median Time to ECG
-- SCIP_Inf_3	Prophylactic Antibiotics Discontinued Within 24 hours After Surgery End Time

------TIME MEASURE_ids
-- ED_1b,
-- ED_2b,
-- OP_1,
-- OP_18b,
-- OP_20,
-- OP_21,
-- OP_3b

SELECT Measure_Id FROM measures_raw WHERE measure_name LIKE '%ime%'

SELECT Measure_Id, Measure_Name FROM measures_raw WHERE measure_name NOT LIKE '%ime%'

SELECT Measure_Name, count(Measure_Name) FROM effective_care_raw GROUP BY Measure_Name;
SELECT Measure_Id, Measure_Name FROM readmissions_raw WHERE measure_name LIKE '%ime%'



CREATE TABLE readmissions
ROW FORMAT DELIMITED
AS SELECT
  provider_id,
  measure_id,
  100-CAST(score as DECIMAL(10,2)) as score,
  compared_to_national,
  CASE (compared_to_national)
    WHEN "Better than the National Rate" THEN 1
    WHEN "Worse than the National Rate" THEN -1
    ELSE 0
  END as compared_to_national_numeric
FROM readmissions_raw
WHERE compared_to_national NOT LIKE 'Not_Available'
AND compared_to_national NOT LIKE 'Number_of_Cases_Too_Small';

-- Better than the National Rate	901
-- No different than the National Rate	41004
-- Not Available	12448
-- Number of Cases Too Small	11399
-- Worse than the National Rate	1238



DROP TABLE effective_care_ratios;
CREATE TABLE effective_care_ratios
ROW FORMAT DELIMITED
AS SELECT
  provider_id,
  measure_id,
  CAST(score as DECIMAL(10,2))
FROM effective_care_raw
WHERE cast(score as double) is not  NULL
AND measure_id NOT like 'ED_1b'
AND measure_id NOT like 'ED_2b'
AND measure_id NOT like 'OP_1'
AND measure_id NOT like 'OP_18b'
AND measure_id NOT like 'OP_20'
AND measure_id not like 'OP_21'
AND measure_id not like 'OP_3b'
AND measure_id not like 'OP_5';

DROP TABLE effective_care_high_percent_metrics;
CREATE TABLE effective_care_high_percent_metrics
ROW FORMAT DELIMITED
AS SELECT
  provider_id,
  measure_id,
  CAST(score as double)
FROM effective_care_raw
WHERE cast(score as double) is not  NULL
AND measure_id RLIKE '(^AMI.*|^CAC.*|^HF.*|^IMM.*|^OP_[2|4|6|7]$|^OP_23$|^PN_6|^SCIP.*|^STK.*|^VTE_[1-5]$)';


DROP TABLE effective_care_low_percent_metrics;
CREATE TABLE effective_care_low_percent_metrics
ROW FORMAT DELIMITED
AS SELECT
  provider_id,
  measure_id,
  CAST(score as double)
FROM effective_care_raw
WHERE cast(score as double) is not  NULL
AND measure_id RLIKE '(^OP_22$|^PC_01$|^VTE_6$)';

DROP TABLE effective_care_low_time_metrics;
CREATE TABLE effective_care_low_time_metrics
ROW FORMAT DELIMITED
AS SELECT
  provider_id,
  measure_id,
  CAST(score as double)
FROM effective_care_raw
WHERE cast(score as double) is not  NULL
AND measure_id RLIKE '(^ED_1b$|^ED_2b$|^OP_1$|^OP_3b$|^OP_5$|^OP_18b$|^OP_20$|^OP_21$)';


select measure_id, CAST(score as DECIMAL(10,2)) from effective_care_raw where measure_id RLIKE 'OP_2$' LIMIT 50;

--AND FIND_IN_SET(measure_id,'AMI_2,AMI_7a,AMI_8a,AMI_10,CAC_1,CAC_2,CAC_3')>0;
TIME(low is good): ED_1b,ED_2b,OP_1,OP_3b,OP_5,OP_18b,OP_20,OP_21
PERCENT(LOW IS GOOD): OP_22  --patients who left without care
                      PC_01  --deliveries scheduled too early
                      VTE_6  --patients who got a preventable blood clot
OTHER: EDV

Select measure_id, CAST(score as double) Cas from effective_care_raw where measure_id rlike '.*(AMI.*|CAC.*|HF.*).*'


DROP TABLE effective_care_percent_means;
Create Table effective_care_percent_means
ROW FORMAT DELIMITED
AS SELECT
  provider_id,
  avg(score) as avg_score,
  count(score) as score_count
from effective_care_ratios
group by provider_id;

SELECT
  provider_id,
  concat("__",score_count,"__"),
  avg_score
from effective_care_percent_means
where score_count>10
SORT BY avg_score desc
LIMIT 20;

select avg(score_count) from effective_care_percent_means;
-- mean 21.8

select percentile(score_count, 0.5) from effective_care_percent_means;
== median 27




select
 Overall_Rating_of_Hospital_Achievement_Points String,
 Overall_Rating_of_Hospital_Improvement_Points String,
 Overall_Rating_of_Hospital_Dimension_Score String,
 HCAHPS_Base_Score String,
 HCAHPS_Consistency_Score String
from surveys_responses_raw
