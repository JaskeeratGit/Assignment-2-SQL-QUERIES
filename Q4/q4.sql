SELECT users.usr, users.name
FROM tweets, users, follows

WHERE flwer =
(SELECT flwer 
from follows
where flwee = 
(SELECT flwee
from follows, users
where users.name = 'John Doe')
)

GROUP BY usr
HAVING COUNT(DISTINCT text) >= 2
