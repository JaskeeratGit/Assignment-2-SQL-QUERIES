select owner 
from lists

INTERSECT

SELECT usr
from retweets

UNION

SELECT writer
from tweets

INTERSECT

select usr 
from users

intersect 

select writer
from tweets

intersect 

select flwer
from follows;
