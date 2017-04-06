data = load '/home/hduser/niit2.txt' using PigStorage() as (lines:chararray);

REGISTER /home/hduser/func1.jar;

DEFINE LowerToUpper pigUDf.UPPER();

result = foreach data generate LowerToUpper(lines);

dump result;
