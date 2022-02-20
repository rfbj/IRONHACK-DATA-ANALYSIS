SELECT COUNT(*) FROM account;
SELECT COUNT(*) FROM loan;

-- Keeps the records that exist in both tables
SELECT
	*
FROM account
INNER JOIN loan ON loan.account_id = account.account_id;  

-- Keeps the records in the account table
SELECT
	*
FROM account
LEFT JOIN loan ON loan.account_id = account.account_id;  

-- Keeps the records on the loan table 
SELECT
	a.account_id,
    a.district_id,
    l.loan_id,
    l.duration,
    l.amount
FROM account AS a
RIGHT JOIN loan AS l ON l.account_id = a.account_id;  


-- FULL outter join keeps the records on both tables

SELECT * FROM account AS t1
LEFT JOIN loan as t2 ON t1.account_id = t2.account_id
UNION
SELECT * FROM account AS t1
RIGHT JOIN loan as t2 ON t1.account_id = t2.account_id;


-- Hoin can be done with multiple tables

select * from bank.disp as d
JOIN bank.client as c
on d.client_id = c.client_id
JOIN bank.card as ca
on d.disp_id = ca.disp_id;

-- Join can be used with all the other select structures
SELECT
c.district_id
,COUNT(*)
FROM
disp AS d
RIGHT JOIN client AS c ON c.client_id = d.client_id
LEFT JOIN card as ca ON ca.disp_id = d.disp_id
WHERE ca.type = 'gold'
GROUP BY c.district_id
HAVING count(*)>2
ORDER BY c.district_id
LIMIT 12;

-- 
SELECT
*
FROM
disp AS d
RIGHT JOIN client AS c ON c.client_id = d.client_id
JOIN card as ca ON ca.disp_id = d.disp_id
JOIN trans AS t ON d.account_id = t.account_id AND t.date = left(ca.issued,6);

-- SELF join when we want to repeat the columns of the table 
SELECT
*,
t1.balance - t2.amount 
FROM
trans AS t1
JOIN trans AS t2 ON t1.account_id= t2.account_id AND t1.date+1=t2.date;

SELECT
*
FROM
trans AS t1
JOIN trans AS t2 ON t1.trans_id+1=t2.trans_id AND t1.account_id=t2.account_id;

SELECT
*
FROM loan AS l1
JOIN loan AS l2 ON l1.duration = l2.duration AND l1.amount>l2.amount;


-- SUBQUERIE
SELECT
*
FROM
(select d.disp_id,c.client_id from bank.disp as d
JOIN bank.client as c
on d.client_id = c.client_id) AS first_join
JOIN card as ca
on first_join.disp_id = ca.disp_id;

SELECT
*
FROM
trans
ORDER BY amount DESC
LIMIT 1;


SELECT
*
FROM 
trans
WHERE amount in (SELECT
max(amount)
FROM
trans);

SELECT
AVG(amount)
FROM
(SELECT
account_id,
max(amount) AS amount
FROM trans
group by account_id)AS A;