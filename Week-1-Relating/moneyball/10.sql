SELECT "first_name", "last_name", "salary", "HR", "salaries"."year" FROM "players"
JOIN "salaries" ON "players"."id" = "salaries"."player_id"
JOIN "performances" ON "performances"."player_id" = "players"."id"
WHERE "salaries"."year"= "performances"."year"
ORDER BY "players"."id", "performances"."year" DESC, "HR" DESC, "salary" DESC;
