-- Dataset : IBM HR Analytics Employee Attrition

-- create and using below DB
use employee_workforce_analysis;

-- 1. Total Employees
SELECT COUNT(*) AS TotalEmployees
FROM employee;

-- 2. Attrition Count
SELECT COUNT(*) AS EmployeesLeft
FROM employee
WHERE Attrition='Yes';

-- 3. Attrition Rate
SELECT 
COUNT(CASE WHEN Attrition='Yes' THEN 1 END)*100.0/
COUNT(*)
 AS AttritionRate
FROM employee;

-- 4. Department-wise Employee Count
SELECT Department,
       COUNT(*) AS EmployeeCount
FROM employee
GROUP BY Department
ORDER BY EmployeeCount DESC;

-- 5. Attrition by Department
SELECT Department,
       COUNT(*) AS Employees,
       SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS AttritionCount
FROM employee
GROUP BY Department;

-- 6. Gender Distribution
SELECT Gender,
       COUNT(*) AS EmployeeCount
FROM employee
GROUP BY Gender;

-- 7. Attrition by Gender
SELECT Gender,
       SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS AttritionCount
FROM employee
GROUP BY Gender;

-- 8. Average Salary by Department
SELECT Department,
       AVG(MonthlyIncome) AS AvgSalary
FROM employee
GROUP BY Department
ORDER BY AvgSalary DESC;

-- 9. Job Role-wise Employee Count
SELECT JobRole,
       COUNT(*) AS EmployeeCount
FROM employee
GROUP BY JobRole
ORDER BY EmployeeCount DESC;

-- 10. Attrition by Job Role
SELECT JobRole,
       SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS AttritionCount
FROM employee
GROUP BY JobRole
ORDER BY AttritionCount DESC;

-- 11. Overtime vs Attrition
SELECT OverTime,
       COUNT(*) AS Employees,
       SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS AttritionCount
FROM employee
GROUP BY OverTime;

-- 12. Top 10 Highest Paid Employees
SELECT EmployeeNumber,
       JobRole,
       MonthlyIncome
FROM employee
ORDER BY MonthlyIncome DESC
LIMIT 10;

-- 13. CTE (Dept wise average salary)
WITH department_salary AS (
    SELECT Department,
           AVG(MonthlyIncome) AS AvgSalary
    FROM employee
    GROUP BY Department
)
SELECT *
FROM department_salary
ORDER BY AvgSalary DESC; 

-- 14. Window Functions (Salary Ranking)
SELECT EmployeeNumber,
       JobRole,
       MonthlyIncome,
       DENSE_RANK() OVER(
           ORDER BY MonthlyIncome DESC
       ) AS SalaryRank
FROM employee;