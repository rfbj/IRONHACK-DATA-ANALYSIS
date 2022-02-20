CREATE TEMPORARY TABLE min_coins
SELECT min(coins_needed) as coins_needed
            ,power,age
FROM wands 
INNER JOIN wands_property ON wands.code=wands_property.code
WHERE is_evil = 0
GROUP BY power,age
ORDER BY power desc,age desc;

SELECT
*
FROM
min_coins;

SELECT
wands.id,
min_coins.*
FROM
wands 
JOIN  wands_property ON wands.code=wands_property.code
JOIN min_coins ON wands.power = min_coins.power AND wands_property.age = min_coins.age AND wands.coins_needed=min_coins.coins_needed
ORDER BY power desc, age desc;
