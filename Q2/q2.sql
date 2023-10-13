SELECT DISTINCT u1.usr
FROM users AS u1
JOIN follows AS f1 ON u1.usr = f1.flwer
JOIN users AS u2 ON u2.usr = f1.flwee
JOIN users AS johndoe ON LOWER(johndoe.name) = 'john doe'
LEFT JOIN follows AS f2 ON johndoe.usr = f2.flwer AND f2.flwee = u2.usr
WHERE f1.start_date <= date('now', '-90 days')
  AND (f2.start_date > date('now', '-90 days'))
