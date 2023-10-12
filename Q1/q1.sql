select distinct owner 
from lists

INTERSECT

SELECT distinct usr
from retweets

UNION

SELECT distinct writer
from tweets

INTERSECT

select  distinct usr 
from users

intersect 

select distinct writer
from tweets

intersect 

select distinct flwer
from follows;
