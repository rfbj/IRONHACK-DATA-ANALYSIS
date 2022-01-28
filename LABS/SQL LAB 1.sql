USE sakila;

SELECT * FROM customer;
SELECT * FROM film;
SELECT * FROM actor;

SELECT title
FROM sakila.film;

SELECT name as language
FROM language;

SELECT COUNT(distinct store_id)
FROM store;

SELECT COUNT(staff_id)
FROM staff;

SELECT first_name
FROM staff;


