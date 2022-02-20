SELECT
id,
age,
coins_needed,
power
FROM
(SELECT
id,
coins_needed,
power,
age,
MIN(coins_needed) OVER(PARTITION BY power,age) AS min_coins
FROM
wands 
JOIN  wands_property ON wands.code=wands_property.code
WHERE is_evil=0
ORDER BY power desc,age desc) AS A
WHERE coins_needed = min_coins;
