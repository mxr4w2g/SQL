WITH NumberCTE AS (
  SELECT 1 AS Number
  UNION ALL
  SELECT Number + 1
  FROM NumberCTE
  WHERE Number < 10
)
SELECT Number
FROM NumberCTE;
