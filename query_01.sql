--1. ����� 5 ��������� � ���������� ������� ������ �� ���� ���������.
SELECT s.name [Student], avg(m.mark) [AVG Mark]
FROM students s
JOIN marks m ON m.student_id = s.id
GROUP BY s.name
ORDER BY 2 DESC
LIMIT 5;
