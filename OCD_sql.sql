-- 1. Count of Female vs Male that have OCD and -- Average Obsession Score by Gender


 with data as (
SELECT
Gender,
count(`Patient ID`) as patient_count,
round(avg(`Y-BOCS Score (Obsessions)`),2) as avg_obs_score

FROM ocd.ocd_patient_dataset
Group By 1
Order by 2
)

SELECT 

sum(case when Gender = 'Female' then patient_count else 0 end) as count_female,
sum(case when Gender = 'Male' then patient_count else 0 end) as count_male,

round(sum(case when Gender = 'Female' then patient_count else 0 end)/
(sum(case when Gender = 'Female' then patient_count else 0 end)+sum(case when Gender = 'Male' then patient_count else 0 end)) *100,2)
as pct_female,

round(sum(case when Gender = 'Male' then patient_count else 0 end)/
(sum(case when Gender = 'Female' then patient_count else 0 end)+sum(case when Gender = 'Male' then patient_count else 0 end)) *100,2)
as pct_male

FROM data
;


-- 2. Count of Patients by Ethnicity and their respective average obession score


SELECT
	Ethnicity,
	count(`Patient ID`) as patient_count,
	round(avg(`Y-BOCS Score (Obsessions)`),2) as avg_obs_score
FROM ocd.ocd_patient_dataset
Group By 1
Order by 2;


-- 3. Number of people diagnosed with OCD MoM (Month over Month)


alter table ocd.ocd_patient_dataset
modify `OCD Diagnosis Date` date;



SELECT
date_format(`OCD Diagnosis Date`, '%Y-%m-01 00:00:00') as month,
-- `OCD Diagnosis Date`
count('Patient ID') patient_count
FROM ocd.ocd_patient_dataset
group by 1
Order by 1
;


-- 4. What is the most common obsession Type (Count) and it's respective average obession score


Select
`Obsession Type`,
count(`Patient ID`) as patient_count,
round(avg(`Y-BOCS Score (Obsessions)`),2) as obs_score
FROM ocd.ocd_patient_dataset
group by 1
Order by 2
;


-- 5. What is the most common Compulsion type (Count) and it's respective average obsession score. 


Select
`Compulsion Type`,
count(`Patient ID`) as patient_count,
round(avg(`Y-BOCS Score (Compulsions)`),2) as obs_score
FROM ocd.ocd_patient_dataset
group by 1
Order by 2
;
