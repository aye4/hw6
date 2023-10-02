--12. Оценки студентов в определенной группе по определенному предмету на последнем занятии.
WITH var AS (SELECT 
 (SELECT name FROM subjects LIMIT 1 OFFSET ABS(RANDOM()) % MAX((SELECT COUNT(*) FROM subjects), 1)) [subject],
 (SELECT code FROM study_groups LIMIT 1 OFFSET ABS(RANDOM()) % MAX((SELECT COUNT(*) FROM study_groups), 1)) [group_code]
)
SELECT sub.name [Subject], g.code [Group], m.date_mark [Date], s.name [Student], m.mark [Mark]
FROM var v
JOIN subjects sub ON sub.name = v.subject
JOIN study_groups g ON g.code = v.group_code
JOIN students s ON s.id = g.student_id
JOIN marks m ON m.subject_id = sub.id AND m.student_id = s.id AND m.date_mark = (
 SELECT max(m.date_mark)
 FROM var v
 JOIN subjects sub ON sub.name = v.subject
 JOIN study_groups g ON g.code = v.group_code
 JOIN students s ON s.id = g.student_id
 JOIN marks m ON m.subject_id = sub.id AND m.student_id = s.id
)
ORDER BY 4;
