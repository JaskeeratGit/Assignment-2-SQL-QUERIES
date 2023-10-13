select flwer
from follows
where DATE('now','-90 day') <= start_date

intersect

select flwee
from follows, users 
Where users.name = 'John Doe' and DATE('now','-90 day') >= start_date
