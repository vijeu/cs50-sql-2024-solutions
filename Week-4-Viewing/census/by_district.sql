CREATE VIEW by_district AS
SELECT "district",
SUM("families") AS families,
SUM("households") AS households,
SUM("population") AS "Population",
SUM("male") AS Male,
SUM("female") AS Female
FROM "census"
GROUP BY "district";
