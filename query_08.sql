--8. Ќайти средний балл, который ставит определенный преподаватель по своим предметам.
WITH var AS (SELECT id, name FROM teachers LIMIT 1 OFFSET ABS(RANDOM()) % MAX((SELECT COUNT(*) FROM teachers), 1))
SELECT t.name [Teacher], avg(m.mark) [AVG Mark]
FROM teachers t
CROSS JOIN var v
JOIN subjects sub ON sub.teacher_id = t.id
JOIN marks m on m.subject_id = sub.id
WHERE t.name = v.name
