WITH quartiles AS(
    SELECT *,NTILE(10) OVER (ORDER BY avg_rating ASC) AS rating_quartile
    FROM (
        SELECT name, ROUND(AVG(rating),2) as avg_rating
        FROM ratings
        INNER JOIN crew ON ratings.title_id=crew.title_id
        INNER JOIN titles ON crew.title_id=titles.title_id AND titles.type='movie'
        INNER JOIN people ON crew.person_id=people.person_id AND born=1955
        GROUP BY name
    )
)
SELECT name,avg_rating
FROM quartiles
WHERE rating_quartile=9
ORDER BY avg_rating DESC, name ASC;
