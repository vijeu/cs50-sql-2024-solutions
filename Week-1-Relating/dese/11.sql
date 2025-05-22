SELECT "schools"."name", "per_pupil_expenditure", "graduated" FROM "schools"
JOIN "graduation_rates" ON "schools"."id" = "graduation_rates"."school_id"
JOIN "expenditures" ON "schools"."district_id" = "expenditures"."district_id"
ORDER BY "expenditures"."per_pupil_expenditure" DESC, "schools"."name";
