SELECT
  cast(std(percent_metrics.score) as Decimal(10,2)) as measure_std,
  measures.measure_name
FROM
  percent_metrics
LEFT JOIN measures ON percent_metrics.measure_id = measures.measure_id
GROUP BY measures.measure_name
ORDER BY measure_std DESC
LIMIT 10;


-- 21.95 Thrombolytic Therapy
-- 21.84	Head CT Scan Results for Acute Ischemic Stroke or Hemorrhagic Stroke Patients who Received Head CT or MRI Scan Interpretation Within 45 Minutes of ED Arrival
-- 18.78	Fibrinolytic Therapy Received within 30 Minutes of Hospital Arrival
-- 18.05	Fibrinolytic Therapy Received Within 30 Minutes of ED Arrival
-- 16.3	  Venous Thromboembolism Warfarin Therapy Discharge Instructions
-- 15.26	Venous Thromboembolism Prophylaxis
-- 14.01	Stroke Education
-- 12.72	Home Management Plan of Care (HMPC) Document Given to Patient/Caregiver
-- 11.94	Influenza Immunization
-- 11.83	Discharge Instructions
