select flwer
from follows
where DATE('now','-90 day') <= start_date

INTERSECT


select flwee 
from follows 
where flwer = (select usr
from users 
where users.name = 'John Doe');
