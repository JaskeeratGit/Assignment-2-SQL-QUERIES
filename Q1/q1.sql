
select usr 
from users

intersect 

select writer
from tweets

intersect 

select flwer
from follows 

intersect 

select owner 
from lists;
