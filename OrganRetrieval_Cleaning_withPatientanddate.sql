-------ABG EVENTS-------------
CREATE EXTENSION IF NOT EXISTS tablefunc;

insert into cleaned.abg_events (patient_date_id,be,fi02,hc03,o2sat,pc02,peep,ph,pip,p02,rate,tv)  
(
SELECT * FROM CROSSTAB(
  $$ 
  SELECT patient_date_id, abg_name, AVG(value) FROM public.abg_events 
  GROUP BY patient_date_id, abg_name ORDER BY  patient_date_id, abg_name
  $$,
  $$ 
  VALUES ('BE'), ('FIO2'), ('HCO3'), ('O2SAT'), ('PCO2'), ('PEEP'), ('PH'), ('PIP'), ('PO2'), ('Rate'), ('TV') 
  $$ ) AS CT(patient_date_id text, "BE" numeric, "FIO2" numeric, "HCO3" numeric,  "O2SAT" numeric,  "PCO2" numeric, 
  "PEEP" numeric, "PH" numeric,  "PIP" numeric, "PO2" numeric, "Rate" numeric, "TV" numeric
));
 
with abg as (
    select distinct patient_date_id,patient_id, time_event, abg_ventilator_mode from public.abg_events
)
update cleaned.abg_events 
set patient_id = abg.patient_id,time_event = abg.time_event,
abg_ventilator_mode = abg.abg_ventilator_mode 
from abg where
cleaned.abg_events.patient_date_id = abg.patient_date_id ;

select * from cleaned.abg_events

-------CBC EVENTS-------------
insert into cleaned.cbc_events (patient_date_id,band,eos,hct,hgb,lymp,mono,ptl,rbc,segs,wbc)  
(
SELECT * FROM CROSSTAB(
  $$ 
  SELECT patient_date_id, cbc_name, AVG(value) FROM public.cbc_events 
  GROUP BY patient_date_id, cbc_name ORDER BY  patient_date_id, cbc_name
  $$,
  $$ 
  VALUES ('Band'), ('Eos'), ('Hct'), ('Hgb'), ('Lymp'), ('Mono'), ('Ptl'), ('RBC'), ('Segs'), ('WBC') 
  $$ ) AS CT(patient_date_id text, "Band" numeric, "Eos" numeric, "Hct" numeric,  "Hgb" numeric,  "Lymp" numeric, 
  "Mono" numeric, "Ptl" numeric,  "RBC" numeric, "Segs" numeric, "WBC" numeric));
  
 
with cbc as (
    select distinct patient_date_id,patient_id, time_event from public.cbc_events
)
update  cleaned.cbc_events
set time_event = cbc.time_event,
patient_id=cbc.patient_id
from cbc where
cleaned.cbc_events.patient_date_id = cbc.patient_date_id;

select * from cleaned.cbc_events

