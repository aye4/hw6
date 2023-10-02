--11. Средний балл, который определенный преподаватель ставит определенному студенту.
WITH var AS (SELECT 
 (SELECT name FROM students LIMIT 1 OFFSET ABS(RANDOM()) % MAX((SELECT COUNT(*) FROM students), 1)) [student],
 (SELECT name FROM teachers LIMIT 1 OFFSET ABS(RANDOM()) % MAX((SELECT COUNT(*) FROM teachers), 1)) [teacher]
)
SELECT s.name [Student], t.name [Teacher], avg(m.mark) [AVG Mark]
FROM var v
JOIN students s ON s.name = v.student
JOIN teachers t ON t.name = v.teacher
LEFT JOIN subjects sub ON sub.teacher_id = t.id
LEFT JOIN marks m ON m.student_id = s.id AND m.subject_id = sub.id;
