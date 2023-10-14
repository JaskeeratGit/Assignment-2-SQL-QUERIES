CREATE VIEW tStat AS
SELECT
    T.writer,
    T.tdate,
    T.text,
    COALESCE(C.rep_cnt, 0) AS rep_cnt,
    COALESCE(R.ret_cnt, 0) AS ret_cnt,
    COALESCE(M.sim_cnt, 0) AS sim_cnt
FROM tweets T
LEFT JOIN (
    SELECT
        writer,
        tdate,
        COUNT(*) AS rep_cnt
    FROM tweets
    WHERE replyto_w IS NOT NULL AND replyto_d IS NOT NULL
    GROUP BY writer, tdate
) C ON T.writer = C.writer AND T.tdate = C.tdate
LEFT JOIN (
    SELECT
        writer,
        tdate,
        COUNT(*) AS ret_cnt
    FROM retweets
    GROUP BY writer, tdate
) R ON T.writer = R.writer AND T.tdate = R.tdate
LEFT JOIN (
    SELECT
        T.writer,
        T.tdate,
        COUNT(*) AS sim_cnt
    FROM tweets T
    WHERE EXISTS (
        SELECT 1
        FROM mentions M
        WHERE T.writer = M.writer
          AND T.tdate = M.tdate
          AND M.term IN (
              SELECT DISTINCT term
              FROM hashtags
          )
    )
    GROUP BY T.writer, T.tdate
) M ON T.writer = M.writer AND T.tdate = M.tdate;
SELECT * from tstat;
