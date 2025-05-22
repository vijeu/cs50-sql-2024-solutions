CREATE TABLE "passengers" (
    "id" INT PRIMARY KEY,
    "first_name" VARCHAR(20) NOT NULL,
    "last_name" VARCHAR(20) NOT NULL,
    "age" INT
);

CREATE TABLE "check-ins" (
    "id" INT PRIMARY KEY,
    "time" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    "flight_number" INT NOT NULL,
    "name" VARCHAR(20) NOT NULL,
    "passenger_from_airline" VARCHAR(20) NOT NULL,
    "passenger_to_airlne" VARCHAR(20) NOT NULL,
    FOREIGN KEY ("flight_number") REFERENCES "flights"("flight_number"),
    FOREIGN KEY ("name") REFERENCES "airlines"("name"),
    FOREIGN KEY ("passenger_from_airline") REFERENCES "airlines"("name"),
    FOREIGN KEY ("passenger_to_airlne") REFERENCES "airlines"("name")
);

CREATE TABLE "airlines" (
    "id" INT PRIMARY KEY,
    "name" VARCHAR(20) NOT NULL,
    "concourse" CHAR(1) CHECK("concourse" IN ('A','B','C','D','E','F','T'))
);

CREATE TABLE "flights" (
    "id" INT PRIMARY KEY,
    "flight_number" INT NOT NULL,
    "airline_name" VARCHAR(20),
    "from_airport_code" CHAR(5) NOT NULL,
    "to_airport_code" CHAR(5) NOT NULL,
    "expected_departure" DATETIME,
    "expected_arrival" DATETIME,
    FOREIGN KEY ("airline_name") REFERENCES "airlines"("name")
);

