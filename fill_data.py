from datetime import datetime, timedelta
import faker
from random import randint, choice, sample, randrange, shuffle
import sqlite3

STUDENTS_MIN = 30
STUDENTS_MAX = 50
NUMBER_GROUPS = 3
SUBJECTS_MIN = 5
SUBJECTS_MAX = 8
TEACHERS_MIN = 3
TEACHERS_MAX = 5
MARKS_MAX = 20
MARK_MIN = 2
MARK_MAX = 5
DATE_MIN = "2023-01-23"
DATE_MAX = "2023-05-19"

SUBJECTS = [
    'Algebra',
    'Biology',
    'Drawing',
    'Chemistry',
    'Geography',
    'Geometry',
    'History',
    'Literature',
    'Mathematics',
    'Music',
    'Physical education',
    'Physics',
    'Technology'
]


def get_date_pool(date_range: tuple() = (DATE_MIN, DATE_MAX)) -> list[str]:
    date_pool = []
    d = datetime.strptime(date_range[0], "%Y-%m-%d").date()
    date_finish = datetime.strptime(date_range[1], "%Y-%m-%d").date()
    while d <= date_finish:
        if d.weekday() < 5:
            date_pool.append(d.strftime("%Y-%m-%d"))
        d = d + timedelta(days=1)
    return date_pool


def generate_fake_data(n_students, n_teachers, n_subjects, n_groups, n_marks, date_range) -> tuple():
    date_pool = get_date_pool(date_range)
    fake_subjects = []
    fake_students = []
    fake_teachers = []
    fake_groups = []
    fake_marks = []
    students_groups = {}
    for i in range(n_groups):
        students_groups[i] = []
    fake_data = faker.Faker()
    for i in range(n_students):
        fake_students.append((fake_data.name(), fake_data.phone_number()))
        students_groups[randrange(n_groups)].append(i + 1)
        for _ in range(randint(n_subjects, n_marks)):
            mark = randint(MARK_MIN, MARK_MAX)
            subject_id = randint(1, n_subjects)
            student_id = i + 1
            date_mark = choice(date_pool)
            fake_marks.append((mark, subject_id, student_id, date_mark))
    for _ in range(n_teachers):
        fake_teachers.append((fake_data.name(), fake_data.phone_number()))
    teachers_for_subjects = [i % n_teachers for i in range(n_subjects)]
    shuffle(teachers_for_subjects)
    for subject in sample(SUBJECTS, min(n_subjects, len(SUBJECTS))):
        teacher_id = teachers_for_subjects[len(fake_subjects)]
        fake_subjects.append((subject, teacher_id))
    for i in range(n_groups):
        for student_id in students_groups[i]:
            fake_groups.append((chr(ord("A") + i), student_id))
    return fake_students, fake_teachers, fake_subjects, fake_groups, fake_marks


def insert_data_to_db(companies, employees, payments) -> None:
    with sqlite3.connect('study.db') as con:
        cur = con.cursor()
        sql_to_students = """INSERT INTO students(name, phone)
                               VALUES (?, ?)"""
        cur.executemany(sql_to_students, students)
        sql_to_teachers = """INSERT INTO teachers(name, phone)
                               VALUES (?, ?)"""
        cur.executemany(sql_to_teachers, teachers)
        sql_to_subjects = """INSERT INTO subjects(name, teacher_id)
                              VALUES (?, ?)"""
        cur.executemany(sql_to_subjects, subjects)
        sql_to_groups = """INSERT INTO study_groups(code, student_id)
                              VALUES (?, ?)"""
        cur.executemany(sql_to_groups, groups)
        sql_to_marks = """INSERT INTO marks(mark, subject_id, student_id, date_mark)
                              VALUES (?, ?, ?, ?)"""
        cur.executemany(sql_to_marks, marks)
        con.commit()


if __name__ == "__main__":
    students, teachers, subjects, groups, marks = generate_fake_data(
        randint(STUDENTS_MIN, STUDENTS_MAX),
        randint(TEACHERS_MIN, TEACHERS_MAX),
        randint(SUBJECTS_MIN, SUBJECTS_MAX),
        NUMBER_GROUPS,
        MARKS_MAX,
        (DATE_MIN, DATE_MAX)
    )
    insert_data_to_db(students, teachers, subjects)
