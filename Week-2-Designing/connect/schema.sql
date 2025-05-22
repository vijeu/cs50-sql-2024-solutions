CREATE TABLE "users" (
    "id" INT PRIMARY KEY,
    "first_name" VARCHAR(20) NOT NULL,
    "last_name" VARCHAR(20) NOT NULL,
    "username" VARCHAR(20) NOT NULL,
    "password" VARCHAR(20) NOT NULL
);

CREATE TABLE "schools" (
    "id" INT PRIMARY KEY,
    "name" VARCHAR(30) NOT NULL,
    "type" VARCHAR(20) NOT NULL,
    "location" VARCHAR(150) NOT NULL,
    "founded" DATE NOT NULL
);

CREATE TABLE "companies" (
    "id" INT PRIMARY KEY,
    "name" VARCHAR(20) NOT NULL,
    "industry" VARCHAR(20),
    "location" VARCHAR(150)
);

CREATE TABLE "users_connections" (
    "id" INT PRIMARY KEY,
    "first_user_id" INT,
    "second_user_id" INT CHECK ("first_user_id" != "scond_user_id"),
    FOREIGN KEY ("first_user_id") REFERENCES "users"("id"),
    FOREIGN KEY ("second_user_id") REFERENCES "users"("id")
);

CREATE TABLE "schools_connections" (
    "id" INT PRIMARY KEY,
    "user_id" INT,
    "school_id" INT,
    "start_affiliation" DATE NOT NULL,
    "end_affiliation" DATE,
    "degree" CHAR(5),
    FOREIGN KEY ("user_id") REFERENCES "users"("id"),
    FOREIGN KEY ("school_id") REFERENCES "schools"("id")
);

CREATE TABLE "companies_connections" (
    "id" INT PRIMARY KEY,
    "user_id" INT,
    "company_id" INT,
    "start_affiliation" DATE NOT NULL,
    "end_affiliation" DATE,
    "title" CHAR(10),
    FOREIGN KEY ("user_id") REFERENCES "users"("id"),
    FOREIGN KEY ("company_id") REFERENCES "companies"("id")
);
