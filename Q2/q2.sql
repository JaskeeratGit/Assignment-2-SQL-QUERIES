SELECT flwee
FROM users, follows
WHERE users.name = 'John Doe'
and DATE('now', '-90 day') < start_date


INTERSECT

SELECT flwer
FROM follows
WHERE DATE('now', '-90 day') >= start_date;

