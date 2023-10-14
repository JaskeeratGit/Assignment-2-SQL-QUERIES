WITH FollowersCount AS (
    SELECT
        flwee AS usr,
        COUNT(*) AS follower_count
    FROM follows
    GROUP BY flwee
),
RetweetsAverage AS (
    SELECT
        writer AS usr,
        AVG(ret_cnt) AS avg_retweets
    FROM tStat
    GROUP BY writer
)

SELECT
    U.usr,
    CASE
        WHEN F.follower_count = (SELECT MAX(follower_count) FROM FollowersCount) THEN 'top in followers'
        WHEN R.avg_retweets = (SELECT MAX(avg_retweets) FROM RetweetsAverage) THEN 'top in retweets'
        ELSE ''
    END AS top_status
FROM users U
LEFT JOIN FollowersCount F ON U.usr = F.usr
LEFT JOIN RetweetsAverage R ON U.usr = R.usr
WHERE top_status = 'top in followers' OR top_status = 'top in retweets';
