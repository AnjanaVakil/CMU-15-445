-- Run Time: real 7.916 user 5.712018 sys 1.163099
SELECT
    primary_title AS name,
    ratings.votes AS votes
FROM titles
INNER JOIN ratings ON titles.title_id=ratings.title_id
INNER JOIN crew ON ratings.title_id=crew.title_id
INNER JOIN people ON crew.person_id=people.person_id
WHERE people.name LIKE '%Cruise%' AND people.born=1962
ORDER BY votes DESC
LIMIT 10;

-- better solution
-- Run Time: real 3.833 user 3.460795 sys 0.355109
-- CTEs(Common Table Expressions) can be thought of as a temporary table that is scoped to a single query.
-- The WITH clause binds the output of the inner query to a temporary result with that name.
/* sqlite> WITH cteName AS(SELECT 1)
   ...> SELECT * FROM cteName;
   1
*/
-- Note：There is no ; semicolon after WITH clause!
/* WITH cruise_movies AS(
    SELECT title_id
    FROM crew
    INNER JOIN people ON crew.person_id=people.person_id
    WHERE people.name LIKE '%Cruise%' AND people.born=1962
)
SELECT primary_title AS name,ratings.votes AS votes
FROM cruise_movies
INNER JOIN titles ON cruise_movies.title_id=titles.title_id
INNER JOIN ratings ON titles.title_id=ratings.title_id
ORDER BY votes DESC
LIMIT 10; */
