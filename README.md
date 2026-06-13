# Employee Workforce Analysis

## Project Overview

This project analyzes employee workforce data using **MySQL** and **Power BI** to identify workforce trends, employee attrition patterns, compensation insights, and departmental performance.

The goal is to transform raw HR data into meaningful business insights through SQL analysis and interactive Power BI dashboards.

---

## Tools Used

- MySQL
- Power BI
- SQL

---

## Dataset

**IBM HR Analytics Employee Attrition Dataset**

- **Records:** 1,470 Employees
- The dataset contains employee demographics, salary information, job roles, work experience, overtime details, satisfaction scores, and attrition status.

---

## SQL Analysis

### Concepts Used

- **Aggregate Functions:** `COUNT()`, `AVG()`, `SUM()`
- `GROUP BY`
- `ORDER BY`
- `CASE WHEN`
- **Common Table Expressions (CTE)**
- **Window Functions:** `DENSE_RANK()`

### Key SQL Analyses

| # | Analysis |
|---|----------|
| 1 | Total Employees |
| 2 | Employee Attrition Count |
| 3 | Attrition Rate |
| 4 | Department-wise Employee Count |
| 5 | Attrition by Department |
| 6 | Gender Distribution |
| 7 | Attrition by Gender |
| 8 | Average Salary by Department |
| 9 | Job Role-wise Employee Count |
| 10 | Attrition by Job Role |
| 11 | Overtime vs Attrition |
| 12 | Top 10 Highest Paid Employees |
| 13 | Department Salary Analysis using CTE |
| 14 | Employee Salary Ranking using `DENSE_RANK()` |

---

## Power BI Dashboard

### Page 1: Workforce Overview

**KPIs:**
- Employee Count
- Employees Left
- Attrition Rate
- Average Monthly Salary

**Visuals:**
- Department-wise Employee Count
- Gender Distribution

---

### Page 2: Attrition Analysis

**Visuals:**
- Attrition by Department
- Attrition by Job Role
- Overtime vs Attrition

**Filters:**
- Department
- Gender
- Job Role

---

### Page 3: Compensation Analysis

**Visuals:**
- Average Salary by Department
- Average Salary by Job Role
- Top Paid Employees

**Filters:**
- Department
- Job Role

---

## Key Insights

- The overall employee attrition rate is approximately **16%**.
- **Research & Development** has the highest employee count.
- Employees working **overtime** show higher attrition compared to those not working overtime.
- Attrition varies significantly across **job roles**.
- Salary distribution differs across **departments** and **job roles**.
- **Senior roles** generally receive higher compensation.
