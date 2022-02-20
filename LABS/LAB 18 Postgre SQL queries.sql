USE apple;

SELECT distinct prime_genre as `Different Genres`
FROM apple_table;

SELECT prime_genre as `Different Genres`, sum(rating_count_tot) as `Rating`
FROM apple_table;

SELECT count(id), prime_genre
FROM apple_table
GROUP BY prime_genre
ORDER BY count(id)  DESC;

SELECT count(id), prime_genre
FROM apple_table
GROUP BY prime_genre
ORDER BY count(id);

SELECT track_name, rating_count_tot
from apple_table
order by rating_count_tot DESC
LIMIT 10;

SELECT track_name, user_rating
from apple_table
order by user_rating DESC
LIMIT 10;

SELECT track_name, user_rating, rating_count_tot
from apple_table
order by user_rating DESC
LIMIT 10;