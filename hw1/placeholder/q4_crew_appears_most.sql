SELECT name, COUNT(*) AS num_appearances
FROM crew C,people P
WHERE C.person_id=P.person_id
GROUP BY name
ORDER BY num_appearances DESC
LIMIT 20;

-- another method:
/* SELECT name, COUNT(*) AS num_appearances
FROM people
INNER JOIN crew ON people.person_id=crew.person_id
GROUP BY name
ORDER BY num_appearances DESC
LIMIT 20; */