CREATE VIEW tStat AS
SELECT
    T.writer,
    T.tdate,
    T.text,
    COALESCE(Replies.rep_cnt, 0) AS rep_cnt,
    COALESCE(Retweets.ret_cnt, 0) AS ret_cnt,
    COALESCE(Mentions.sim_cnt, 0) AS sim_cnt
FROM tweets T
LEFT JOIN (
    SELECT
        replyto_w AS writer,
        replyto_d AS tdate,
        COUNT(*) AS rep_cnt
    FROM tweets
    GROUP BY replyto_w, replyto_d
) AS Replies ON T.writer = Replies.writer AND T.tdate = Replies.tdate
LEFT JOIN (
    SELECT
        writer,
        tdate,
        COUNT(*) AS ret_cnt
    FROM retweets
    GROUP BY writer, tdate
) AS Retweets ON T.writer = Retweets.writer AND T.tdate = Retweets.tdate
LEFT JOIN (
    SELECT
        writer,
        tdate,
        COUNT(DISTINCT term) AS sim_cnt
    FROM mentions
    WHERE term IN (SELECT DISTINCT term FROM hashtags)
    GROUP BY writer, tdate
) AS Mentions ON T.writer = Mentions.writer AND T.tdate = Mentions.tdate;
