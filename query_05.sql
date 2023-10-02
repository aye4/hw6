--5. Найти какие курсы читает определенный преподаватель.
WITH var AS (SELECT id, name FROM teachers LIMIT 1 OFFSET ABS(RANDOM()) % MAX((SELECT COUNT(*) FROM teachers), 1))
SELECT t.name [Teacher], sub.name [Subject]
FROM var v
JOIN teachers t ON t.name = v.name
LEFT JOIN subjects sub on sub.teacher_id = t.id 
ORDER BY 2;
