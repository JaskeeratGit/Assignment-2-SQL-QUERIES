SELECT t.writer AS user_id, t.text AS tweet_text, t.tdate AS tweet_date
FROM tweets t
JOIN retweets r ON t.writer = r.writer AND t.tdate = r.tdate
JOIN follows f ON r.usr = f.flwer
GROUP BY t.writer, t.text, t.tdate
HAVING COUNT(DISTINCT f.flwer) >= 3;
