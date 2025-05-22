CREATE VIEW frequently_reviewed AS
SELECT li."id", "property_type", "host_name", COUNT(re."id") AS "reviews" FROM "listings" AS li
JOIN "reviews" AS re ON li."id" = re."listing_id"
GROUP BY li."id"
ORDER BY COUNT(re."id") DESC, "property_type", "host_name"
LIMIT 100;
