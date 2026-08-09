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

### Workforce Composition
- Total workforce: **1,470 employees** — Research & Development dominates with **961 (65%)**, followed by Sales at **446 (30%)** and Human Resources at **63 (5%)**.
- Gender split: **882 males (60%)** and **588 females (40%)**.

### Attrition
- Overall attrition rate: **16.12%** — 237 employees left out of 1,470.
- **Sales has the highest attrition rate at 21%**, the only department exceeding the 20% threshold. R&D and HR are below it.
- By volume, R&D lost the most employees (**133**), but this reflects its larger headcount. Sales has a worse rate proportionally.
- **Laboratory Technicians (62)** and **Sales Executives (57)** account for the highest attrition counts by job role, followed by Research Scientists (47).
- Overtime is a strong attrition signal: employees working overtime left at a rate of **~30.5%** (127 out of 416), vs **~10.4%** (110 out of 1,054) for those without overtime — nearly **3× higher**.
- Male employees account for more attrition in absolute numbers (**150 vs 87**), consistent with their larger share of the workforce.

### Compensation
- **Sales** pays the highest average monthly salary (**$6,959**), followed by Human Resources (**$6,655**) and R&D (**$6,281**).
- Top earners are concentrated in **Manager** and **Research Director** roles, with the highest paid employee earning **$19,999/month** (Employee #259, R&D).

