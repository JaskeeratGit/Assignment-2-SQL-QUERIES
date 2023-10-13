SELECT writer 
FROM tweets
WHERE text LIKE '%Edmonton%'

EXCEPT

SELECT flwee
FROM follows;
