CREATE TABLE `users` (
    `id` INT AUTO_INCREMENT,
    `first_name` VARCHAR(20) NOT NULL,
    `last_name` VARCHAR(30) NOT NULL,
    `username` VARCHAR(40) UNIQUE NOT NULL,
    `password` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `schools` (
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(20) NOT NULL,
    `type` ENUM(`Primary`, `Secondary`, `Higher Education`) NOT NULL,
    `location` VARCHAR(100) NOT NULL,
    `founded` YEAR NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `companies` (
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(20) NOT NULL,
    `industry` ENUM(`Technology`, `Education`, `Business`) NOT NULL,
    `location` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `people_connections` (
    `id` INT AUTO_INCREMENT,
    `user_id` INT,
    `friend_id` INT,
    `friendship_date` DATETIME NOT NULL,
    PRIMARY KEY (`id`)
    FOREIGN KEY(`user_id`) REFERENCES `users`(`id`),
    FOREIGN KEY(`friend_id`) REFERENCES `users`(`id`)
);

CREATE TABLE `schools_connections` (
    `id` INT AUTO_INCREMENT,
    `user_id` INT,
    `school_id` INT,
    `start_affiliation` DATETIME,
    `end_affiliation` DATETIME,
    `degree` CHAR(5),
    PRIMARY KEY (`id`),
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`),
    FOREIGN KEY (`school_id`) REFERENCES `schools`(`id`)
);

CREATE TABLE `companies_connections` (
    `id` INT AUTO_INCREMENT,
    `user_id` INT,
    `company_id` INT,
    `start_affiliation` DATETIME,
    `end_affiliation` DATETIME,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`),
    FOREIGN KEY (`company_id`) REFERENCES `companies`(`id`)
);
