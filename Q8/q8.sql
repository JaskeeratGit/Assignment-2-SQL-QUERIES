WITH MonthlyTweetCounts AS (
    SELECT
        strftime('%Y-%m', tdate) AS month,
        SUM(CASE WHEN replyto_w IS NULL THEN 1 ELSE 0 END) AS tweets_with_null_reply,
        SUM(CASE WHEN replyto_w IS NOT NULL THEN 1 ELSE 0 END) AS replies
    FROM
        tweets
    WHERE
        strftime('%Y', tdate) = '2023'
    GROUP BY
        month
),
MonthlyRetweetCounts AS (
    SELECT
        strftime('%Y-%m', rdate) AS month,
        COUNT(*) AS retweets
    FROM
        retweets
    WHERE
        strftime('%Y', rdate) = '2023'
    GROUP BY
        month
)
SELECT
    COALESCE(MTC.month, MRC.month) AS month,
    COALESCE(tweets_with_null_reply, 0) AS tweets_with_null_reply,
    COALESCE(replies, 0) AS replies,
    COALESCE(retweets, 0) AS retweets,
    COALESCE(tweets_with_null_reply, 0) + COALESCE(replies, 0) + COALESCE(retweets, 0) AS total
FROM
    MonthlyTweetCounts MTC
LEFT JOIN
    MonthlyRetweetCounts MRC ON MTC.month = MRC.month
WHERE
    MTC.month IS NOT NULL OR MRC.month IS NOT NULL
ORDER BY
    month;
