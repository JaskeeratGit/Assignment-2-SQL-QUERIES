WITH JohnDoeUsers AS 
(
    SELECT usr
    FROM users
    WHERE LOWER(name) = 'john doe'
),
JohnDoeFollowers AS 
(
    SELECT DISTINCT f.flwer, u.usr
    FROM follows AS f
    JOIN JohnDoeUsers AS u ON f.flwee = u.usr
),
ListMembers AS (
    SELECT i.lname, u.usr
    FROM includes AS i
    JOIN users AS u ON LOWER(i.member) = LOWER(u.usr)
),
ListMemberCounts AS 
(
    SELECT li.lname, COUNT(inc.member) AS member_count
    FROM lists AS li
    LEFT JOIN includes AS inc ON li.lname = inc.lname
    GROUP BY li.lname
),
ListFollowerCounts AS
(
    SELECT lm.lname, COUNT(DISTINCT CASE WHEN jdf.flwer IS NOT NULL THEN lm.usr END) AS follower_count
    FROM ListMembers AS lm
    LEFT JOIN JohnDoeFollowers AS jdf ON lm.usr = jdf.flwer
    GROUP BY lm.lname
)

SELECT lfc.lname
FROM ListMemberCounts AS lmc
JOIN ListFollowerCounts AS lfc ON lmc.lname = lfc.lname
WHERE lmc.member_count > 6
  AND lfc.follower_count >= 0.5 * lmc.member_count;
