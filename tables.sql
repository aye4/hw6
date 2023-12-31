DROP TABLE IF EXISTS students;
CREATE TABLE students (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(60) NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL
);

DROP TABLE IF EXISTS study_groups;
CREATE TABLE study_groups (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    code VARCHAR(10) NOT NULL,
    student_id INTEGER,
    FOREIGN KEY (student_id) REFERENCES students (id)
      ON DELETE CASCADE
);

DROP TABLE IF EXISTS teachers;
CREATE TABLE teachers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(60) NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL
);

DROP TABLE IF EXISTS subjects;
CREATE TABLE subjects (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(80) UNIQUE NOT NULL,
    teacher_id INTEGER,
    FOREIGN KEY (teacher_id) REFERENCES teachers (id)
      ON DELETE CASCADE
);

DROP TABLE IF EXISTS marks;
CREATE TABLE marks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    mark INTEGER NOT NULL,
    subject_id INTEGER,
    student_id INTEGER,
    date_mark DATE,
    FOREIGN KEY (subject_id) REFERENCES subjects (id)
      ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES students (id)
      ON DELETE CASCADE
);
