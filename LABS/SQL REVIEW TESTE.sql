/* CREATE VIEW i_hate_hermione AS
SELECT w.id, wp.age, w.coins_needed, w.power
FROM wands as w
JOIN wands_property as wp ON w.code = wp.code
WHERE wp.is_evil = 0
ORDER BY w.power DESC, wp.age DESC, w.coins_needed DESC;
*/

SELECT
id, age, coins_needed, power
FROM i_hate_hermione
WHERE min(coins_needed)
ORDER BY power desc, age desc;