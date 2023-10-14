WITH MonthlyTweetCounts AS (
    SELECT
        strftime('%m', tdate) AS month,
        SUM(CASE WHEN replyto_w IS NULL THEN 1 ELSE 0 END) AS tcnt,
        SUM(CASE WHEN replyto_w IS NOT NULL THEN 1 ELSE 0 END) AS rep_cnt
    FROM
        tweets
    WHERE
        strftime('%Y', tdate) = '2023'
    GROUP BY
        month
),
MonthlyRetweetCounts AS (
    SELECT
        strftime('%m', rdate) AS month,
        COUNT(*) AS ret_cnt
    FROM
        retweets
    WHERE
        strftime('%Y', rdate) = '2023'
    GROUP BY
        month
)
SELECT
    COALESCE(MTC.month, MRC.month) AS month,
    COALESCE(tcnt, 0) AS tcnt,
    COALESCE(rep_cnt, 0) AS rep_cnt,
    COALESCE(ret_cnt, 0) AS ret_cnt,
    COALESCE(tcnt, 0) + COALESCE(rep_cnt, 0) + COALESCE(ret_cnt, 0) AS total
FROM
    MonthlyTweetCounts MTC
FULL OUTER JOIN
    MonthlyRetweetCounts MRC ON MTC.month = MRC.month
WHERE
    (tcnt > 0 OR rep_cnt > 0)
ORDER BY
    month;
