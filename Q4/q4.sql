SELECT users.usr, users.name
FROM tweets, users, follows

WHERE usr =
(SELECT flwer 
from follows
where flwee = 
(SELECT flwee
from follows
where flwer = 
(SELECT usr
FROM users
WHERE name = 'John Doe')
)
)

GROUP BY usr
HAVING COUNT(DISTINCT text) >= 2

EXCEPT 

SELECT usr, name
FROM users
WHERE users.name = 'John Doe'
