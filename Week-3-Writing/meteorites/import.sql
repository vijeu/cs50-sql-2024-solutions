CREATE TABLE "temp" (
    "name" VARCHAR,
    "id" INTEGER,
    "nametype" VARCHAR,
    "class" VARCHAR,
    "mass" REAL,
    "discovery" VARCHAR,
    "year" VARCHAR,
    "lat" REAL,
    "long" REAL
);


.import --csv --skip 1 meteorites.csv temp


UPDATE temp SET "mass" = NULL
WHERE "mass" = '';

UPDATE temp SET "year" = NULL
WHERE "year" = '';

UPDATE temp SET "lat" = NULL
WHERE "lat" = '';

UPDATE temp SET "long" = NULL
WHERE "long" = '';


UPDATE temp SET "mass" = ROUND("mass", 2), "lat" = ROUND("lat", 2), "long" = ROUND("long", 2);


DELETE FROM "temp"
WHERE "nametype" = 'Relict';


CREATE TABLE "meteorites" (
    "id" INTEGER PRIMARY KEY,
    "name" VARCHAR,
    "class" VARCHAR,
    "mass" REAL,
    "discovery" VARCHAR,
    "year" VARCHAR,
    "lat" REAL,
    "long" REAL
);

INSERT INTO "meteorites" ("name", "class", "mass", "discovery", "year", "lat", "long")
SELECT x."name", x."class", x."mass", x."discovery", x."year", x."lat", x."long" FROM (
    SELECT "name", "class", "mass", "discovery", "year", "lat", "long" FROM "temp"
    ORDER BY "year", "name"
) AS x;

drop table temp;
