--10.Список курсов, которые определенному студенту читает определенный преподаватель.
WITH var AS (SELECT 
 (SELECT name FROM students LIMIT 1 OFFSET ABS(RANDOM()) % MAX((SELECT COUNT(*) FROM students), 1)) [student],
 (SELECT name FROM teachers LIMIT 1 OFFSET ABS(RANDOM()) % MAX((SELECT COUNT(*) FROM teachers), 1)) [teacher]
)
SELECT DISTINCT s.name [Student], t.name [Teacher], sub.name [Subject]
FROM var v
JOIN students s ON s.name = v.student
JOIN teachers t ON t.name = v.teacher
LEFT JOIN subjects sub ON sub.teacher_id = t.id
LEFT JOIN marks m ON m.student_id = s.id AND m.subject_id = sub.id
ORDER BY 3;
