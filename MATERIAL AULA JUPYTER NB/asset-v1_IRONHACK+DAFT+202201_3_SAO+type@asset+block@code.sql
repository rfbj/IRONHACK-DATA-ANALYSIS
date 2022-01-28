-- Setting the working database
use bank;

-- Selecting all the data from table trans
select * from trans;

-- Selecting all the data from table trans of database bank
select * from bank.trans;
-- To select some columns instead of all
select trans_id, account_id, date, type from bank.trans;

-- To select some columns instead of all
select bank.trans.trans_id, bank.trans.account_id, bank.trans.date, bank.trans.type from bank.trans;

-- Limiting the number of rows in the results
select trans_id , account_id, date , type from bank.trans 
limit 10;

-- Check the number of records in a table
select count(*) from bank.trans;

-- Get the unique values of
select distinct status from bank.loan; 

select trans_id as Transaction_ID, account_id as Account_ID, date as Date, type as Type_of_account
from bank.trans;

-- Aliasing columns and tables
-- The use of an alias for a table is not needed here, but it is shown 
-- for illustrative purposes and it will be used later in joins.
select bt.trans_id as Transaction_ID, bt.account_id as Account_ID, bt.date as Date, bt.type as Type
from bank.trans as bt;