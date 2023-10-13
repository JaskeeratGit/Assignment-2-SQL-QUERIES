SELECT u.usr, u.name
FROM users u
WHERE u.usr IN (
    SELECT writer
    FROM tweets
    GROUP BY writer
    HAVING COUNT(DISTINCT text) >= 2
)

INTERSECT

SELECT u.usr, u.name
FROM users u
WHERE NOT EXISTS (
    SELECT usr
    FROM users j
    WHERE LOWER(j.name) = 'john doe'
    AND NOT EXISTS (
        SELECT flwee
        FROM follows f
        WHERE f.flwer = u.usr
        AND f.flwee = j.usr
    )
);
