# Employee Workforce & Attrition Analysis

An end-to-end People Analytics project analyzing employee turnover patterns across 1,470 records. This project connects **MySQL database querying**, **Python statistical modeling**, and **Power BI interactive reporting** to diagnose flight-risk drivers and provide actionable HR retention strategies.

---

##  Dashboard Preview

<p align="center">
  <img width="100%" alt="Power BI Dashboard" src="https://github.com/user-attachments/assets/742c7f77-5438-42cc-97e1-4ff6af62a29e" />
</p>

---

## Key Findings & Business Takeaways

| Finding | Metric / Evidence | Business Impact |
| :--- | :--- | :--- |
| **Overtime Flight Risk** | **30.5%** turnover with overtime vs. **10.4%** without (4.6× higher odds) | Chronic overtime is the single strongest turnover signal across all departments. |
| **Early-Tenure Drop-Off** | **51.5%** of all departures happen within the first 3 years (`<1 yr` rate: **36.4%**) | Flight risk stabilizes significantly after year 3, highlighting an onboarding retention gap. |
| **High-Risk Roles** | **Sales Reps (39.8%)** and **Lab Techs (23.9%)** lead turnover | Operational and field roles need targeted career progression and compensation reviews. |
| **Compensation Gap** | Departing staff earn **$2,002/mo less** (median $3,202 vs. $5,204 retained) | Pay disparity and promotion stagnation (16% higher odds per unpromoted year) accelerate exits. |

---

## Tech Stack & Workflow

```
[ IBM HR Dataset (1.47k) ] ──▶ [ MySQL Analytics ] ──▶ [ Python Inference ] ──▶ [ Power BI Dashboard ]
                                (CTEs & Windows)        (Chi-Sq, Logit)         (DAX & Star Schema)
```

| Technology | Focus Area | Applied Techniques |
| :--- | :--- | :--- |
| **MySQL** | Data querying & cohort segmentation | Window functions (`DENSE_RANK`, `ROW_NUMBER`), CTEs, multi-dimensional grouping, rate-based ranking. |
| **Python** | Statistical hypothesis testing & modeling | Chi-Square tests, Mann-Whitney U test, multivariable Logistic Regression (`statsmodels`), Seaborn. |
| **Power BI** | Visual reporting & KPI monitoring | 4-page interactive report, global slicers, custom tooltips, cross-filtering. |
| **DAX & Modeling** | Data architecture & calculation layer | Star Schema modeling (`Fact_Employee` + 4 Dimensions), standardized DAX formulas (`DIVIDE`, `CALCULATE`). |

---

## Project Architecture

```
EmployeeWorkforceAnalysis/
|-- Dataset/
|   `-- WA_Fn-UseC_-HR-Employee-Attrition.csv      # IBM HR benchmark dataset (1,470 rows)
|-- SQL/
|   |-- Workforce_Analysis.sql                    # Core aggregations, CTEs, basic queries
|   |-- Workforce_Analysis_Advanced.sql           # Subqueries, window functions, salary rankings
|   `-- Workforce_Analysis_Cohorts.sql            # Tenure cohorts, cross-rates & rate rankings
|-- notebooks/
|   `-- HR_Workforce_Statistical_Analysis.ipynb   # Executed Jupyter Notebook (EDA & Stats)
|-- DAX/
|   |-- DAX_Measures.md                           # Standardized DAX expressions & KPI catalog
|   `-- Data_Model_Architecture.md                # Proposed Star Schema design specification
|-- Power BI/
|   `-- Employee_Workforce_Analysis.pbix          # Interactive Power BI report file
|-- QueryOutputs/                                 # 30 verified CSV query exports
|-- Screenshots/                                  # High-resolution dashboard page screenshots
`-- README.md                                     # Project portfolio documentation
```

---

## Analytical Breakdown

