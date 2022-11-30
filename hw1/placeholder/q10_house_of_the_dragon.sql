/* WITH p AS(
    SELECT titles.primary_title AS name, akas.title AS dubbed
    FROM titles
    INNER JOIN akas ON titles.title_id=akas.title_id
    WHERE titles.type='tvSeries' AND titles.primary_title='House of the Dragon'
    GROUP BY titles.primary_title,akas.title
    ORDER BY akas.title
),
c AS(
    SELECT ROW_NUMBER() OVER (ORDER BY p.name ASC) AS seqnum, p.dubbed AS dubbed
    FROM p
),
flattened AS(
    SELECT seqnum,dubbed
    FROM c
    WHERE seqnum=1
    UNION ALL
    SELECT c.seqnum, f.dubbed || ',' || c.dubbed
    FROM c 
    JOIN flattened f ON c.seqnum=f.seqnum+1
)
SELECT dubbed
FROM flattened
ORDER BY seqnum DESC 
LIMIT 1; */
WITH t AS (
      SELECT
            titles.primary_title as name,
            akas.title as dubbed,
            (titles.primary_title = akas.title) AS starter
      FROM
            titles
            INNER JOIN akas ON titles.title_id = akas.title_id
            INNER JOIN ratings ON titles.title_id = ratings.title_id
            WHERE titles.premiered = 2022 AND titles.type = 'tvSeries' AND ratings.rating >= 9.0
            GROUP BY titles.primary_title, akas.title
            ORDER BY titles.primary_title ASC, starter DESC, akas.title ASC
),
r AS (
      select t.name as name, row_number() over (order by t.name asc) as seqnum, t.dubbed as dubbed
      from t
),
dub_cte AS (
      SELECT
            r.name, r.seqnum, r.dubbed
      FROM
            r
      WHERE
            r.name = r.dubbed
      UNION ALL
      SELECT
            r.name, r.seqnum,  c.dubbed || ', ' || r.dubbed
      FROM
            r INNER JOIN dub_cte c ON r.name = c.name AND r.seqnum = c.seqnum + 1
)
SELECT name, MAX(dubbed) FROM dub_cte
GROUP BY name;