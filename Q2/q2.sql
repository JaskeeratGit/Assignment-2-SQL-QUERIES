select flwer
from follows
where DATE('now','-90 day') <= start_date

INTERSECT


select flwee 
from follows, users
where flwer = users.usr and name = 'John Doe' and DATE('now','-90 day') > start_date
