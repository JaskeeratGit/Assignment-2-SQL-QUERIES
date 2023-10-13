
SELECT u.usr, u.name
FROM users AS u
WHERE (
    SELECT COUNT(DISTINCT t.tdate)
    FROM tweets AS t
    WHERE t.writer = u.usr
) >= 2
AND NOT EXISTS (
    SELECT f.flwee
    FROM follows AS f
    WHERE LOWER(f.flwer) = 'john doe'
    EXCEPT
    SELECT f1.flwee
    FROM follows AS f1
    WHERE f1.flwer = u.usr
);