### 1. SQL Analysis ([`SQL/`](file:///c:/Users/prade/OneDrive/Desktop/Proj/EmployeeWorkforceAnalysis/SQL))
- **Core Queries ([`Workforce_Analysis.sql`](file:///c:/Users/prade/OneDrive/Desktop/Proj/EmployeeWorkforceAnalysis/SQL/Workforce_Analysis.sql))**: Headcount baselines, department distributions, gender splits, and initial turnover volumes.
- **Advanced Queries ([`Workforce_Analysis_Advanced.sql`](file:///c:/Users/prade/OneDrive/Desktop/Proj/EmployeeWorkforceAnalysis/SQL/Workforce_Analysis_Advanced.sql))**: Departmental salary rankings with `DENSE_RANK()`, `RANK()`, `ROW_NUMBER()`, salary deltas from department maximums, and correlated subqueries.
- **Cohort & Rate Analysis ([`Workforce_Analysis_Cohorts.sql`](file:///c:/Users/prade/OneDrive/Desktop/Proj/EmployeeWorkforceAnalysis/SQL/Workforce_Analysis_Cohorts.sql))**: Eliminates scale bias by computing proportional turnover rates. Segments employees into tenure brackets (`<1 yr`, `1-3 yrs`, `3-5 yrs`, `5+ yrs`) and multi-dimensional cross-analyses (`Department × OverTime`, `Job Role × OverTime`).

### 2. Statistical Analysis & Modeling ([`notebooks/`](file:///c:/Users/prade/OneDrive/Desktop/Proj/EmployeeWorkforceAnalysis/notebooks))
- **OverTime Independence Test**: Chi-Square test confirms overtime is significantly associated with turnover ($\chi^2 = 87.56, p < 0.001$).
- **Salary Difference Test**: Non-parametric Mann-Whitney U test confirms departing staff earn significantly less than retained peers ($U = 191,600.5, p < 0.001$).
- **Multivariable Logistic Regression**: Quantifies adjusted flight risk:
  - **OverTime**: **4.60×** higher odds of attrition ($p < 0.001$).
  - **Years Since Last Promotion**: **+16%** higher odds per unpromoted year ($p < 0.001$).
  - **Job Satisfaction**: **-27%** lower odds per 1-point satisfaction increase ($p < 0.001$).
  - **Environment Satisfaction**: **-30%** lower odds per 1-point increase ($p < 0.001$).

### 3. Power BI Dashboard & DAX ([`Power BI/`](file:///c:/Users/prade/OneDrive/Desktop/Proj/EmployeeWorkforceAnalysis/Power%20BI) & [`DAX/`](file:///c:/Users/prade/OneDrive/Desktop/Proj/EmployeeWorkforceAnalysis/DAX))
- **Dashboard Pages**:
  - **Page 1: Workforce Overview**: Headcount distributions across departments and gender, core volume KPIs.
  - **Page 2: Attrition Analysis**: Department and role turnover, overtime disparity visual.
  - **Page 3: Compensation Analysis**: Average salaries by department and role, top-earner tracking.
  - **Page 4: Summary Dashboard**: Executive single-page view combining key retention metrics and global slicers.
- **Data Model Architecture ([`Data_Model_Architecture.md`](file:///c:/Users/prade/OneDrive/Desktop/Proj/EmployeeWorkforceAnalysis/DAX/Data_Model_Architecture.md))**: Documents transition from flat table to an enterprise Star Schema (`Fact_Employee` + 4 dimension tables).
- **DAX Formula Catalog ([`DAX_Measures.md`](file:///c:/Users/prade/OneDrive/Desktop/Proj/EmployeeWorkforceAnalysis/DAX/DAX_Measures.md))**: Standardized formulas for headcount, attrition rates, and turnover cost scenario modeling.

---

## How to Run

1. **Database Setup (MySQL)**:
   Import `Dataset/WA_Fn-UseC_-HR-Employee-Attrition.csv` into MySQL and execute the scripts in [`SQL/`](file:///c:/Users/prade/OneDrive/Desktop/Proj/EmployeeWorkforceAnalysis/SQL) sequentially.
2. **Run Notebook (Python)**:
   ```bash
   pip install pandas numpy scipy matplotlib seaborn statsmodels jupyter
   jupyter notebook notebooks/HR_Workforce_Statistical_Analysis.ipynb
   ```
3. **Open Dashboard (Power BI)**:
   Open [`Power BI/Employee_Workforce_Analysis.pbix`](file:///c:/Users/prade/OneDrive/Desktop/Proj/EmployeeWorkforceAnalysis/Power%20BI/Employee_Workforce_Analysis.pbix) in Power BI Desktop to explore the interactive reports and slicers.

---

