--6. Найти список студентов в определенной группе.
WITH var AS (SELECT id, code FROM study_groups LIMIT 1 OFFSET ABS(RANDOM()) % MAX((SELECT COUNT(*) FROM study_groups), 1))
SELECT g.code [Group], s.name [Student]
FROM study_groups g
CROSS JOIN var v
JOIN students s on s.id = g.student_id
WHERE g.code = v.code
ORDER BY 2;
