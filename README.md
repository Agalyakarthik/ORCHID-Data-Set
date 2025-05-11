# ORCHID-Data-Set
Organ Retrieval and Collection of Health Information for Donation (ORCHID)

Project Overview
This repository contains data analysis for improving the organ procurement process in the United States. By analyzing data from six Organ Procurement Organizations (OPOs), this project aims to identify actionable changes that can increase both the efficiency and equity of organ donation, ultimately expanding transplant opportunities for patients in need.

Why This Matters
More than 100,000 patients are currently waiting for organ transplants in the United States. Improvements to the organ procurement process can significantly increase the supply of this scarce public resource and improve health outcomes for those waiting.

Dataset Description
Data Source

Collection period: January 1, 2015 to December 31, 2021
Data collected from health information technology systems used by six OPOs
Dataset includes 133,101 deceased donor referrals across 13 states
Coverage by OPO:

OPO 1: 32,148 potential donors
OPO 2: 16,144 potential donors
OPO 3: 12,516 potential donors
OPO 4: 33,641 potential donors
OPO 5: 15,738 potential donors
OPO 6: 22,914 potential donors

The Organ Procurement Process
The dataset tracks six critical steps in the organ procurement process:

Referral (133,101 patients)

Hospital refers near-death patient to local OPO


Evaluation

OPO assesses patient's suitability for donation


Approach (19,551 patients, 14.68%)

If medically suitable, OPO representative approaches next-of-kin for consent


Authorization (11,989 patients, 9%)

Next-of-kin provides consent for donation


Procurement (9,502 patients, 7.13%)

OPO procures viable organs and offers them to patients on the national transplant waitlist


Transplant (8,972 patients, 6.7%)

OPO coordinates logistics to transport organs to transplant centers

Data Tables
All tables are linked via a unique PatientID and fall into three categories:
OPO Referrals

Patient demographics
Cause of death
Process timestamps (next-of-kin approach, authorization, procurement)
Time of death (asystole and brain death if applicable)
Outcomes (approached, authorized, procured, transplanted)

OPO Events

ChemistryEvents: Lab test results including kidney panel, liver function tests, electrolyte panel
CBCEvents: Complete blood count test results
ABGEvents: Arterial blood gas measurements with ventilator settings
SerologyEvents: Testing for donation-relevant antigens and antibodies (HIV, hepatitis C, etc.)
CultureEvents: Infection test results for blood, urine, and other fluids
HemoEvents: Hemodynamic measurements (blood pressure, heart rate)
FluidBalanceEvents: Fluid intake, urine output

OPO Deaths

Details on patient deaths and donation outcomes

Project Goals
This repository aims to:

Identify opportunities to improve current organ procurement practices
Improve both efficiency and equity in the organ donation process

Note
There is a data discrepancy where 27 records show Approached=False but Authorized=True.
