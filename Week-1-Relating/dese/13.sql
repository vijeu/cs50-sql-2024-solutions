SELECT "districts"."name", "unsatisfactory" FROM "districts"
JOIN "staff_evaluations" ON "districts"."id" = "staff_evaluations"."district_id"
WHERE "unsatisfactory" >=
    (SELECT AVG("unsatisfactory") FROM "staff_evaluations")
ORDER BY "unsatisfactory" DESC;
