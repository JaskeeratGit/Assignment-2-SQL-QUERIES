WITH MonthlyTweetCounts AS (
    SELECT
        strftime('%m', tdate) AS month,
        COUNT(CASE WHEN replyto_w IS NULL THEN 1 ELSE NULL END) AS tcnt,
        COUNT(CASE WHEN replyto_w IS NOT NULL THEN 1 ELSE NULL END) AS rep_cnt
    FROM
        tweets
    WHERE
        strftime('%Y', tdate) = '2023'
    GROUP BY
        month
),
MonthlyRetweetCounts AS (
    SELECT
        strftime('%m', tdate) AS month,
        COUNT(*) AS ret_cnt
    FROM
        retweets
    WHERE
        strftime('%Y', tdate) = '2023'
    GROUP BY
        month
)
SELECT
    MT.month AS month,
    COALESCE(tcnt, 0) AS tcnt,
    COALESCE(rep_cnt, 0) AS rep_cnt,
    COALESCE(ret_cnt, 0) AS ret_cnt,
    COALESCE(tcnt, 0) + COALESCE(rep_cnt, 0) + COALESCE(ret_cnt, 0) AS total
FROM
    (SELECT DISTINCT month FROM MonthlyTweetCounts
    UNION
    SELECT DISTINCT month FROM MonthlyRetweetCounts) AS MT
LEFT JOIN
    MonthlyTweetCounts MTC ON MT.month = MTC.month
LEFT JOIN
    MonthlyRetweetCounts MRC ON MT.month = MRC.month
ORDER BY
    month;
