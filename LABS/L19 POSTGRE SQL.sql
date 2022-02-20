SELECT aut.au_id as `AUTHOR ID`, au_lname as `LAST NAME`, au_fname as `FIRST NAME`, title as TITLE, pub_name as PUBLISHER
FROM authors as aut
JOIN titleauthor as ta ON aut.au_id = ta.au_id
JOIN titles as ts ON ta.title_id = ts.title_id
JOIN publishers as pubs ON ts.pub_id = pubs.pub_id
ORDER BY au_fname; -- publishers.pub_id = titles.pubid;

SELECT
count(*)
FROM titleauthor;

SELECT 		aut.au_id as `AUTHOR ID`
			,au_lname as `LAST NAME`
            ,au_fname as `FIRST NAME`
            ,title as TITLE
            ,pub_name as PUBLISHER,
            count(*) as `Title Count`
            
FROM authors as aut
JOIN titleauthor as ta ON 
							aut.au_id = ta.au_id
            
JOIN titles as ts ON 
							ta.title_id = ts.title_id
                            
JOIN publishers as pubs ON 
							ts.pub_id = pubs.pub_id
                            
GROUP BY aut.au_id
ORDER BY count(*); 

SELECT aut.au_id as `AUTHOR ID`, au_lname as `LAST NAME`, au_fname as `FIRST NAME`, sum(qty) as `SOLD UNITS`
FROM authors as aut
JOIN titleauthor as ta ON aut.au_id = ta.au_id
JOIN sales as sl ON ta.title_id = sl.title_id
GROUP BY aut.au_id
ORDER BY sum(qty) DESC
LIMIT 3;

SELECT aut.au_id as `AUTHOR ID`, au_lname as `LAST NAME`, au_fname as `FIRST NAME`, coalesce(sum(qty),0) as `SOLD UNITS`
FROM authors as aut
LEFT JOIN titleauthor as ta ON aut.au_id = ta.au_id
LEFT JOIN sales as sl ON ta.title_id = sl.title_id
GROUP BY aut.au_id
ORDER BY sum(qty) DESC;

SELECT 					aut.au_id as `AUTHOR ID`, 
						au_lname as `LAST NAME`, 
                        au_fname as `FIRST NAME`, 
							CASE WHEN sum(qty) is null
								THEN 0
                                ELSE sum(qty) 
                                END 
                                as `SOLD UNITS`
FROM authors as aut
LEFT JOIN titleauthor as ta ON aut.au_id = ta.au_id
LEFT JOIN sales as sl ON ta.title_id = sl.title_id
GROUP BY aut.au_id
ORDER BY sum(qty) DESC;


