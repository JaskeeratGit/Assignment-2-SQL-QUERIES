WITH MonthlyActivity AS (
    SELECT
        strftime('%m', month) AS month,
        SUM(tcnt) AS tcnt,
        SUM(rep_cnt) AS rep_cnt,
        SUM(ret_cnt) AS ret_cnt
    FROM
        (SELECT strftime('%m', tdate) AS month, COUNT(*) AS tcnt, 0 AS rep_cnt, 0 AS ret_cnt
         FROM tweets
         WHERE strftime('%Y', tdate) = '2023'
         GROUP BY month
         UNION ALL
         SELECT strftime('%m', rdate) AS month, 0 AS tcnt, 0 AS rep_cnt, COUNT(*) AS ret_cnt
         FROM retweets
         WHERE strftime('%Y', rdate) = '2023'
         GROUP BY month)
    GROUP BY month
)
SELECT
    month,
    tcnt,
    rep_cnt,
    ret_cnt,
    (tcnt + rep_cnt + ret_cnt) AS total
FROM MonthlyActivity
WHERE (tcnt > 0 OR rep_cnt > 0)
ORDER BY month;
