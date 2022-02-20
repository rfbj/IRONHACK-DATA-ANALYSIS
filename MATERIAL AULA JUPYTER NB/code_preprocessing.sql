-- WHERE is the filter structure, can be used with >, <, =>,<=,<>,!=,BETWEEN,LIKE, REGEXP as well as using multiple conditions with AND/OR
SELECT
	`card_id` AS ID
	,type
FROM card AS c
WHERE card_id<1000 AND card_id >500;

SELECT
	`card_id` AS ID
	,type
FROM card AS c
WHERE card_id BETWEEN 500 AND 1000 AND type = 'junior';

SELECT DISTINCT
	-- `card_id` AS ID
	type
FROM card AS c
WHERE type LIKE '%o%';

SELECT DISTINCT
	-- `card_id` AS ID
	type
FROM card AS c
WHERE type LIKE '_o%';

SELECT DISTINCT
	-- `card_id` AS ID
	type
FROM card AS c
WHERE type REGEXP '^[a-g]';
-- In the SELECT statement we can use several columns calculations 
-- text REPLACE, REGEX_REPLACE, lenght, concat, lower, upper, left, right, substring documentation https://dev.mysql.com/doc/refman/8.0/en/string-functions.html
-- numeric count, AVG, floor, ceiling, MAX, MIN, round and numeric operations +,-,/,* https://dev.mysql.com/doc/refman/8.0/en/numeric-functions.html
-- date functions https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html

SELECT 
	REGEXP_REPLACE(type,'[a-g]','aaargh')
FROM card AS c;

SELECT 
	length(A3)
    ,A3 AS regiao
    ,A4
    ,concat(A3,' ', A4)
    ,lower(A3)
    ,upper(A3)
    ,left(A3,2)
    ,right(A3,3)
    ,substring(A3,2,4) 
FROM district AS c;


SELECT 
	count(amount)
    , AVG(amount)
    , MAX(amount)
    , MIN(amount)
FROM `order`;


SELECT 
	amount
    , round((amount/3), 4) AS round
    , floor((amount/3)) AS floor
    , ceiling((amount/3)) AS ceiling
FROM `order`;

SELECT 
	amount/3
    ,bank_to
    , round((amount/3), -3) AS round
    , floor((amount/3)) AS floor
    , ceiling((amount/3)) AS ceiling
FROM `order`
WHERE bank_to REGEXP('[N-Z]');

-- LIMIT(how many lines you get) AND OFFSET (line to start)
SELECT 
	amount/3
    ,bank_to
    , round((amount/3), -3) AS round
    , floor((amount/3)) AS floor
    , ceiling((amount/3)) AS ceiling
FROM `order`
WHERE not bank_to REGEXP('[N-Z]')
LIMIT 2 OFFSET 3;

-- ORDER BY can be ASC(lower to bigger) or DESC (bigger to lower) and have multiple columns

SELECT 
	amount/3
    ,bank_to
    , round((amount/3), -3) AS round
    , floor((amount/3)) AS floor
    , ceiling((amount/3)) AS ceiling
FROM `order`
WHERE not bank_to REGEXP('[N-Z]')
ORDER BY bank_to DESC
LIMIT 10;

SELECT
* 
FROM bank.order
ORDER BY bank_to DESC, amount DESC;


-- Case when will show results depending in a condition, the result can be a constant or a operation with columns. We can do multiple conditions
SELECT 
*,
CASE WHEN amount<1000 THEN 
	CASE WHEN amount<500 THEN 'Muito pequeno' ELSE 'pequeno' END 
ELSE CASE WHEN amount<1500 THEN 'MEdio' ELSE 'GRANDE' END END AS Tamanho,

CASE
WHEN amount<1000 THEN 'Pequeno'
WHEN amount<1500 THEN 'Medio'
ELSE 'Grande' END
FROM `order`
WHERE not bank_to REGEXP('[N-Z]')
ORDER BY bank_to DESC
LIMIT 10;

-- Group by show the result of a aggregation function to all the possible groups in the group by clause
-- All the columns in the select statement have to be either in a aggregation function or in the group by statement

SELECT
	AVG(amount),
	account_id,
	operation,
    MAX(amount),
	min(amount),
	AVG(balance)
FROM 
	trans
WHERE account_id>1000 
GROUP BY account_id, operation
HAVING max(amount)>30000
ORDER BY operation DESC, account_id DESC
LIMIT 1000;



SELECT DISTINCT
account_id, operation
FROM 
trans
ORDER BY account_id;


SELECT
*
FROM 
trans
WHERE account_id=576 AND operation = 'VKLAD' ;

