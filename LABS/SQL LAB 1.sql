
/*CREATE VIEW step1_royalties AS
SELECT 	ta.au_id as AuthorID, 
		sl.title_id as TitleID, 
        (ts.price * sl.qty * (ts.royalty / 100) * (ta.royaltyper /100)) as royalty_per_sale, 
        (ts.advance * (ta.royaltyper / 100)) as advance_per_title_and_author 
FROM titles as ts
JOIN titleauthor as ta ON ts.title_id = ta.title_id
JOIN sales as sl ON ta.title_id = sl.title_id;

SELECT * FROM step1_royalties;*/


-- DROP TABLE IF EXISTS step1_royalties;

CREATE TEMPORARY TABLE step1_royalties AS
SELECT		
        ta.au_id as AuthorID, 
		sl.title_id as TitleID, 
        (ts.price * sl.qty * (ts.royalty / 100) * (ta.royaltyper /100)) as royalty_per_sale, 
        (ts.advance * (ta.royaltyper / 100)) as advance_per_title_and_author 
        
FROM titles as ts
JOIN titleauthor as ta ON ts.title_id = ta.title_id
JOIN sales as sl ON ta.title_id = sl.title_id;

SELECT * from step1_royalties;
