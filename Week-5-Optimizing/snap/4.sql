SELECT "username" FROM "users" AS u
JOIN "messages" AS m ON u."id" = m."to_user_id"
GROUP BY "to_user_id"
ORDER BY COUNT(m."id") DESC
LIMIT 1;
