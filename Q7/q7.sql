WITH JohnDoeFollowers AS (
    SELECT DISTINCT f.flwer
    FROM users AS u
    JOIN follows AS f ON u.usr = f.flwer
    WHERE LOWER(u.name) = 'john doe'
),
ListMembersCount AS (
    SELECT li.lname, COUNT(*) AS member_count
    FROM lists AS li
    JOIN includes AS inc ON li.lname = inc.lname
    GROUP BY li.lname
),
ListFollowersCount AS (
    SELECT li.lname, COUNT(DISTINCT f.flwer) AS follower_count
    FROM lists AS li
    JOIN includes AS inc ON li.lname = inc.lname
    JOIN follows AS f ON inc.member = f.flwee
    GROUP BY li.lname
)
SELECT lfc.lname
FROM ListMembersCount AS lmc
JOIN ListFollowersCount AS lfc ON lmc.lname = lfc.lname
WHERE lmc.member_count > 6
  AND lfc.follower_count >= (0.5 * lmc.member_count)
