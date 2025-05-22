CREATE INDEX first ON "students" ("id");
CREATE INDEX first2 ON "enrollments" ("student_id");
CREATE INDEX first3 ON "enrollments" ("course_id");

CREATE INDEX second ON "courses" ("semester", "number", "department");

CREATE INDEX five ON "courses" ("title");
CREATE INDEX five2 ON "satisfies" ("course_id");

CREATE INDEX six ON "satisfies" ("requirement_id");

