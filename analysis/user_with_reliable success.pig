/*

find the name of user with reliable succedds rate 

reliable succedds rate is the success rate greater than 90%
*/

weblog = load '/home/hduser/Desktop/pig/analysis/data/weblog' using PigStorage() as (name:chararray,bank:chararray,time:float);

gateway = load '/home/hduser/Desktop/pig/analysis/data/gateway' using PigStorage() as (bank:chararray,rate:double);


join_data = join webloy by $1,gateway by $0;

data = foreach join_data generate $0 as name,$1 as bank,$4 as rate;

group_data = group data by name;

result = foreach group_data generate group,ROUND_TO(AVG(data.rate),2) as average;

final = filter result by average >90;

dump final;

/*
output:

(john,91.75)

*/
