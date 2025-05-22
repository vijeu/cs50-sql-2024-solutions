CREATE TABLE "ingredients" (
    "id" INT PRIMARY KEY,
    "name" VARCHAR(20) NOT NULL,
    "price_per_unit" REAL NOT NULL
);

CREATE TABLE "donuts" (
    "id" INT PRIMARY KEY,
    "name" VARCHAR(30) NOT NULL,
    "gluten_free" CHAR(3) CHECK ("gluten_free" IN ('YES','NO')) NOT NULL,
    "price_per_donut" REAL NOT NULL
);

CREATE TABLE "orders" (
    "id" INT PRIMARY KEY,
    "number" INT NOT NULL,
    "donuts_in_order" INT NOT NULL,
    "customer_id" INT NOT NULL,
    FOREIGN KEY ("customer_id") REFERENCES "customers"("id")
);

CREATE TABLE "customers" (
    "id" INT PRIMARY KEY,
    "first_name" VARCHAR(20) NOT NULL,
    "last_name" VARCHAR(20) NOT NULL,
    "last_orders" INT NOT NULL,
    FOREIGN KEY ("last_orders") REFERENCES "orders"("number")
);
