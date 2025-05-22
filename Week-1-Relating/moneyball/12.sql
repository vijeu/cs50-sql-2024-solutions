WITH sh AS (
        SELECT "first_name", "last_name", "salary" / "H", "players"."id" AS player_id_sh FROM "players"
        JOIN "salaries" ON "players"."id" = "salaries"."player_id"
        JOIN "performances" ON "players"."id" = "performances"."player_id"
        WHERE "salaries"."year"= '2001' AND "performances"."year"= '2001' AND "H" > '0'
        ORDER BY "salary" / "H", "players"."id", "players"."first_name", "players"."last_name"
        LIMIT 10
),
sr AS (
        SELECT "first_name", "last_name", "salary" / "RBI", "players"."id" AS player_id_sr FROM "players"
        JOIN "salaries" ON "players"."id" = "salaries"."player_id"
        JOIN "performances" ON "players"."id" = "performances"."player_id"
        WHERE "salaries"."year"= '2001' AND "performances"."year"= '2001' AND "RBI" > '0'
        ORDER BY "salary" / "RBI", "players"."id", "players"."first_name", "players"."last_name"
        LIMIT 10
)
SELECT T."first_name", T."last_name" FROM (
            SELECT sh."first_name", sh."last_name" FROM sh
            INTERSECT
            SELECT sr."first_name", sr."last_name" FROM sr
            ) AS T
JOIN "players" ON T."first_name" = "players"."first_name"
GROUP BY T."last_name"
ORDER BY T."last_name";
