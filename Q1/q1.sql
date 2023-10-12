
select  distinct usr 
from users

intersect 

select distinct writer
from tweets

intersect 

select distinct flwer
from follows 

intersect 

select distinct owner 
from lists;