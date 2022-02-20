-- JOINs: bring information from other tables
SELECT * FROM movies;

SELECT * FROM movie_info;

SELECT * 
  FROM movies
       INNER JOIN
	   movie_info
    ON movies.id = movie_info.movie_id; 
	
SELECT A.id,
	   A.title,
	   A.year,
	   B.rating,
	   B.rating * 100 AS rating_100,
	   (CASE WHEN B.rating > 8 THEN 'OSCAR' ELSE 'NO-OSCAR' END) AS oscar_candidate,
	   (CASE 
	   		WHEN A.year BETWEEN 1995 AND 2000 THEN '90s'
			WHEN A.year BETWEEN 2001 AND 2010 THEN '00s'
			WHEN A.year BETWEEN 2011 AND 2020 THEN '10s'
			ELSE 'OTHER'
		END) AS decades,
		C.domestic_sales
  FROM movies AS A
       LEFT JOIN
	   movie_info AS B
    ON A.id = B.movie_id
	   LEFT JOIN
	   movie_info AS C
    ON A.id = C.movie_id; 
	
-- bring all movies that did better domestically rather than internationally.

SELECT * FROM movie_info WHERE domestic_sales > international_sales ;

SELECT A.id,
 	   A.title,
	   A.year,
	   B.domestic_sales,
	   B.international_sales
  FROM movies AS A
       INNER JOIN
	   movie_info AS B
    ON A.id = B.movie_id
 WHERE B.domestic_sales > B.international_sales; 
 
 -- subquery
 
SELECT A.id,
 	   A.title,
	   A.year,
	   B.domestic_sales,
	   B.international_sales
  FROM movies AS A
       INNER JOIN
	   (SELECT movie_id, 
			   domestic_sales, 
		       international_sales 
		  FROM movie_info 
		 WHERE domestic_sales > international_sales) AS B
    ON A.id = B.movie_id; 
	   
SELECT MAX(years_employed) FROM employees;

SELECT * FROM employees WHERE years_employed = (SELECT MAX(years_employed) FROM employees);

SELECT * FROM 
(SELECT A.id,
 	   A.title AS titulo,
	   A.year,
	   B.domestic_sales,
	   B.international_sales
  FROM movies AS A
       LEFT JOIN
	   (SELECT movie_id, 
			   domestic_sales, 
		       international_sales 
		  FROM movie_info 
		 WHERE domestic_sales > international_sales) AS B
    ON A.id = B.movie_id) AS C
WHERE C.titulo = 'Toy Story';


-- CTEs: Common Table Expressions (WITH syntax)
WITH international_better AS (
-- movies that did better domestically rather than internationally.
SELECT movie_id, 
	   domestic_sales, 
	   international_sales 
  FROM movie_info 
 WHERE domestic_sales > international_sales
),
-- bring this info to `movies` table
joined_table AS (
SELECT A.id,
 	   A.title AS titulo,
	   A.year,
	   B.domestic_sales,
	   B.international_sales
  FROM movies AS A
       LEFT JOIN
	   international_better AS B
    ON A.id = B.movie_id
)
-- filter out Toy Story movie
SELECT *
  FROM joined_table
 WHERE titulo = 'Toy Story';


-- Creating Table 
DROP TABLE IF EXISTS new_table;
CREATE TABLE new_table AS
SELECT *
  FROM movies AS A
       INNER JOIN
	   movie_info AS B
	ON A.id = B.movie_id;

SELECT * FROM new_table;

-- Temporary Table
CREATE TEMPORARY TABLE new_temp_table AS
SELECT *
  FROM movies AS A
       INNER JOIN
	   movie_info AS B
	ON A.id = B.movie_id;
	
SELECT * FROM new_temp_table;

-- VIEW
CREATE TABLE building_1000 AS
SELECT * FROM buildings WHERE " height" > 1000;

CREATE VIEW building_1000_view AS
SELECT * FROM buildings WHERE " height" > 1000;

SELECT * FROM building_1000;
SELECT * FROM building_1000_view;

SELECT * FROM buildings;
INSERT INTO buildings VALUES (5, 'WTC', 1234);
SELECT * FROM buildings;

SELECT * FROM building_1000;
SELECT * FROM building_1000_view;