SELECT DISTINCT T1.writer AS usr
FROM tweets T1
LEFT JOIN tweets T2 ON T1.writer = T2.writer AND T2.text LIKE '%Edmonton%'
LEFT JOIN tweets T3 ON T1.writer = T3.writer AND T3.text LIKE '%Edmonton%'
LEFT JOIN follows F ON T1.writer = F.flwee
WHERE T1.text LIKE '%Edmonton%'
  AND T2.tdate <> T1.tdate
  AND T3.tdate <> T1.tdate
  AND F.flwer IS NULL;
