-- data check
SELECT COUNT(*), MIN(Loss), MAX(Loss), AVG(Loss), MIN(Date), MAX(Date)
FROM claims;

-- claims per year
SELECT strftime('%Y', Date) AS Year,
       COUNT(*) AS n_claims,
       SUM(Loss) AS total_loss
FROM claims
GROUP BY Year
ORDER BY Year;

-- how many claims are big?
SELECT SUM(Loss > 5)  AS above_5,
       SUM(Loss > 10) AS above_10,
       SUM(Loss > 20) AS above_20
FROM claims;

-- reinsurer recoveries per year, for three layers
-- Layer A = 5 xs 5, Layer B = 10 xs 10, Layer C = 20 xs 20
SELECT strftime('%Y', Date) AS Year,
       COUNT(*) AS n_claims,
       SUM(Loss > 5)  AS hits_A,
       SUM(MIN(MAX(Loss - 5, 0), 5))    AS rec_A,
       SUM(Loss > 10) AS hits_B,
       SUM(MIN(MAX(Loss - 10, 0), 10))  AS rec_B,
       SUM(Loss > 20) AS hits_C,
       SUM(MIN(MAX(Loss - 20, 0), 20))  AS rec_C
FROM claims
GROUP BY Year
ORDER BY Year;