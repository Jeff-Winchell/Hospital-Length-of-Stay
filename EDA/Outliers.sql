-- These columns are all nullable
select * From Hospital..patient_summary where edtimebeforeadmission<0 -- get rid of one that is <-1
select * From Hospital..patient_summary where meanTemperaturePast12months>46.5 --Probably are readings recorded in Fahrenheit for very low body temperatures
select * From Hospital..patient_summary where maxTemperaturePast12months>46.5  --Definitely are readings recorded in Fahrenheit
select * From Hospital..patient_summary where lastTemperaturePast12months>46.5 --Definitely are readings recorded in Fahrenheit
Select * From Hospital..patient_summary where bmi<7.5 or bmi>185.5 -- throw out
Select * From Hospital..patient_summary where firstDiastolicBPReadingInED>370 --throw out