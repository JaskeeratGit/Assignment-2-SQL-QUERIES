SELECT flwer,flwee
FROM follows
WHERE DATE('now','-90 day') >= start_date

INTERSECT

SELECT flwer, flwee
FROM follows, users
WHERE DATE('now','-90 day') < start_date AND users.name = 'John Doe'
