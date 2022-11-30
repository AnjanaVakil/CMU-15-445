-- Note: There is a comma , between two WITH part!
WITH kidman_titles AS(
    SELECT DISTINCT crew.title_id 
    FROM people
    INNER JOIN crew
    ON people.person_id==crew.person_id AND name=='Nicole Kidman' AND born==1967 
),
kidman_colleagues AS(
    SELECT DISTINCT crew.person_id  AS id
    FROM crew
    WHERE (category=='actor' OR category=='actress') AND crew.title_id IN kidman_titles
)
SELECT name
FROM people
JOIN kidman_colleagues ON people.person_id=kidman_colleagues.id
ORDER BY name;