/*
Find the average medical claim of each user

*/

medical_data = load '/home/hduser/Desktop/pig/analysis/data/medical' using PigStorage() as (name:chararray,dept:chararray,claim:double);

user_data = group medical_data by name;

avg_claim = foreach user_data generate group,ROUND_TO(AVG(medical_data.claim),2);

dump avg_claim;