-------Chemistry EVENTS-------------
insert into cleaned.chemistry_events (patient_date_id,Albumin,AlkPhos,Amylase,BNP,BUN,Calcium,CI,CKMB,CO2,Cpk,CpkIndex,
Creatinine,CreatinineClearance,DirectBili,Fibrinogen,GGT,Glucose,HCG,HgbA1C,IndirectBili,INR,IonizedCalcium,k,
Lactate,LDH,Lipase,LipaseULN,Mg,Phosphorous,PT,PTT,SerumBetaHCG,SerumOsmo,SGOTAST,SGPTALT,Total_CKMB_na,TotalBili,
TotalMB,TotalProtein,TroponinI,TroponinT)  
(
SELECT * FROM CROSSTAB(
  $$ 
  SELECT patient_date_id, chem_name, AVG(value) FROM public.chemistry_events 
  GROUP BY patient_date_id, chem_name ORDER BY patient_date_id, chem_name
  $$,
  $$ 
  VALUES ('Albumin'), ('AlkPhos'), ('Amylase'), ('BNP'), ('BUN'), ('Calcium'), ('CI'), ('CKMB'), ('CO2'), ('Cpk'), ('CpkIndex'),
('Creatinine'), ('CreatinineClearance'), ('DirectBili'), ('Fibrinogen'), ('GGT'), ('Glucose'), ('HCG'), ('HgbA1C'),
('IndirectBili'), ('INR'), ('IonizedCalcium'), ('K'), ('Lactate'), ('LDH'), ('Lipase'), ('LipaseULN'), ('Mg'), ('Phosphorous'),
('PT'), ('PTT'), ('SerumBetaHCG'), ('SerumOsmo'), ('SGOTAST'), ('SGPTALT'), ('Total_CKMB_na'), ('TotalBili'),
('TotalMB'), ('TotalProtein'), ('TroponinI'), ('TroponinT') 
  $$ 
) AS CT(patient_date_id text, "Albumin" numeric, "AlkPhos" numeric, "Amylase" numeric, "BNP" numeric, "BUN" numeric, "Calcium" numeric,
"CI" numeric, "CKMB" numeric, "CO2" numeric, "Cpk" numeric, "CpkIndex" numeric, "Creatinine" numeric,
"CreatinineClearance" numeric, "DirectBili" numeric, "Fibrinogen" numeric, "GGT" numeric, "Glucose" numeric,
"HCG" numeric, "HgbA1C" numeric, "IndirectBili" numeric, "INR" numeric, "IonizedCalcium" numeric, "K" numeric,
"Lactate" numeric, "LDH" numeric, "Lipase" numeric, "LipaseULN" numeric, "Mg" numeric, "Phosphorous" numeric,
"PT" numeric, "PTT" numeric, "SerumBetaHCG" numeric, "SerumOsmo" numeric, "SGOTAST" numeric, "SGPTALT" numeric,
"Total_CKMB_na" numeric, "TotalBili" numeric, "TotalMB" numeric, "TotalProtein" numeric, "TroponinI" numeric,
"TroponinT" numeric));
  
 
with chem as (
    select distinct patient_date_id,patient_id, time_event,value_modifier from public.chemistry_events
)
update  cleaned.chemistry_events
set time_event = chem.time_event,
value_modifier = chem.value_modifier,
patient_id=chem.patient_id
from chem where
cleaned.chemistry_events.patient_date_id = chem.patient_date_id;

select * from cleaned.chemistry_events
-------Culture EVENTS-------------
insert into cleaned.culture_events (patient_date_id,LBronchGmSt ,SputumGmSt,LBronch,CSF,Other,Blood,Lung,Wound,RBronch,Urine,
Sputum,RBronchGmSt)
(
SELECT * FROM CROSSTAB(
  $$ 
  SELECT patient_date_id,culture_source ,result  FROM  public.culture_events 
  GROUP BY patient_date_id, culture_source, result ORDER BY patient_date_id,culture_source 
  $$,
  $$ 
  VALUES ('L Bronch Gm St'),('Sputum Gm St'),('L Bronch'),('CSF'),('Other'),('Blood'),('Lung'),('Wound'),('R Bronch'),
('Urine'),('Sputum'),('R Bronch Gm St')  $$ 
) AS CT(patient_date_id text, "L Bronch Gm St" text,"Sputum Gm St" text,"L Bronch" text,"CSF" text,"Other" text,
"Blood" text,"Lung" text,"Wound" text,"R Bronch" text,"Urine" text,"Sputum" text,
"R Bronch Gm St" text));


with culture as (
    select distinct patient_date_id,patient_id,time_event  from public.culture_events
)
update  cleaned.culture_events
set time_event = culture.time_event,
patient_id=culture.patient_id
from culture where
cleaned.culture_events.patient_date_id = culture.patient_date_id;

select * from cleaned.culture_events

-------Fluid balance EVENTS-------------
select * from public.fluid_balance_events;

