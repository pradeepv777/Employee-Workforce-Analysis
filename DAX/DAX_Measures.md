# DAX Measures Documentation

This document catalogs recommended **Data Analysis Expressions (DAX)** measures designed for workforce and attrition reporting.

> **Implementation Note**: The current `Employee_Workforce_Analysis.pbix` file utilizes a flat table structure with native aggregations and a basic Attrition Rate measure. The measures documented below represent standardized formulations for dimensional models and extended analytical reporting.

---

## 1. Core Workforce Headcount & Volume Measures

### 1.1 Total Employees
Calculates the total headcount across all employee records in the workforce table.
```dax
Total Employees = 
COUNTROWS('Fact_Employee')
```
- **Format:** Whole Number (`#,##0`)
- **Use Case:** Summary KPI card, base denominator for rate calculations.

### 1.2 Attrition Count
Counts the total number of employees who have departed the organization in the observed dataset.
```dax
Attrition Count = 
CALCULATE(
    COUNTROWS('Fact_Employee'),
    'Fact_Employee'[Attrition] = "Yes"
)
```
- **Format:** Whole Number (`#,##0`)
- **Use Case:** Summary KPI card, trend visual numerators.

### 1.3 Active Employees
Calculates the active, retained workforce currently employed.
```dax
Active Employees = 
CALCULATE(
    COUNTROWS('Fact_Employee'),
    'Fact_Employee'[Attrition] = "No"
)
```
- **Format:** Whole Number (`#,##0`)
- **Use Case:** Current operational capacity KPI.

---

## 2. Rate & Performance Measures

### 2.1 Attrition Rate (%)
Calculates the proportion of departed employees relative to total headcount. Uses `DIVIDE` to handle potential division-by-zero errors safely.
```dax
Attrition Rate = 
DIVIDE(
    [Attrition Count],
    [Total Employees],
    0
)
```
- **Format:** Percentage (`0.00%`)
- **Baseline Observed Value:** `16.12%`
- **Use Case:** Primary retention KPI card, bar charts across Department and Job Role.

### 2.2 Overtime Attrition Rate (%)
Calculates the specific attrition rate for the segment of employees who work overtime.
```dax
Overtime Attrition Rate = 
CALCULATE(
    [Attrition Rate],
    'Fact_Employee'[OverTime] = "Yes"
)
```
- **Format:** Percentage (`0.00%`)
- **Baseline Observed Value:** `30.53%` (127 departed / 416 overtime workers)
- **Use Case:** Workforce analysis card comparing turnover between overtime and standard-hours cohorts.

### 2.3 Non-Overtime Attrition Rate (%)
Calculates the attrition rate for employees without overtime obligations.
```dax
Non-Overtime Attrition Rate = 
CALCULATE(
    [Attrition Rate],
    'Fact_Employee'[OverTime] = "No"
)
```
- **Format:** Percentage (`0.00%`)
- **Baseline Observed Value:** `10.44%` (110 departed / 1,054 standard hours workers)
- **Use Case:** Benchmark baseline card to compare turnover differences across work hours.

---

## 3. Compensation & Tenure Averages

### 3.1 Average Monthly Income
Calculates the arithmetic mean of monthly employee salaries across the active filter context.
```dax
Avg Monthly Income = 
AVERAGE('Fact_Employee'[MonthlyIncome])
```
- **Format:** Currency (`$#,##0`)
- **Baseline Observed Value:** `$6,503` (Overall) | `$6,833` (Retained) | `$4,787` (Departed)
- **Use Case:** Compensation benchmarking visual, Department/Role salary comparisons.

### 3.2 Average Tenure (Years at Company)
Calculates the mean number of completed service years within the organization.
```dax
Avg Tenure = 
AVERAGE('Fact_Employee'[YearsAtCompany])
```
- **Format:** Decimal Number (`0.0 years`)
- **Baseline Observed Value:** `7.0 years` (Overall) | `7.4 years` (Retained) | `5.1 years` (Departed)
- **Use Case:** Workforce maturity indicator.

---

## 4. Analytical Turnover-Cost Scenario Modeling

### 4.1 Estimated Turnover Cost (Illustrative Scenario)
Calculates an illustrative financial scenario estimate based on industry benchmark assumptions (e.g., SHRM / Gallup replacement-cost guidelines).
```dax
Estimated Turnover Cost = 
SUMX(
    FILTER('Fact_Employee', 'Fact_Employee'[Attrition] = "Yes"),
    'Fact_Employee'[MonthlyIncome] * 12 * 0.50
)
```
- **Format:** Currency (`$#,##0,,.0M` or `$#,##0`)
- **Scenario Estimate:** `~$6,810,000` (Based on 237 departed × annual salary × assumed 50% replacement multiplier)
- **Assumptions & Caveats:**
  > [!NOTE]
  > **Modeling Disclaimer**: This calculation is an illustrative scenario estimate based on an assumed 50% replacement-cost factor; this is not observed company financial data, verified business impact, measured savings, or ROI. It is provided strictly as a documented methodology for how financial impact could be modeled in organizational decision support.

---

## 5. Metric Reference & Validation Cross-Check

| Measure Name | DAX Expression Summary | Expected Baseline (Full Dataset) |
| :--- | :--- | :--- |
| **Total Employees** | `COUNTROWS(Fact_Employee)` | `1,470` |
| **Attrition Count** | `CALCULATE(..., Attrition="Yes")` | `237` |
| **Active Employees** | `CALCULATE(..., Attrition="No")` | `1,233` |
| **Attrition Rate** | `DIVIDE([Attrition Count], [Total Employees], 0)` | `16.12%` |
| **Overtime Attrition Rate** | `CALCULATE([Attrition Rate], OverTime="Yes")` | `30.53%` |
| **Non-Overtime Attrition Rate**| `CALCULATE([Attrition Rate], OverTime="No")` | `10.44%` |
| **Avg Monthly Income** | `AVERAGE(Fact_Employee[MonthlyIncome])` | `$6,503` |
| **Avg Tenure** | `AVERAGE(Fact_Employee[YearsAtCompany])` | `7.0 years` |
