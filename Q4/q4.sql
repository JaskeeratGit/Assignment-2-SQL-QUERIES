SELECT U.usr, U.name
FROM users U
WHERE NOT EXISTS (
    SELECT DISTINCT F2.flwee
    FROM follows F2
    WHERE F2.flwer = (
        SELECT usr
        FROM users
        WHERE LOWER(name) = 'john doe'
    )
    EXCEPT
    SELECT F3.flwee
    FROM follows F3
    WHERE F3.flwer = U.usr
)

INTERSECT

SELECT u.usr, u.name
FROM users u
WHERE u.usr IN (
    SELECT writer
    FROM tweets
    GROUP BY writer
    HAVING COUNT(DISTINCT text) >= 2
)

EXCEPT

SELECT usr, name
FROM users
WHERE lower(name) = 'john doe'
;
