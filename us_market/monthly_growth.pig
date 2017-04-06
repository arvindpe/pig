year2000 =load '/home/hduser/Desktop/pig/us_market/2000.txt' using PigStorage(',') as (productid,product,jan:double,feb:double,mar:double,april:double,may:double,jun:double,jully:double,aug:double,sept:double,oct:double,nov:double,dec:double);

year2001 =load '/home/hduser/Desktop/pig/us_market/2001.txt' using PigStorage(',') as (cat_id,cat_name,jan:double,feb:double,mar:double,april:double,may:double,jun:double,jully:double,aug:double,sept:double,oct:double,nov:double,dec:double);

year2002 =load '/home/hduser/Desktop/pig/us_market/2002.txt' using PigStorage(',') as (cat_id,cat_name,jan:double,feb:double,mar:double,april:double,may:double,jun:double,jully:double,aug:double,sept:double,oct:double,nov:double,dec:double);


group2000 = group year2000 all;

group2001 = group year2001 all;

group2002 = group year2002 all;

--group2000: {group: chararray,year2000: {(productid: bytearray,product: bytearray,jan: double,feb: double,mar:double,apr:double,
--may: double,jun: double,jully: double,aug: double,sept: double,oct: double,nov: double,dec: double)}}


monthly_sale0 = foreach group2000 generate SUM(year2000.jan) as jantotal,SUM(year2000.feb) as febtotal,SUM(year2000.mar) as martotal,SUM(year2000.april) as aprtotal,SUM(year2000.may) as maytotal,SUM(year2000.jun) as juntotal,SUM(year2000.jully) as jultotal,SUM(year2000.aug) as augtotal,SUM(year2000.sept) as septotal,SUM(year2000.oct) as octtotal,SUM(year2000.nov) as novtotal,SUM(year2000.dec) as dectotal;


monthly_sale1 = foreach group2001 generate SUM(year2001.jan) as jantotal,SUM(year2001.feb) as febtotal,SUM(year2001.mar) as martotal,SUM(year2001.april) as aprtotal,SUM(year2001.may) as maytotal,SUM(year2001.jun) as juntotal,SUM(year2001.jully) as jultotal,SUM(year2001.aug) as augtotal,SUM(year2001.sept) as septotal,SUM(year2001.oct) as octtotal,SUM(year2001.nov) as novtotal,SUM(year2001.dec) as dectotal;


monthly_sale2 = foreach group2002 generate SUM(year2002.jan) as jantotal,SUM(year2002.feb) as febtotal,SUM(year2002.mar) as martotal,SUM(year2002.april) as aprtotal,SUM(year2002.may) as maytotal,SUM(year2002.jun) as juntotal,SUM(year2002.jully) as jultotal,SUM(year2002.aug) as augtotal,SUM(year2002.sept) as septotal,SUM(year2002.oct) as octtotal,SUM(year2002.nov) as novtotal,SUM(year2002.dec) as dectotal;

bag2000 = foreach monthly_sale0 generate FLATTEN(TOBAG(*));
bag0 = rank bag2000;

bag2001 = foreach monthly_sale1 generate FLATTEN(TOBAG(*));
bag1 = rank bag2001;

bag2002 = foreach monthly_sale2 generate FLATTEN(TOBAG(*));
bag2 = rank bag2002;

detailsale = join bag0 by $0, bag1 by $0, bag2 by $0;
detailed_sale = foreach detailsale generate $0,$1,$3,$5,ROUND_TO((($3-$1)*100/$1),2),ROUND_TO((($5-$3)*100/$3),2);

avg_growth = foreach detailed_sale generate $0,$1,$2,$3,$4,$5,ROUND_TO((($4+$5)/2),2);

order_growth = order avg_growth by $6 desc;

dump order_growth;