update public.fluid_balance_events 
set fluid_name_type=fluid_name||'-'||fluid_type;

insert into cleaned.fluid_balance_events (patient_date_id ,Colloid_Intake,Crystalloid_Intake,
NonUrine_Output,Urine_Output,BloodProduct_Intake,Total_Intake)
(
SELECT * FROM CROSSTAB(
  $$ 
  SELECT patient_date_id, fluid_name_type, AVG(amount) FROM public.fluid_balance_events 
  GROUP BY patient_date_id, fluid_name_type ORDER BY patient_date_id, fluid_name_type
  $$,
  $$ 
  VALUES ('BloodProduct-Intake'), ('Colloid-Intake'), ('Crystalloid-Intake'), ('NonUrine-Output'), 
  ('Urine-Output'), ('Total-Intake')
  $$) AS CT(patient_date_id text, "BloodProduct-Intake" numeric, "Colloid-Intake" numeric, "Crystalloid-Intake" numeric,
"NonUrine-Output" numeric, "Urine-Output" numeric, "Total-Intake" numeric)
)

with fluid as (
    select distinct patient_date_id,patient_id, time_event_start,time_event_end from public.fluid_balance_events
)
update  cleaned.fluid_balance_events
set time_event_start = fluid.time_event_start,
time_event_end = fluid.time_event_end,
patient_id=fluid.patient_id
from fluid where
cleaned.fluid_balance_events.patient_date_id = fluid.patient_date_id;

select * from cleaned.fluid_balance_events;
-----hemo events
select * from public.hemo_events;

update public.hemo_events 
set measure_name_type=measurement_name||'-'||measurement_type;

insert into cleaned.hemo_events(patient_date_id,BPDiastolic_Average,BPDiastolic_High,BPDiastolic_Low,BPSystolic_Average,
BPSystolic_High,BPSystolic_Low,HeartRate_Average,HeartRate_High,HeartRate_Low,Temperature_Average,
Temperature_High,Temperature_Low,UrineOutput_High,UrineOutput_Low,UrineOutput_Total)
(
SELECT * FROM CROSSTAB(
  $$ 
  SELECT patient_date_id, measure_name_type, AVG(value) FROM  public.hemo_events
  GROUP BY patient_date_id, measure_name_type ORDER BY patient_date_id, measure_name_type
  $$,
  $$ 
  VALUES ('BPDiastolic-Average'),('BPDiastolic-High'),('BPDiastolic-Low'),('BPSystolic-Average'),
('BPSystolic-High'),('BPSystolic-Low'),('HeartRate-Average'),('HeartRate-High'),('HeartRate-Low'),
('Temperature-Average'),('Temperature-High'),('Temperature-Low'),('UrineOutput-High'),('UrineOutput-Low'),
('UrineOutput-Total') $$) AS CT (patient_date_id text,"BPDiastolic-Average" numeric,"BPDiastolic-High" numeric,
"BPDiastolic-Low" numeric,"BPSystolic-Average" numeric,"BPSystolic-High" numeric,"BPSystolic-Low" numeric,
"HeartRate-Average" numeric,"HeartRate-High" numeric,"HeartRate-Low" numeric,"Temperature-Average" numeric,
"Temperature-High" numeric,"Temperature-Low" numeric,"UrineOutput-High" numeric,
"UrineOutput-Low" numeric,"UrineOutput-Total" numeric));

with hemo as (
    select distinct patient_date_id,patient_id, time_event_start,time_event_end from public.hemo_events
)
update  cleaned.hemo_events
set time_event_start = hemo.time_event_start,
time_event_end = hemo.time_event_end,
patient_id=hemo.patient_id
from hemo where
cleaned.hemo_events.patient_date_id = hemo.patient_date_id;

select * from cleaned.hemo_events

----serology events


