--3. Найти средний балл в группах по определенному предмету.
WITH var AS (SELECT id, name FROM subjects LIMIT 1 OFFSET ABS(RANDOM()) % MAX((SELECT COUNT(*) FROM subjects), 1))
SELECT sub.name [Subject], g.code [Group], avg(m.mark) [AVG Mark]
FROM subjects sub
CROSS JOIN var v
JOIN marks m on m.subject_id = sub.id
JOIN students s on s.id = m.student_id
JOIN study_groups g on g.student_id = s.id
WHERE sub.name = v.name
GROUP BY sub.name, g.code
ORDER BY 2;
