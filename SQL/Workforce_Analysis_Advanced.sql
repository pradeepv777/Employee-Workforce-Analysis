-- 1. Highest Paid Employees in Each Department
SELECT *
FROM (
    SELECT EmployeeNumber,
           Department,
           MonthlyIncome,
           DENSE_RANK() OVER (
               PARTITION BY Department
               ORDER BY MonthlyIncome DESC
           ) AS SalaryRank
    FROM employee
) AS ranked_salary
WHERE SalaryRank = 1;

-- 2. Department-wise Attrition Rate
SELECT Department,
       ROUND(
           COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 /
           COUNT(*), 2
       ) AS AttritionRate
FROM employee
GROUP BY Department;

-- 3. Top 3 Highest Paid Employees in Each Department
SELECT *
FROM (
    SELECT Department,
           EmployeeNumber,
           MonthlyIncome,
           DENSE_RANK() OVER (
               PARTITION BY Department
               ORDER BY MonthlyIncome DESC
           ) AS SalaryRank
    FROM employee
) AS ranked_salary
WHERE SalaryRank <= 3;

-- 4. Employees Earning More Than Their Department Average
SELECT EmployeeNumber,
       Department,
       MonthlyIncome
FROM employee e
WHERE MonthlyIncome >
(
    SELECT AVG(MonthlyIncome)
    FROM employee e1
    WHERE e.Department = e1.Department
);

-- 5. Department with Highest Attrition Rate
SELECT Department,
       ROUND(
           COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 /
           COUNT(*)
       ) AS AttritionRate
FROM employee
GROUP BY Department
ORDER BY AttritionRate DESC
LIMIT 1;

-- 6. Salary Ranking using Window Functions
SELECT EmployeeNumber,
       MonthlyIncome,
       DENSE_RANK() OVER (
           ORDER BY MonthlyIncome DESC
       ) AS DenseRank,
       RANK() OVER (
           ORDER BY MonthlyIncome DESC
       ) AS RankValue,
       ROW_NUMBER() OVER (
           ORDER BY MonthlyIncome DESC
       ) AS RowNumber
FROM employee;

-- 7. Departments with Attrition Rate More Than 20%
SELECT Department,
       ROUND(
           COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 /
           COUNT(*)
       ) AS AttritionRate
FROM employee
GROUP BY Department
HAVING AttritionRate > 20;

-- 8. Salary Difference from Department Maximum
SELECT Department,
       EmployeeNumber,
       MonthlyIncome,
       MAX(MonthlyIncome) OVER (
           PARTITION BY Department
       ) AS HighestDepartmentSalary,
       MAX(MonthlyIncome) OVER (
           PARTITION BY Department
       ) - MonthlyIncome AS SalaryDifference
FROM employee;

-- 9. Departments Where Employees Who Left Earn More Than Those Who Stayed
SELECT Department,
       AVG(CASE WHEN Attrition = 'Yes'
                THEN MonthlyIncome END) AS AvgSalaryLeft,
       AVG(CASE WHEN Attrition = 'No'
                THEN MonthlyIncome END) AS AvgSalaryStayed
FROM employee
GROUP BY Department
HAVING AvgSalaryLeft > AvgSalaryStayed;

-- 10. Top 10% Highest Paid Employees
SELECT EmployeeNumber,
       SalaryRank
FROM (
    SELECT EmployeeNumber,
           RANK() OVER (
               ORDER BY MonthlyIncome DESC
           ) AS SalaryRank,
           COUNT(*) OVER () AS TotalEmployees
    FROM employee
) AS salary_rank
WHERE SalaryRank <= (TotalEmployees / 10);

-- 11. Second Highest Salary in Each Department
SELECT *
FROM (
    SELECT EmployeeNumber,
           Department,
           MonthlyIncome,
           DENSE_RANK() OVER (
               PARTITION BY Department
               ORDER BY MonthlyIncome DESC
           ) AS SalaryRank
    FROM employee
) AS ranked_salary
WHERE SalaryRank = 2;