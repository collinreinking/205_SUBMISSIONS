--create survey_scores (all scores cast as doubles)
-- only need to use achievement points based on information here:
-- http://www.hcahpsonline.org/files/August%202013%20HCAHPS%20Fact%20Sheet2.pdf
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
