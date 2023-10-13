SELECT DISTINCT writer
FROM tweets

INTERSECT

-- Users with followers
SELECT DISTINCT flwee
FROM follows

INTERSECT

-- Users who are members of at least one list
SELECT DISTINCT member
FROM includes;
