CREATE VIEW "available" AS
SELECT li."id", "property_type", "host_name", "date" FROM "availabilities" AS av
JOIN "listings" AS li ON av."listing_id" = li."id"
WHERE "available" = 'TRUE';
