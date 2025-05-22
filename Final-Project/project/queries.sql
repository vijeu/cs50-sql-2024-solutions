-- queries for book recommendation database
-- author: [Emad Zolfaghari]
-- description: typical queries used in the book recommendation system

-- 1. insert a new book into the books table
INSERT INTO `books` (`title`,`page_count`, `size`, `cover_type`, `publish_date`, `edition`, `publish_place`, `isbn`,
                   `DDC_category`, `subject`, `language`, `circulation`, `publisher_id`)
VALUES ('تاریخ فلسفه غرب', 1368, 'رقعی', NULL, '65/01/01', '5', 'تهران', NULL,
        '109', 'فلسفه - تاریخ', 'فارسي', 11000, 1623);

-- 2. insert a new user into the users table
INSERT INTO `users` (`username`, `email`, `password`)
VALUES ('Eric_Arthur_Blair', 'orwell@yahoo.com', '1b36ea1c9b7a1c3ad668b8bb5df7963f');

-- 3. update a book's circulation number
UPDATE `books`
SET `circulation` = `circulation` + 1000
WHERE `title` = 'جهان همچون اراده و تصور';

-- 4. update a user's email address
UPDATE `users`
SET `email` = 'newbie@gmail.com'
WHERE `username` = 'bookhater99';

-- 5. delete a rating if the user regrets their review
DELETE FROM `ratings`
WHERE `user_id` = 17 AND `book_id` = 51254;

-- 6. find all books by a specific author
SELECT b.`title`
FROM `books` b
JOIN `book_authors` ba ON b.`book_id` = ba.`book_id`
JOIN `authors` a ON ba.`author_id` = a.`author_id`
WHERE a.`name` = 'داستایوسکی';

-- 7. find top 10 highest-rated books
SELECT b.`title`, AVG(r.`rating`) AS average_rating
FROM `books` b
JOIN `ratings` r ON b.`book_id` = r.`book_id`
GROUP BY b.`book_id`
ORDER BY average_rating DESC
LIMIT 10;

-- 8. find all subjects related to a specific book
SELECT s.`name`
FROM `subjects` s
JOIN `book_subjects` bs ON s.`subject_id` = bs.`subject_id`
JOIN `books` b ON bs.`book_id` = b.`book_id`
WHERE b.`title` = 'فراسوی نیک و بد';

-- 9. find all books published by a specific publisher
SELECT b.`title`
FROM `books` b
JOIN `publishers` p ON b.`publisher_id` = p.`publisher_id`
WHERE p.`name` = 'نشر چشمه';

-- 10. find users who rated a specific book
SELECT u.`username`, r.`rating`
FROM `users` u
JOIN `ratings` r ON u.`user_id` = r.`user_id`
WHERE r.`book_id` = 7045;
