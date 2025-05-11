SELECT patient_id, COUNT(*) as event_count
FROM cleaned.abg_events
WHERE abg_ventilator_mode = 'A/C'
GROUP BY patient_id;

SELECT COUNT(*) as total_count
FROM cleaned.abg_events
WHERE abg_ventilator_mode = 'A/C';

SELECT COUNT(*) as total_count
FROM cleaned.abg_events

select * from cleaned.cbc_events

SELECT brain_death, COUNT(*)
FROM cleaned.referrals
WHERE approached = 'TRUE'
GROUP BY brain_death;

SELECT * FROM cleaned.referrals
Where approached = 'TRUE';

ALTER TABLE cleaned.referrals 
DROP COLUMN outcome_transplant;


ALTER TABLE cleaned.referrals 
ADD COLUMN outcome_transplant int;
---Everything else 
update cleaned.referrals set
outcome_transplant=(case when lower(outcome_heart) ='transplanted' then 1  else 0 end )+
(case when lower(outcome_liver) ='transplanted' then 1  else 0 end) + 
(case when lower(outcome_kidney_left) ='transplanted' then 1 else 0 end) +
(case when lower(outcome_kidney_right) ='transplanted' then 1 else 0 end) +
(case when lower(outcome_lung_left) ='transplanted' then 1 else 0 end) + 
(case when lower(outcome_lung_right) ='transplanted' then 1 else 0 end) +  
(case when lower(outcome_intestine) ='transplanted' then 1 else 0 end) + 
(case when lower(outcome_pancreas) ='transplanted' then 1 else 0 end) ;


ALTER TABLE cleaned.referrals 
ADD COLUMN outcome_harvested int;

update cleaned.referrals set
outcome_harvested=(case when outcome_heart is not null then 1  else 0 end )+
(case when outcome_liver is not null then 1  else 0 end) + 
(case when outcome_kidney_left is not null then 1 else 0 end) +
(case when outcome_kidney_right is not null then 1 else 0 end) +
(case when outcome_lung_left is not null then 1 else 0 end) + 
(case when outcome_lung_right is not null then 1 else 0 end) +  
(case when outcome_intestine is not null then 1 else 0 end) + 
(case when outcome_pancreas is not null then 1 else 0 end) ;

ALTER TABLE cleaned.referrals 
ADD COLUMN ratio_harvested_transplanted float;

update cleaned.referrals set ratio_harvested_transplanted=
case when outcome_harvested=0 then 0 else round((outcome_transplant::float/outcome_harvested)::numeric,2) end;

update cleaned.referrals
set cause_of_death_unos='unknown' where cause_of_death_unos is null;

update cleaned.referrals
set cause_of_death_opo='unknown' where cause_of_death_opo is null;

update cleaned.referrals
set mechanism_of_death='unknown' where mechanism_of_death is null;

update cleaned.referrals
set circumstances_of_death='unknown' where circumstances_of_death is null;


update cleaned.referrals
set cause_of_death_unos=lower(cause_of_death_unos);

update cleaned.referrals
set cause_of_death_opo=lower(cause_of_death_opo);

update cleaned.referrals
set mechanism_of_death=lower(mechanism_of_death);

update cleaned.referrals
set circumstances_of_death=lower(circumstances_of_death);

update cleaned.referrals
set cause_of_death_unos='unknown' where cause_of_death_unos in ('other','other, specify');

update cleaned.referrals
set cause_of_death_opo='unknown' where cause_of_death_opo in ('other','other, specify','unknown cod');

update cleaned.referrals
set mechanism_of_death='unknown' where mechanism_of_death in ('none of the above','other, specify');

update cleaned.referrals
set mechanism_of_death='gsw' where mechanism_of_death in ('gunshot wound','gun shot wound');

update cleaned.referrals
set mechanism_of_death='drug/intoxication' where mechanism_of_death in ('drug / intoxication','drug intoxication');

update cleaned.referrals
set circumstances_of_death='unknown' where circumstances_of_death in ('none of the above','other, specify','other');

