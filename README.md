# Employee Workforce Analysis

## Project Overview

This project analyzes employee workforce data using **MySQL** and **Power BI** to identify workforce trends, employee attrition patterns, compensation insights, and departmental performance.

The goal is to transform raw HR data into meaningful business insights through SQL analysis and interactive Power BI dashboards.

---

## Tools Used

- MySQL
- Power BI

---

## Dataset

**IBM HR Analytics Employee Attrition Dataset**

- **Records:** 1,470 Employees
- The dataset contains employee demographics, salary information, job roles, work experience, overtime details, satisfaction scores, and attrition status.

---

## SQL Analysis

Two SQL files cover foundational to advanced analysis.

### Workforce_Analysis.sql — Core Queries

**Concepts Used:** `COUNT()`, `AVG()`, `SUM()`, `GROUP BY`, `ORDER BY`, `CASE WHEN`, CTE, `DENSE_RANK()`

| # | Analysis |
|---|----------|
| 1 | Total Employees |
| 2 | Employee Attrition Count |
| 3 | Attrition Rate |
| 4 | Department-wise Employee Count |
| 5 | Attrition by Department |
| 6 | Gender Distribution |
| 7 | Attrition by Gender |
| 8 | Job Role-wise Employee Count |
| 9 | Attrition by Job Role |
| 10 | Overtime vs Attrition |
| 11 | Top 10 Highest Paid Employees |
| 12 | Department-wise Average Salary using CTE |
| 13 | Employee Salary Ranking using `DENSE_RANK()` |

---

### Workforce_Analysis_Advanced.sql — Advanced Queries

**Concepts Used:** Subqueries, Window Functions (`DENSE_RANK()`, `RANK()`, `ROW_NUMBER()`), `HAVING`, correlated subqueries

| # | Analysis |
|---|----------|
| 1 | Highest Paid Employee in Each Department |
| 2 | Department-wise Attrition Rate |
| 3 | Top 3 Highest Paid Employees per Department |
| 4 | Employees Earning More Than Their Department Average |
| 5 | Department with Highest Attrition Rate |
| 6 | Salary Ranking using `DENSE_RANK`, `RANK`, `ROW_NUMBER` |
| 7 | Departments with Attrition Rate Above 20% |
| 8 | Salary Difference from Department Maximum |
| 9 | Departments Where Employees Who Left Earn More Than Those Who Stayed |
| 10 | Top 10% Highest Paid Employees |
| 11 | Second Highest Salary in Each Department |

---

## Query Outputs

All query results are exported as CSV files in the `QueryOutputs/` folder.

| File | Description |
|------|-------------|
| TotalEmployees.csv | Total employee count |
| EmployeesCount(AttritionCount).csv | Attrition count |
| AttritionRate.csv | Overall attrition rate |
| DepartmentWiseEmpCount.csv | Employee count by department |
| AttritionByDept.csv | Attrition breakdown by department |
| EmpGenderCount.csv | Gender distribution |
| AttritionByGender.csv | Attrition by gender |
| JobWiseEmpCount.csv | Employee count by job role |
| JobWiseAttritionCount.csv | Attrition count by job role |
| OvertimeVsAttrition.csv | Overtime impact on attrition |
| Top10HighestPaidEmp.csv | Top 10 highest paid employees |
| DeptWiseAvgSalary(CommonTableExp).csv | Dept-wise avg salary via CTE |
| SalaryRanking(WindowFunc).csv | Salary ranking using window functions |
| HighestSalDept.csv | Highest paid employee per department |
| Top3HighestPaidEmp(Dept).csv | Top 3 paid employees per department |
| EmpSalVSDeptAvg.csv | Employees earning above dept average |
| DeptHighAttr.csv | Department with highest attrition rate |
| SalRank(WindowFunc).csv | Salary ranking with RANK, DENSE_RANK, ROW_NUMBER |
| DeptAttrAbove20%.csv | Departments with attrition rate above 20% |
| MaxDiffEmpSal.csv | Salary difference from department maximum |
| SecondHighestSalDeptWise.csv | Second highest salary per department |
| Top10%PaidEmp.csv | Top 10% highest paid employees |

---

## Power BI Dashboard

Interactive dashboard built across 4 pages. Screenshots available in the `Screenshots/` folder.

### Page 1: Workforce Overview
- KPIs: Employee Count, Employees Left, Attrition Rate, Avg Monthly Salary
- Visuals: Department-wise Employee Count, Gender Distribution

### Page 2: Attrition Analysis
- Visuals: Attrition by Department, Attrition by Job Role, Overtime vs Attrition
- Filters: Department, Gender, Job Role

### Page 3: Compensation Analysis
- Visuals: Avg Salary by Department, Avg Salary by Job Role, Top Paid Employees
- Filters: Department, Job Role

### Page 4: Dashboard (Summary View)
- A consolidated single-page overview combining key visuals across all analysis areas
- Visuals: Employee Count by Department, Gender Distribution, Attrition by Department, Attrition by Job Role, Overtime vs Employee Attrition, Avg Monthly Salary by Department, Top 10 Highest Salary Employees table
- Filters: Gender, Department, Job Role

---

## Key Insights

- Overall employee attrition rate is approximately **16%**.
- **Research & Development** has the highest employee count.
- Employees working **overtime** show significantly higher attrition.
- Attrition varies considerably across **job roles** and **departments**.
- Some departments show employees who left earning **more** than those who stayed, suggesting compensation may be a factor in attrition.
- **Senior roles** generally receive higher compensation than others.
