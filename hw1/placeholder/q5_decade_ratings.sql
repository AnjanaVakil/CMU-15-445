SELECT 
    SUBSTRING(premiered,0,4) || '0s' AS decade, 
    ROUND(AVG(rating),2) AS avg_rating,
    MAX(rating) AS top_rating,
    MIN(rating) AS min_rating,
    COUNT(*) AS num_releases
FROM ratings
INNER JOIN titles ON ratings.title_id=titles.title_id 
WHERE premiered IS NOT NULL 
GROUP BY decade
ORDER BY avg_rating DESC, decade ASC;

-- solution
/* SELECT
  CAST(premiered/10*10 AS TEXT) || 's' AS decade,
  ROUND(AVG(rating), 2) as avg_rating,
  MAX(rating) as top_rating,
  MIN(rating) as min_rating,
  COUNT(*) as num_releases
FROM
     titles
INNER JOIN
     ratings ON titles.title_id = ratings.title_id
WHERE premiered IS NOT NULL
GROUP BY decade
ORDER BY avg_rating DESC, decade ASC; */