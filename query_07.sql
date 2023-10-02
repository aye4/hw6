--7. Найти оценки студентов в отдельной группе по определенному предмету.
WITH var AS (SELECT 
 (SELECT name FROM subjects LIMIT 1 OFFSET ABS(RANDOM()) % MAX((SELECT COUNT(*) FROM subjects), 1)) [subject],
 (SELECT code FROM study_groups LIMIT 1 OFFSET ABS(RANDOM()) % MAX((SELECT COUNT(*) FROM study_groups), 1)) [group_code]
)
SELECT g.code [Group], sub.name [Subject], s.name [Student], m.mark [Mark], m.date_mark [Date]
FROM var v
JOIN subjects sub ON sub.name = v.subject
JOIN study_groups g ON g.code = v.group_code
JOIN students s ON s.id = g.student_id 
JOIN marks m on m.subject_id = sub.id AND m.student_id = s.id
ORDER BY 3, 5;
