WITH MonthlyTweetStats AS (
    SELECT
        strftime('%Y-%m', t.tdate) AS month,
        COUNT(CASE WHEN t.replyto_w IS NULL THEN 1 ELSE NULL END) AS tweets_with_null_reply,
        COUNT(CASE WHEN t.replyto_w IS NOT NULL THEN 1 ELSE NULL END) AS replies,
        COUNT(r.usr) AS retweets
    FROM
        tweets t
    LEFT JOIN
        retweets r ON t.writer = r.writer AND t.tdate = r.tdate
    WHERE
        strftime('%Y', t.tdate) = '2023'
    GROUP BY
        month
)

SELECT
    month,
    COALESCE(tweets_with_null_reply, 0) AS tweets_with_null_reply,
    COALESCE(replies, 0) AS replies,
    COALESCE(retweets, 0) AS retweets,
    COALESCE(tweets_with_null_reply, 0) + COALESCE(replies, 0) + COALESCE(retweets, 0) AS total
FROM
    MonthlyTweetStats
ORDER BY
    month;
