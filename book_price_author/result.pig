 book = load '/home/hduser/Desktop/pig/book_price_author/book-data' using PigStorage(',') as (book_id,price:double,author_id);

describe book;

author = load '/home/hduser/Desktop/pig/book_price_author/author-data' using PigStorage(',') as (author_id,author_name:chararray);


describe author;


filtered_author = filter author by SUBSTRING(author_name,0,1)=='J';

filtered_book = filter book by price >=200;

joined_data = join filtered_author by author_id,filtered_book by author_id;

 dump joined_data;

 final_result = foreach joined_data generate $0,$1,$2,$3;

describe final_result;

dump final_result;

(10,John,100,200.0)
(60,Justin,600,300.0)



