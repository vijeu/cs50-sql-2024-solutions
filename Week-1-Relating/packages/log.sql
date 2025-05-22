
-- *** The Lost Letter ***

--find the address id of the sender
/*SELECT "id" FROM "addresses"
WHERE "address" LIKE "%900%somerville%avenue%"*/

--find the package id of the lost package
/*SELECT "id" FROM "packages"
WHERE "from_address_id"= ... */

--find the address id of the package in the last scan
/*SELECT "address_id" FROM "scans"
WHERE "package_id"= ...
ORDER BY "timestamp" DESC LIMIT 1*/

--find the address and type of address of the last place where the package droped
/*SELECT "address", "type" FROM "addresses"
WHERE "id"= ...*/


--full code

SELECT "address", "type" FROM "addresses"
WHERE "id"=
    (SELECT "address_id" FROM "scans"
    WHERE "package_id"=
        (SELECT "id" FROM "packages"
        WHERE "from_address_id"=
            (SELECT "id" FROM "addresses"
            WHERE "address" LIKE "%900%somerville%avenue%"))
    ORDER BY "timestamp" DESC LIMIT 1);

-- *** The Devious Delivery ***

--find the package without from address that contains something like "duck"
SELECT * FROM "packages"
WHERE "contents" LIKE "%duck%" AND "from_address_id" IS NULL;

-- find the address id of the last scan for that package
SELECT * FROM "scans"
WHERE "package_id"= '5098'
ORDER BY "timestamp" DESC LIMIT 1;

--find the last address and address type of the package
SELECT * FROM "addresses"
WHERE "id"= '348';


--full code

SELECT "id","address", "type", NULL AS "contents" FROM "addresses"
WHERE "id"=
    (SELECT "address_id" FROM "scans"
    WHERE "package_id"=
        (SELECT "id" FROM "packages"
        WHERE "contents" LIKE "%duck%" AND "from_address_id" IS NULL)
    ORDER BY "timestamp" DESC)
UNION
SELECT NULL AS "id", NULL AS "address", NULL AS "type", "contents" FROM "packages"
WHERE "id"= '5098';


-- *** The Forgotten Gift ***

--find the address id of sender
SELECT * FROM "addresses"
where "address"= '109 Tileston Street';

--find the package id from the sender address
SELECT * FROM "packages"
WHERE "from_address_id"= '9873';

--find the driver id by the package id
SELECT * FROM "scans"
WHERE "package_id"= '9523'
ORDER BY "timestamp" DESC LIMIT 1;

--find the driver name by his id
SELECT * FROM "drivers"
WHERE "id"= '17';


--full code

SELECT "name" AS "driver's name", NULL AS "contents" FROM "drivers"
WHERE "id"=
    (SELECT "driver_id" FROM "scans"
    WHERE "package_id"=
        (SELECT "id" FROM "packages"
        WHERE "from_address_id"=
            (SELECT "id" FROM "addresses"
            where "address"= '109 Tileston Street')
        )
        ORDER BY "timestamp" DESC LIMIT 1
    )
UNION
SELECT NULL AS "name", "contents" FROM "packages"
WHERE "from_address_id"=
(SELECT "id" FROM "addresses"
            where "address"= '109 Tileston Street');