insert into cleaned.serology_events (patient_date_id,"abo/rh","anti-cmv","anti-hbc","anti-hbcab","anti-hcv","anti-hiv i/ii",
"anti-htlv i/ii","anti hbc","anti hcv","anti hiv 1 and 2","chagas","chagas nat","cmv","cmv igm","confirmatory - syphilis",
"ebna","ebv","ebv (vca) (igg)","ebv (vca) (igm)","ebv igg","ebv igm","ebv_igg","ebv_igm","hbc total",
"hbc_total_ab","hbcab igm","hbsab","hbsag","hbsag#","hbv dna","hbv nat","hbv_nat","hcv ab","hcv nat",
"hcv nat (tma)","hcv rna","hcv_ab","hcv_nat","hepatitis bc ab","hepatitis bs ag","hepatitis c ab",
"hiv","hiv-1 rna","hiv-1/hcv/hbv nat (ultrio)","hiv-1/hcv/hbv nat ultrio","hiv 1/2 plus o ab",
"hiv ag/ab combo","hiv ag/ab combo assay","hiv i/ii","hiv nat","hiv nat (tma)","hiv o eia",
"hiv_nat","htlv i/ii","htlv i/ii ab","htlv nat","htlv_i_ii","mhatp","nat hbv","nat hcv",
"nat hiv","other1","other2","other3","other4","other5","rpr","rpr#","rpr/vdrl","strongyloides",
"syphilis","toxo ab igg","toxo_igg","wnv","wnv nat","wnv rna"
)(
SELECT * FROM CROSSTAB(
  $$ 
  SELECT patient_date_id, lower(serology_name), result FROM public.serology_events 
  GROUP BY patient_date_id, lower(serology_name), result 
  ORDER BY patient_date_id, lower(serology_name)
  $$,
  $$ 
  VALUES ('abo/rh'), ('anti-cmv'), ('anti-hbc'), ('anti-hbcab'), ('anti-hcv'), 
  ('anti-hiv i/ii'), ('anti-htlv i/ii'), ('anti hbc'), ('anti hcv'), ('anti hiv 1 and 2'), 
  ('chagas'), ('chagas nat'), ('cmv'), ('cmv igm'), ('confirmatory - syphilis'), 
  ('ebna'), ('ebv'), ('ebv (vca) (igg)'), ('ebv (vca) (igm)'), ('ebv igg'), 
  ('ebv igm'), ('ebv_igg'), ('ebv_igm'), ('hbc total'), ('hbc_total_ab'), 
  ('hbcab igm'), ('hbsab'), ('hbsag'), ('hbsag#'), ('hbv dna'), 
  ('hbv nat'), ('hbv_nat'), ('hcv ab'), ('hcv nat'), ('hcv nat (tma)'), 
  ('hcv rna'), ('hcv_ab'), ('hcv_nat'), ('hepatitis bc ab'), ('hepatitis bs ag'), 
  ('hepatitis c ab'), ('hiv'), ('hiv-1 rna'), ('hiv-1/hcv/hbv nat (ultrio)'), 
  ('hiv-1/hcv/hbv nat ultrio'), ('hiv 1/2 plus o ab'), ('hiv ag/ab combo'), 
  ('hiv ag/ab combo assay'), ('hiv i/ii'), ('hiv nat'), ('hiv nat (tma)'), 
  ('hiv o eia'), ('hiv_nat'), ('htlv i/ii'), ('htlv i/ii ab'), ('htlv nat'), 
  ('htlv_i_ii'), ('mhatp'), ('nat hbv'), ('nat hcv'), ('nat hiv'), 
  ('other1'), ('other2'), ('other3'), ('other4'), ('other5'), 
  ('rpr'), ('rpr#'), ('rpr/vdrl'), ('strongyloides'), ('syphilis'), 
  ('toxo ab igg'), ('toxo_igg'), ('wnv'), ('wnv nat'), ('wnv rna')
  $$ 
) AS CT (patient_date_id text,  "abo/rh" text, "anti-cmv" text, "anti-hbc" text, "anti-hbcab" text, "anti-hcv" text,
  "anti-hiv i/ii" text, "anti-htlv i/ii" text, "anti hbc" text, "anti hcv" text, "anti hiv 1 and 2" text,
  "chagas" text, "chagas nat" text, "cmv" text, "cmv igm" text, "confirmatory - syphilis" text,
  "ebna" text, "ebv" text, "ebv (vca) (igg)" text, "ebv (vca) (igm)" text, "ebv igg" text,
  "ebv igm" text, "ebv_igg" text, "ebv_igm" text, "hbc total" text, "hbc_total_ab" text,
  "hbcab igm" text, "hbsab" text, "hbsag" text, "hbsag#" text, "hbv dna" text,
  "hbv nat" text, "hbv_nat" text, "hcv ab" text, "hcv nat" text, "hcv nat (tma)" text,
  "hcv rna" text, "hcv_ab" text, "hcv_nat" text, "hepatitis bc ab" text, "hepatitis bs ag" text,
  "hepatitis c ab" text, "hiv" text, "hiv-1 rna" text, "hiv-1/hcv/hbv nat (ultrio)" text,
  "hiv-1/hcv/hbv nat ultrio" text, "hiv 1/2 plus o ab" text, "hiv ag/ab combo" text, "hiv ag/ab combo assay" text,
  "hiv i/ii" text, "hiv nat" text, "hiv nat (tma)" text, "hiv o eia" text, "hiv_nat" text,
  "htlv i/ii" text, "htlv i/ii ab" text, "htlv nat" text, "htlv_i_ii" text, "mhatp" text,
  "nat hbv" text, "nat hcv" text, "nat hiv" text, "other1" text, "other2" text,
  "other3" text, "other4" text, "other5" text, "rpr" text, "rpr#" text,
  "rpr/vdrl" text, "strongyloides" text, "syphilis" text, "toxo ab igg" text, "toxo_igg" text,
  "wnv" text, "wnv nat" text, "wnv rna" text));
  
  
