SELECT flwee
FROM users, follows
WHERE users.name = 'John Doe'
and DATE('now', '-90 day') < start_date
AND flwer = usr

INTERSECT

SELECT flwee
FROM follows
WHERE DATE('now', '-90 day') >= start_date;

