# Power BI Data Model Architecture

This document describes a **proposed dimensional modeling architecture (Star Schema)** for the **Employee Workforce & Attrition Analysis** dataset.

> **Implementation Note**: The current `Employee_Workforce_Analysis.pbix` report imports the dataset as a single flat table (`employee`). The architecture below documents how the data can be normalized into a standard Star Schema for scalable enterprise BI deployment, optimized filtering, and clean separation of concerns.

---

## 1. Architectural Strategy: From Flat Table to Dimensional Star Schema

The raw dataset (`WA_Fn-UseC_-HR-Employee-Attrition.csv`) is provided as a single, denormalized 35-column flat table. In enterprise Power BI deployments, operating directly on wide flat tables can introduce maintenance challenges, redundant string storage, and slower DAX evaluation.

To illustrate production-grade business intelligence standards, we specify a proposed **Star Schema** architecture centered around a single fact table and four clean dimension tables:

```
       +-----------------------+
       |    Dim_Department     |
       +-----------------------+
       | * DepartmentID (PK)   |
       |   DepartmentName      |
       +-----------+-----------+
                   |
                   | 1
                   |
                   | *
+------------------+------------------+         +-----------------------+
|              Fact_Employee          |         |      Dim_JobRole      |
+-------------------------------------+         +-----------------------+
| * EmployeeNumber (PK)               |<--------| * JobRoleID (PK)      |
|   DepartmentID (FK)                 |*       1|   JobRoleTitle        |
|   JobRoleID (FK)                    |         |   JobLevel            |
|   DemographicID (FK)                |         +-----------------------+
|   SatisfactionID (FK)               |
|   MonthlyIncome                     |         +-----------------------+
|   YearsAtCompany                    |         |   Dim_Demographics    |
|   YearsInCurrentRole                |         +-----------------------+
|   YearsSinceLastPromotion           |<--------| * DemographicID (PK)  |
|   YearsWithCurrManager              |*       1|   Gender              |
|   TotalWorkingYears                 |         |   AgeGroup / Age      |
|   OverTime (Yes/No)                 |         |   MaritalStatus       |
|   Attrition (Yes/No)                |         |   EducationField      |
+------------------+------------------+         +-----------------------+
                   |
                   | *
                   |
                   | 1
       +-----------+-----------+
       |   Dim_Satisfaction    |
       +-----------------------+
       | * SatisfactionID (PK) |
       |   EnvironmentSatisf.  |
       |   JobSatisfaction     |
       |   RelationshipSatisf. |
       |   WorkLifeBalance     |
       +-----------------------+
```

---

## 2. Table Specifications

### 2.1 Fact_Employee (Fact Table)
Stores individual employee workforce metrics, compensation figures, service durations, and status flags.
- **Grain:** 1 row per employee (`1,470` rows).
- **Primary Key:** `EmployeeNumber`
- **Foreign Keys:** `DepartmentID`, `JobRoleID`, `DemographicID`, `SatisfactionID`
- **Numeric Measures:** `MonthlyIncome`, `YearsAtCompany`, `YearsInCurrentRole`, `YearsSinceLastPromotion`, `YearsWithCurrManager`, `TotalWorkingYears`, `DailyRate`, `HourlyRate`, `MonthlyRate`, `PercentSalaryHike`.
- **Status Indicators:** `Attrition` (`Yes`/`No`), `OverTime` (`Yes`/`No`).

### 2.2 Dim_Department (Dimension)
- **Primary Key:** `DepartmentID`
- **Attributes:** `DepartmentName` (`Sales`, `Research & Development`, `Human Resources`).
- **Cardinality:** 3 rows (1:Many relationship to `Fact_Employee`).

### 2.3 Dim_JobRole (Dimension)
- **Primary Key:** `JobRoleID`
- **Attributes:** `JobRoleTitle` (9 roles: `Sales Representative`, `Laboratory Technician`, `Research Scientist`, etc.), `JobLevel` (1 to 5).
- **Cardinality:** 9 rows (1:Many relationship to `Fact_Employee`).

### 2.4 Dim_Demographics (Dimension)
- **Primary Key:** `DemographicID`
- **Attributes:** `Gender`, `Age`, `AgeGroup` (`Under 30`, `30-39`, `40-49`, `50+`), `MaritalStatus`, `Education`, `EducationField`.
- **Cardinality:** 1:Many relationship to `Fact_Employee`.

### 2.5 Dim_Satisfaction (Dimension)
- **Primary Key:** `SatisfactionID`
- **Attributes:** `JobSatisfaction` (1-4), `EnvironmentSatisfaction` (1-4), `RelationshipSatisfaction` (1-4), `WorkLifeBalance` (1-4).
- **Cardinality:** 1:Many relationship to `Fact_Employee`.

---

## 3. Modeling Best Practices Implemented
1. **Single-Direction Filter Flow (1 → *)**: All relationships use single-directional cross-filtering from dimension tables down to `Fact_Employee`, preventing ambiguity and circular dependencies.
2. **Column Hiding in Reporting View**: Foreign key IDs and raw numeric flags are hidden from report view, exposing only friendly dimension attributes and certified DAX measures.
3. **Optimized Data Types**:
   - Zero-variance columns (`EmployeeCount`, `Over18`, `StandardHours`) removed in Power Query M script to reduce in-memory footprint.
   - Text fields trimmed and clean; numeric flags typed as whole numbers / currency.