with serology as (
    select distinct patient_date_id,patient_id, time_event from cleaned.serology_events
)
update  cleaned.serology_events
set time_event = serology.time_event,
patient_id=serology.patient_id
from serology where
cleaned.serology_events.patient_date_id = serology.patient_date_id;

select * from cleaned.serology_events;


insert into cleaned.referrals
(select * from public.referrals);

insert into cleaned.calc_deaths
(select * from public.calc_deaths);

---Everything else 
update cleaned.referrals set
outcome_transplant=  (case when lower(outcome_heart) ='transplanted' then 1  else 0 end )+
(case when lower(outcome_liver) ='transplanted' then 1  else 0 end) + 
(case when lower(outcome_kidney_left) ='transplanted' then 1 else 0 end) +
(case when lower(outcome_kidney_right) ='transplanted' then 1 else 0 end) +
(case when lower(outcome_lung_left) ='transplanted' then 1 else 0 end) + 
(case when lower(outcome_lung_right) ='transplanted' then 1 else 0 end) +  
(case when lower(outcome_intestine) ='transplanted' then 1 else 0 end) + 
(case when lower(outcome_pancreas) ='transplanted' then 1 else 0 end) ;

update cleaned.referrals set
outcome_harvested=  (case when outcome_heart is not null then 1  else 0 end )+
(case when outcome_liver is not null then 1  else 0 end) + 
(case when outcome_kidney_left is not null then 1 else 0 end) +
(case when outcome_kidney_right is not null then 1 else 0 end) +
(case when outcome_lung_left is not null then 1 else 0 end) + 
(case when outcome_lung_right is not null then 1 else 0 end) +  
(case when outcome_intestine is not null then 1 else 0 end) + 
(case when outcome_pancreas is not null then 1 else 0 end) ;

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

