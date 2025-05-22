SELECT "user_id" FROM "friends" AS f
JOIN "users" AS u ON u."id" = f."user_id"
WHERE "friend_id" = (
    SELECT "id" FROM "users"
    WHERE "username" = 'lovelytrust487'
)

INTERSECT

SELECT "user_id" FROM "friends" AS f
JOIN "users" AS u ON u."id" = f."user_id"
WHERE "friend_id" = (
    SELECT "id" FROM "users"
    WHERE "username" = 'exceptionalinspiration482'
);
