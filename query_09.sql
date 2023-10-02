--9. Найти список курсов, которые посещает определенный студент.
WITH var AS (SELECT id, name FROM students LIMIT 1 OFFSET ABS(RANDOM()) % MAX((SELECT COUNT(*) FROM students), 1))
SELECT DISTINCT s.name [Student], sub.name [Subject]
FROM students s
CROSS JOIN var v
JOIN marks m ON m.student_id = s.id
JOIN subjects sub ON sub.id = m.subject_id
WHERE s.name = v.name
ORDER BY 2;
