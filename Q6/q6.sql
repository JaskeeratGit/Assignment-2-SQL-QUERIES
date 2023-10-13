WITH TweetRetweetCounts AS (
    SELECT
        t.writer AS writer_id,
        t.tdate AS tweet_date,
        t.text AS tweet_text,
        COUNT(rt.writer) AS retweet_count
    FROM
        tweets AS t
    LEFT JOIN
        retweets AS rt
    ON
        t.writer = rt.writer AND t.tdate = rt.tdate
    GROUP BY
        t.writer, t.tdate, t.text
)

SELECT
    writer_id,
    tweet_date,
    tweet_text
FROM (
    SELECT
        writer_id,
        tweet_date,
        tweet_text,
        RANK() OVER (ORDER BY retweet_count DESC) AS retweet_rank
    FROM TweetRetweetCounts
) RankedTweets
WHERE
    retweet_rank <= 3;