update cleaned.referrals
set circumstances_of_death = replace(circumstances_of_death, 'alleged ', '') where circumstances_of_death
like 'alleged%';

update cleaned.referrals
set cause_of_death_opo='cancer - leukemia/lymphoma' where cause_of_death_opo in ('leukemia / lymphoma');

update cleaned.referrals
set cause_of_death_opo='tr - gsw' where cause_of_death_opo in ('gsw');

update cleaned.referrals
set cause_of_death_opo='copd' where cause_of_death_opo in ('res - copd');

update cleaned.referrals
set cause_of_death_opo='tr - other' where cause_of_death_opo in ('trauma');

update cleaned.referrals
set cause_of_death_opo='pulmonary embolism' where cause_of_death_opo in ('pe--pulmonary embolism ');

update cleaned.referrals
set mechanism_of_death='natural causes' where mechanism_of_death in ('death from natural causes');

update cleaned.referrals
set mechanism_of_death='unknown' where mechanism_of_death in ('other');

update cleaned.referrals
set circumstances_of_death='non-motor vehicle accident' where circumstances_of_death in ('accident, non-mva');

update cleaned.referrals
set circumstances_of_death='natural causes' where circumstances_of_death in ('death from natural causes');

update cleaned.referrals set outcome_heart='NA' where outcome_heart is null;
update cleaned.referrals set outcome_liver='NA' where outcome_liver is null;
update cleaned.referrals set outcome_kidney_left='NA' where outcome_kidney_left is null;
update cleaned.referrals set outcome_kidney_right='NA' where outcome_kidney_right is null;
update cleaned.referrals set outcome_lung_left='NA' where outcome_lung_left is null;
update cleaned.referrals set outcome_lung_right='NA' where outcome_lung_right is null;
update cleaned.referrals set outcome_intestine='NA' where outcome_intestine is null;
update cleaned.referrals set outcome_pancreas='NA' where outcome_pancreas is null;

select * from cleaned.referrals;

select count(*) from cleaned.referrals
where time_approached is not null and outcome_transplant = 0;--7343

select * from cleaned.referrals
where time_approached is not null and outcome_transplant = 0;--7343

select count(*) from cleaned.referrals
where time_authorized is not null and outcome_transplant = 0;-- 2700

select count(*) from cleaned.referrals
where outcome_transplant!= 0 --8972

select count(*) from cleaned.referrals
where time_procured is not null and outcome_transplant = 0 --531

select count(*) from cleaned.referrals
where outcome_harvested =1 --452

select count(*) from cleaned.referrals
where outcome_harvested =1 and outcome_transplant = 0;--55

select count(*) from cleaned.referrals
where approached ='TRUE' and outcome_transplant = 0;-- 10588

select count(*) from cleaned.referrals
where authorized ='TRUE' and outcome_transplant = 0;-- 3018

select count(*) from cleaned.referrals
where approached ='TRUE' and authorized ='TRUE'and outcome_transplant = 0;--2999

select count(*) from cleaned.referrals
where approached ='TRUE' and authorized ='TRUE'and outcome_harvested = 0 and outcome_transplant = 0 --2457

SELECT MAX(outcome_transplant) 
FROM cleaned.referrals;

SELECT Min(outcome_transplant) 
FROM cleaned.referrals;

select count(*) from cleaned.referrals
where time_approached is not null and outcome_transplant = 0;

select count(*)from cleaned.referrals
where approached = 'TRUE' and authorized ='TRUE' and procured = 'FALSE';--2468

select count(*)from cleaned.referrals
where authorized ='TRUE' and procured = 'FALSE';--2487


SELECT *
FROM cleaned.referrals
WHERE time_approached IS NOT NULL
  AND outcome_transplant = 0
  AND time_authorized IS NULL;
  
SELECT *
FROM cleaned.referrals
WHERE time_approached IS NOT NULL
  AND outcome_transplant = 0
  AND time_authorized IS NULL 
  AND outcome_harvested != 0;
  
 SELECT *
FROM cleaned.referrals
WHERE time_approached IS NOT NULL
  AND outcome_transplant = 0
  AND time_authorized IS NOT NULL;
 