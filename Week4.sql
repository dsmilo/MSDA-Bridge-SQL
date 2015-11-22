DROP SCHEMA IF EXISTS org_chart;
CREATE SCHEMA org_chart;
USE org_chart;

DROP TABLE IF EXISTS staff;

CREATE TABLE staff (
	emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    emp_title VARCHAR(50) NOT NULL,
    manager_id INT
    );

INSERT INTO staff (emp_id, emp_name, emp_title, manager_id)
	VALUES
		(1, 'Gil Quinones','CEO',NULL),
		(2, 'Ed Welz', 'COO', 1),
		(3, 'Jim Pasquale', 'SVP CES', 1),
		(4, 'Kristin Barbato', 'VP ESD', 3),
		(5, 'Keith Hayes', 'VP Marketing', 3),
		(6, 'Jake Berlin', 'Director ESM', 4),
        (7, 'Joe Rende', 'Director CBD', 4),
        (8, 'Dan Smilowitz', 'Sr Analyst', 6);

SELECT employees.emp_name as Employee, employees.emp_title AS Title, managers.emp_name as Manager
FROM staff AS employees
LEFT JOIN staff AS managers
ON employees.manager_id = managers.emp_id;