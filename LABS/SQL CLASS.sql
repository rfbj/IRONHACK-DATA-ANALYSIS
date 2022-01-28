/*Comentários 
multi 

-- Comentário de linha única

DROP TABLE IF EXISTS example_table;
CREATE TABLE example_table (nome varchar(20),
							nota smallint,
                            idade smallint);

SELECT * FROM example_table;

INSERT INTO example_table (nome,nota,idade) VALUES ('Atum', 4,5);

SELECT * FROM example_table;

SET SQL_SAFE_UPDATES = 0;
linhas


USE bank;
SELECT a2 as district_name, a11 as average_salay
FROM demograph
WHERE a2 > 10000;

SELECT status
FROM loan
WHERE status ="B";

SELECT type
	FROM creditcard
		WHERE type = "junior"
				LIMIT 10;

SELECT a2, a4, a10,
(a4*a10)/100
FROM demograph
WHERE a10>50;

SELECT type, card_id, disp_id, issued
	FROM creditcard
		WHERE type = "junior" and issued > 980000;

SELECT trans_id, operation, type
	FROM transactions
    WHERE right(operation, 4) = "cash" and type = "withdrawal"
    LIMIT 10;

SELECT loan_id, account_id, status, amount, payments, (amount - payments) as debt 
	FROM loan
		WHERE status ="B" and (amount - payments) > 10000;
        
SELECT avg(amount) as AVG, concat('Cz ',min(amount)) as MIN, concat('Cz ', max(amount)) as MAX
	FROM transactions
    WHERE amount != 0;

SELECT 
*,
concat('19', left(date,2))
FROM account;
*/
SELECT `apple_table`.`id`,
    `apple_table`.`track_name`,
    `apple_table`.`size_bytes`,
    `apple_table`.`currency`,
    `apple_table`.`price`,
    `apple_table`.`rating_count_tot`,
    `apple_table`.`rating_count_ver`,
    `apple_table`.`user_rating`,
    `apple_table`.`user_rating_ver`,
    `apple_table`.`ver`,
    `apple_table`.`cont_rating`,
    `apple_table`.`prime_genre`,
    `apple_table`.`sup_devicesnum`,
    `apple_table`.`ipadSc_urlsnum`,
    `apple_table`.`langnum`,
    `apple_table`.`vpp_lic`
FROM `apple`.`apple_table`;

use sakila;

SELECT sum(amount) as Total_revenue
FROM payment;

SELECT customer_id, sum(amount) as Customer_Revenue
FROM payment
group by customer_id;



