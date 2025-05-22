CREATE VIEW june_vacancies AS
SELECT li."id", "property_type", "host_name", COUNT(av."date") AS "days_vacant" FROM "listings" AS li
JOIN "availabilities" AS av ON li."id" = av."listing_id"
WHERE av."available" = 'TRUE' AND av."date" BETWEEN '2023-06-01' AND '2023-07-01'
GROUP BY li."id";
