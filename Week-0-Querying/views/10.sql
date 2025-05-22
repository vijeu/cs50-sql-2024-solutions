SELECT "english_title", "contrast" AS "relative contrast" FROM "views"
WHERE "contrast" > 0.4 AND "entropy" < 7.4
ORDER BY "contrast";
