SELECT "schools"."name" FROM "schools"
JOIN "districts" ON "schools"."district_id" = "districts"."id"
WHERE "districts"."name" = 'Cambridge';
