/*

Find the max stock variance 
*/


data = load '/home/hduser/Desktop/pig/NYSE/NYSE.csv' using PigStorage(',') as (exchangeName:chararray,stock_symbol:chararray,stock_date:datetime,stock_price_open:double,stock_price_high:double,stock_price_low:double,stock_price_close:double,stock_volume:long,stock_price_adj_close:double);

A = foreach data generate stock_symbol,((stock_price_high-stock_price_low)*100/stock_price_low) as variance;
--describe A;

B = group A by stock_symbol;
--describe B;

C = foreach B generate group,MAX(A.variance);
--describe C;

D = order C by $0;
dump D;


















