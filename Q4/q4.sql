SELECT u.usr, u.name
FROM users u
WHERE u.usr != (SELECT usr FROM users WHERE LOWER(name) = 'john doe') -- Exclude John Doe
AND u.usr IN (
    SELECT DISTINCT t1.writer
    FROM tweets t1
    WHERE t1.writer <> (SELECT usr FROM users WHERE LOWER(name) = 'john doe') -- Exclude John Doe
    AND t1.writer IN (
        SELECT DISTINCT t2.writer
        FROM tweets t2
        WHERE t2.writer <> (SELECT usr FROM users WHERE LOWER(name) = 'john doe') -- Exclude John Doe
    )
)
AND u.usr IN (
    SELECT f.flwer
    FROM follows f
    WHERE f.flwee = (SELECT usr FROM users WHERE LOWER(name) = 'john doe') -- John Doe's followers
);
