-- Subqueries can be used in from, join, where or having 
SELECT round(AVG(amount),2) AS average1 FROM loan;


SELECT
*
FROM 
loan
WHERE status in
(SELECT
status
FROM
(SELECT 
	status,
	round(AVG(amount),2) AS average2 
FROM loan
GROUP BY status
HAVING round(AVG(amount),2) > (SELECT round(AVG(amount),2) AS average1 FROM loan)) AS st);


SELECT
loan.*
FROM 
loan
JOIN
(SELECT
status
FROM
(SELECT 
	status,
	round(AVG(amount),2) AS average2 
FROM loan
GROUP BY status
HAVING round(AVG(amount),2) > (SELECT round(AVG(amount),2) AS average1 FROM loan)) AS st) AS st1 ON st1.status=loan.status;


SELECT customer.customer_num,
	(SELECT SUM(ship_charge) 
	 	FROM orders
	 	WHERE customer.customer_num = orders.customer_num) 
			AS total_ship_chg
	FROM customer ;

-- It is possible to use it on select to avoid join but it takes much longer!
SELECT loan.account_id, (SELECT sum(amount) FROM trans GROUP BY account_id HAVING loan.account_id= trans.account_id) FROM loan;
SELECT loan.account_id, (SELECT sum(amount) FROM trans) FROM loan;

-- CTEs Common table expressions use to organize subqueries
with average1 AS
(SELECT round(AVG(amount),2) AS average1 FROM loan),

average2 AS (SELECT 
	status,
	round(AVG(amount),2) AS average2 
FROM loan
GROUP BY status
HAVING round(AVG(amount),2) > (SELECT * FROM average1)),
average3 AS (SELECT
status
FROM
average2),

average4 AS (SELECT
loan.*
FROM 
loan
JOIN
average3 AS st1 ON st1.status=loan.status)

SELECT * FROM average4;

SELECT * FROM average3;

-- Temporary Table
CREATE TEMPORARY TABLE new_table
AS 
SELECT 
	status,
	round(AVG(amount),2) AS average2 
FROM loan
GROUP BY status
HAVING round(AVG(amount),2) > (SELECT round(AVG(amount),2) AS average1 FROM loan);


SELECT
*
FROM
new_table;

-- Views 
CREATE TEMPORARY TABLE client_18
SELECT * FROM client WHERE district_id=18;

CREATE VIEW client_18_view AS
SELECT * FROM client WHERE district_id=18;

INSERT INTO client VALUES(55555,999999,18);

SELECT COUNT(*) FROM client WHERE district_id=18; 

SELECT COUNT(*) FROM client_18;

SELECT COUNT(*) FROM client_18_view;



