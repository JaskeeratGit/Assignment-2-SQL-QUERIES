SELECT u.usr
FROM users u
JOIN follows f ON u.usr = f.flwer
JOIN tweets t ON u.usr = t.writer
WHERE EXISTS (
    SELECT 1
    FROM includes i
    WHERE i.member = u.usr
)
