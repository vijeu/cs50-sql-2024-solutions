# Design Document

By Emad Zolfaghari Vadeghani

Video overview: <https://youtu.be/O0za7GA-lKk>

## Scope

The database for this Book Recommendation System is designed to store all the essential entities needed to manage books, authors, publishers, subjects, users, and their interactions such as ratings.
Included in the database’s scope are:

* Books, including details like title, cover type, publication date, edition, ISBN, language, and circulation.
* Authors, including the names of individuals who wrote the books.
* Publishers, including the organizations responsible for publishing the books.
* Subjects (or genres), allowing books to be categorized into different fields.
* Users, representing readers who interact with the system.
* Ratings, representing users’ feedback on books.
* tables for many-to-many relationships: book_authors (to link books and authors) and book_subjects (to link books and subjects).

Out of scope are elements like detailed book reviews, book borrowing or selling systems, and extended user profiles (e.g., addresses, preferences).

## Functional Requirements

This database will support:

* CRUD operations for books, authors, publishers, users, subjects, and ratings.
* Associating multiple authors with a single book and vice versa.
* Associating multiple subjects with a single book and vice versa.
* Allowing users to rate multiple books.
* Retrieving highly-rated books, books by certain authors or publishers, and books within specific subjects.
* Enabling user registration and interaction with the system via ratings.

This version does not support features like book recommendations based on reading history or social interactions among users.

## Representation

Entities are captured in MySQL tables with the following schema.

### Entities

The database includes the following entities:

### Books

The `books` table includes:

* `book_id`, the unique identifier for a book (`INTEGER`, `PRIMARY KEY`, `AUTO_INCREMENT`).
* `title`, the title of the book in persian language (`NVARCHAR`, `NOT NULL`).
* `page_count`, the number of pages in the book (`INTEGER`).
* `size`, the physical dimensions of the book (`NVARCHAR`).
* `cover_type`, the cover type, such as hardcover or paperback in persian language (`NVARCHAR`).
* `publish_date`, the date when the book was published in persian calender (`VARCHAR`).
* `edition`, the edition number of the book (`INTEGER`).
* `publish_place`, the place where the book was published in persian language (`NVARCHAR`).
* `isbn`, the International Standard Book Number (`VARCHAR`).
* `DDC_category`, the Dewey Decimal Classification category (`VARCHAR`).
* `subject`, a main subject of the book in persian language (`NVARCHAR`).
* `language`, the language the book is written in (in persian language) (`VARCHAR`).
* `circulation`, the number of copies circulated (`INTEGER`).
* `publisher_id`, a foreign key referencing the publishers table (`INTEGER`, `FOREIGN KEY`).

### Authors

The `authors` table includes:

* `author_id`, a unique identifier for the author (`INTEGER`, `PRIMARY KEY`, `AUTO_INCREMENT`)
* `name`, the name of the author (`VARCHAR`, `NOT NULL`)

### Publishers

The `publishers` table includes:

* `publisher_id`, a unique identifier for the publisher (`INTEGER`, `PRIMARY KEY`, `AUTO_INCREMENT`)
* `name`, the name of the publisher (`VARCHAR`, `NOT NULL`)

### Subjects

The `subjects` table includes:

* `subject_id`, a unique identifier for the subject (`INTEGER`, `PRIMARY KEY`, `AUTO_INCREMENT`)
* `name`, the name of the subject (`VARCHAR`, `NOT NULL`)

### Users

The `users` table includes:

* `user_id`, a unique identifier for the user (`INTEGER`, `PRIMARY KEY`, `AUTO_INCREMENT`)
* `username`, the username (`NVARCHAR`, `NOT NULL`, `UNIQUE`)
* `email`, the email address (`VARCHAR`, `NOT NULL`, `UNIQUE`)
* `password`, a password for the user (`NVARCHAR`, `NOT NULL`)
* `joined_at`, the timestamp when the user joined (`DATETIME`, `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP`)

### Ratings

The `ratings` table includes:

* `rating_id`, a unique identifier for the rating (`INTEGER`, `PRIMARY KEY`, `AUTO_INCREMENT`)
* `user_id`, the ID of the user who rated the book (`INTEGER`, `FOREIGN KEY`)
* `book_id`, the ID of the book that was rated (`INTEGER`, `FOREIGN KEY`)
* `rating`, a score given to the book (`TINYINT`, `NOT NULL`) with a `CHECK` constraint to ensure the value is between 1 and 5
* `rated_at`, the timestamp when the rating was submitted (`DATETIME`, `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP`)

### Book-Authors

The `book_authors` table represents the many-to-many relationship between books and authors. Each record links one book to one author.

* `book_id`, the ID of the book (`INTEGER`, `FOREIGN KEY` to `books.book_id`)
* `author_id`, the ID of the author (`INTEGER`, `FOREIGN KEY` to `authors.author_id`)

The pair `(book_id, author_id)` together forms the primary key, ensuring that the same author cannot be assigned to the same book multiple times.

### Book-Subjects

The `book_subjects` table captures the many-to-many relationship between books and subjects.
Each record links one book to one subject.

* `book_id`, the ID of the book (`INTEGER`, `FOREIGN KEY` to `books.book_id`)
* `subject_id`, the ID of the subject (`INTEGER`, `FOREIGN KEY` to `subjects.subject_id`)

The combination of `(book_id, subject_id)` forms the primary key, ensuring that the same subject is not assigned multiple times to the same book.

### Relationships

The below entity relationship diagram describes the relationships among the entities in the database.

![ER Diagram](persianbooks.png)

As detailed by the diagram:

* A book can have multiple authors, and an author can write multiple books (many-to-many)
* A book can belong to multiple subjects, and a subject can have multiple books (many-to-many)
* A book belongs to one publisher, and a publisher can have multiple books (one-to-many)
* A user can rate multiple books, and a rating belongs to one user and one book (one-to-many)

## Optimizations

Given the common operations expected on the database, the following indexes have been created to improve query performance:

* `idx_title` on `books.title` to speed up searches for books by title.
* `idx_pub_date` on `books.publish_date` to allow efficient filtering or sorting of books by their publication date.
* `idx_user` on `ratings.user_id` to quickly find all ratings submitted by a specific user.
* `idx_book` on `ratings.book_id` to quickly find all ratings associated with a specific book.
* `idx_pub` on `publishers.name` to support fast lookup of publishers by their name.
* `idx_aut` on `authors.name` to enable fast searching of authors by their name.
* `idx_sub` on `subjects.name` to allow efficient lookup of subjects by name.
* Foreign key constraints ensure referential integrity between related tables.

Common queries like finding all books by an author or listing top-rated books are optimized by indexing foreign keys and relevant columns.
These indexes optimize the database for its most common query patterns, particularly searches by name, title, and associations between users, books, authors, and subjects.

## Limitations

* The system assumes each user can rate a book only once. To allow multiple ratings per user per book, a rating history system would need to be added.
* There is no full-text search implemented for book titles or subject names; searches are exact matches or simple partial matches.
* Passwords are stored as hashes, but the system assumes hashing is handled by the application.
* Book publishing dates are stored in Gregorian calendar format; support for Persian date conversion must be handled at the application layer.
* The system currently lacks support for multiple editions of the same book beyond simple text fields.
