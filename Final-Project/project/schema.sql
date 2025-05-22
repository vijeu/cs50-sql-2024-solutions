-- stores publisher information
CREATE TABLE `publishers` (
    `publisher_id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` NVARCHAR(255) NOT NULL
);

-- stores each publisher's name from dataset
INSERT INTO `publishers` (`name`)
SELECT DISTINCT `publisher` FROM `books_dataset`;

-- stores book details from the dataset
CREATE TABLE `books` (
    `book_id` INT AUTO_INCREMENT PRIMARY KEY,
    `title` NVARCHAR(255) NOT NULL,
    `publisher_id` INT,
    `page_count` INT,
    `size` NVARCHAR(50),
    `cover_type` NVARCHAR(50),
    `publish_date` VARCHAR(30),
    `edition` INT,
    `publish_place` NVARCHAR(50),
    `isbn` VARCHAR(20),
    `DDC_category` VARCHAR(50),
    `subject` NVARCHAR(1000),
    `language` NVARCHAR(30),
    `circulation` INT,
    FOREIGN KEY (`publisher_id`) REFERENCES `publishers`(`publisher_id`)
);

-- creating a new table to join publisher_id
CREATE TABLE `new_books` AS
SELECT o.`title`, o.`subject`, o.`page_num`, o.`size`,
 o.`cover_type`, o.`publish_date`, o.`turn_published`,
 o.`publish_place`, o.`Counters`, o.`Shabok`, o.`Dewey_category`,
 o.`language`, p.`publisher_id` FROM `books_dataset` o
JOIN `publishers` p ON o.`publisher` = p.`name`;

-- insert the result into books table
INSERT INTO `books` (`title`, `publisher_id`, `page_count`,
 `size`, `cover_type`, `publish_date`,
 `edition`, `publish_place`, `isbn`, `DDC_category`,
 `subject`, `language`, `circulation`)
SELECT  `title`, `publisher_id`,`page_num`, `size`, `cover_type`,
 `publish_date`, `turn_published`, `publish_place`,
 `Shabok`, `Dewey_category`, `subject`, `language`,`Counters`
FROM `new_books`;

-- stores author information
CREATE TABLE `authors` (
    `author_id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` NVARCHAR(255) NOT NULL UNIQUE
);

-- insert writers into authors table
INSERT INTO `authors` (`name`)
SELECT DISTINCT `writer` FROM `books_dataset`
WHERE `writer` IS NOT NULL;

-- stores subject/genre information
CREATE TABLE `subjects` (
    `subject_id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` NVARCHAR(1000) NOT NULL
);

-- insert subjects into subjects table
INSERT INTO `subjects` (`name`)
SELECT DISTINCT `subject` FROM `books_dataset`
WHERE `subject` IS NOT NULL;

-- stores user information for the recommendation system
CREATE TABLE `users` (
    `user_id` INT AUTO_INCREMENT PRIMARY KEY,
    `username` NVARCHAR(50) NOT NULL UNIQUE,
    `password` NVARCHAR(255),
    `email` VARCHAR(255) NOT NULL UNIQUE,
    `joined_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- stores user ratings for books
CREATE TABLE `ratings` (
    `rating_id` INT AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT,
    `book_id` INT,
    `rating` TINYINT CHECK (`rating` >= 1 AND `rating` <= 5),
    `rated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`user_id`) REFERENCES `users`(`user_id`),
    FOREIGN KEY (`book_id`) REFERENCES `books`(`book_id`)
);

-- table for books and authors (many-to-many)
CREATE TABLE `book_authors` (
    `book_id` INT,
    `author_id` INT,
    PRIMARY KEY (`book_id`, `author_id`),
    FOREIGN KEY (`book_id`) REFERENCES `books`(`book_id`),
    FOREIGN KEY (`author_id`) REFERENCES `authors`(`author_id`)
);

-- creating a temp table to store book_id and author_id
CREATE TABLE `new_books` AS
SELECT DISTINCT b.`book_id`, a.`author_id` FROM `books_dataset` o
JOIN `authors` a ON o.`writer` = a.`name`
JOIN `books` b ON b.`title` = o.`title`;

-- insert the result into book-authors table
INSERT INTO `book_authors` (`book_id`, `author_id`)
SELECT `book_id`, `author_id` FROM `new_books`;

-- table for books and subjects (many-to-many)
CREATE TABLE `book_subjects` (
    `book_id` INT,
    `subject_id` INT,
    PRIMARY KEY (`book_id`, `subject_id`),
    FOREIGN KEY (`book_id`) REFERENCES `books`(`book_id`),
    FOREIGN KEY (`subject_id`) REFERENCES `subjects`(`subject_id`)
);

-- creating a temp table to store book_id and subject_id
CREATE TABLE `new_books` AS
SELECT DISTINCT b.`book_id`, s.`subject_id` FROM `books_dataset` o
JOIN `subjects` s ON o.`subject` = s.`name`
JOIN `books` b ON b.`title` = o.`title`;

-- insert the result into book-subjects table
INSERT INTO `book_subjects` (`book_id`, `subject_id`)
SELECT `book_id`, `subject_id` FROM `new_books`;

-- Create indexes to speed common searches
CREATE INDEX `idx_title` ON `books` (`title`);
CREATE INDEX `idx_pub_date` ON `books` (`publish_date`);
CREATE INDEX `idx_user` ON `ratings` (`user_id`);
CREATE INDEX `idx_book` ON `ratings` (`book_id`);
CREATE INDEX `idx_pub` ON `publishers` (`name`);
CREATE INDEX `idx_aut` ON `authors` (`name`);
CREATE INDEX `idx_sub` ON `subjects` (`name`);
