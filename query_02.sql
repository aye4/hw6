--2. Найти студента с наивысшим средним баллом по определенному предмету.
WITH var AS (SELECT id, name FROM subjects LIMIT 1 OFFSET ABS(RANDOM()) % MAX((SELECT COUNT(*) FROM subjects), 1))
SELECT sub.name [Subject], s.name [Student], avg(m.mark) [AVG Mark]
FROM subjects sub
CROSS JOIN var v
JOIN marks m on m.subject_id = sub.id
JOIN students s on s.id = m.student_id
WHERE sub.name = v.name
GROUP BY sub.name, s.name
ORDER BY 3 DESC
LIMIT 1;
