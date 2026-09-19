USE employee_workforce_analysis;

-- SECTION 1: COHORT ANALYSIS

-- 1.1 Attrition by Company Tenure Cohorts
-- Identifies critical retention drop-offs across organizational tenure stages
SELECT 
    CASE 
        WHEN YearsAtCompany < 1 THEN '<1 year'
        WHEN YearsAtCompany BETWEEN 1 AND 3 THEN '1-3 years'
        WHEN YearsAtCompany BETWEEN 4 AND 5 THEN '3-5 years'
        ELSE '5+ years'
    END AS TenureCohort,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1.0 ELSE 0.0 END) * 100.0 / COUNT(*), 2) AS AttritionRatePct,
    ROUND(AVG(MonthlyIncome), 2) AS AvgMonthlyIncome
FROM employee
GROUP BY 
    CASE 
        WHEN YearsAtCompany < 1 THEN '<1 year'
        WHEN YearsAtCompany BETWEEN 1 AND 3 THEN '1-3 years'
        WHEN YearsAtCompany BETWEEN 4 AND 5 THEN '3-5 years'
        ELSE '5+ years'
    END
ORDER BY AttritionRatePct DESC;


-- 1.2 Attrition by Age Cohorts
-- Evaluates workforce turnover across career stages
SELECT 
    CASE 
        WHEN Age < 30 THEN 'Under 30'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49'
        ELSE '50+'
    END AS AgeCohort,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1.0 ELSE 0.0 END) * 100.0 / COUNT(*), 2) AS AttritionRatePct,
    ROUND(AVG(MonthlyIncome), 2) AS AvgMonthlyIncome
FROM employee
GROUP BY 
    CASE 
        WHEN Age < 30 THEN 'Under 30'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49'
        ELSE '50+'
    END
ORDER BY AttritionRatePct DESC;


-- SECTION 2: MULTI-DIMENSIONAL CROSS-ANALYSIS

-- 2.1 Department x OverTime Attrition Cross-Analysis
-- Evaluates whether the overtime attrition effect varies across functional areas
SELECT 
    Department,
    OverTime,
    COUNT(*) AS EmployeeCount,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1.0 ELSE 0.0 END) * 100.0 / COUNT(*), 2) AS AttritionRatePct
FROM employee
GROUP BY Department, OverTime
ORDER BY Department, OverTime;


-- 2.2 Job Role x OverTime Attrition Cross-Analysis
-- Pinpoints high-risk role and overtime combinations
SELECT 
    JobRole,
    OverTime,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1.0 ELSE 0.0 END) * 100.0 / COUNT(*), 2) AS AttritionRatePct
FROM employee
GROUP BY JobRole, OverTime
ORDER BY JobRole, OverTime;


-- 2.3 Job Level x Attrition & Compensation Progression
-- Evaluates career hierarchy impact on turnover and compensation
SELECT 
    JobLevel,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1.0 ELSE 0.0 END) * 100.0 / COUNT(*), 2) AS AttritionRatePct,
    ROUND(AVG(MonthlyIncome), 2) AS AvgMonthlyIncome,
    MIN(MonthlyIncome) AS MinMonthlyIncome,
    MAX(MonthlyIncome) AS MaxMonthlyIncome
FROM employee
GROUP BY JobLevel
ORDER BY JobLevel ASC;


-- 2.4 Job Satisfaction x Attrition Analysis
-- Tests correlation between reported workplace satisfaction and turnover
SELECT 
    JobSatisfaction,
    CASE JobSatisfaction
        WHEN 1 THEN 'Low'
        WHEN 2 THEN 'Medium'
        WHEN 3 THEN 'High'
        WHEN 4 THEN 'Very High'
    END AS SatisfactionLevel,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1.0 ELSE 0.0 END) * 100.0 / COUNT(*), 2) AS AttritionRatePct
FROM employee
GROUP BY JobSatisfaction
ORDER BY JobSatisfaction ASC;


-- 2.5 Monthly Income Bracket x Attrition Rate
-- Segments compensation into four operational salary tiers
SELECT 
    CASE 
        WHEN MonthlyIncome < 3000 THEN 'Entry Level (<$3k)'
        WHEN MonthlyIncome BETWEEN 3000 AND 4999 THEN 'Lower-Mid ($3k-$5k)'
        WHEN MonthlyIncome BETWEEN 5000 AND 9999 THEN 'Upper-Mid ($5k-$10k)'
        ELSE 'Senior Level ($10k+)'
    END AS IncomeBracket,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1.0 ELSE 0.0 END) * 100.0 / COUNT(*), 2) AS AttritionRatePct,
    ROUND(AVG(MonthlyIncome), 2) AS AvgMonthlyIncome
FROM employee
GROUP BY 
    CASE 
        WHEN MonthlyIncome < 3000 THEN 'Entry Level (<$3k)'
        WHEN MonthlyIncome BETWEEN 3000 AND 4999 THEN 'Lower-Mid ($3k-$5k)'
        WHEN MonthlyIncome BETWEEN 5000 AND 9999 THEN 'Upper-Mid ($5k-$10k)'
        ELSE 'Senior Level ($10k+)'
    END
ORDER BY AttritionRatePct DESC;


-- 2.6 Work-Life Balance x OverTime Interaction
-- Evaluates compounded risk when poor work-life balance coincides with overtime
SELECT 
    WorkLifeBalance,
    OverTime,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1.0 ELSE 0.0 END) * 100.0 / COUNT(*), 2) AS AttritionRatePct
FROM employee
GROUP BY WorkLifeBalance, OverTime
ORDER BY WorkLifeBalance, OverTime;


-- SECTION 3: RATE-BASED RANKINGS & WINDOW FUNCTIONS

-- 3.1 Department Attrition Ranking by Rate (Not Raw Count)
-- Avoids sample size bias between large (R&D: 961) and smaller (Sales: 446) departments
WITH DeptAttrition AS (
    SELECT 
        Department,
        COUNT(*) AS TotalEmployees,
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount,
        ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1.0 ELSE 0.0 END) * 100.0 / COUNT(*), 2) AS AttritionRatePct
    FROM employee
    GROUP BY Department
)
SELECT 
    Department,
    TotalEmployees,
    AttritionCount,
    AttritionRatePct,
    DENSE_RANK() OVER (ORDER BY AttritionRatePct DESC) AS AttritionRateRank
FROM DeptAttrition;


-- 3.2 Job Role Attrition Ranking by Rate
-- Pinpoints roles with highest proportional flight risk
WITH RoleAttrition AS (
    SELECT 
        JobRole,
        COUNT(*) AS TotalEmployees,
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount,
        ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1.0 ELSE 0.0 END) * 100.0 / COUNT(*), 2) AS AttritionRatePct,
        ROUND(AVG(MonthlyIncome), 2) AS AvgMonthlyIncome
    FROM employee
    GROUP BY JobRole
)
SELECT 
    JobRole,
    TotalEmployees,
    AttritionCount,
    AttritionRatePct,
    AvgMonthlyIncome,
    DENSE_RANK() OVER (ORDER BY AttritionRatePct DESC) AS AttritionRank,
    DENSE_RANK() OVER (ORDER BY AvgMonthlyIncome DESC) AS IncomeRank
FROM RoleAttrition;


-- 3.3 Early-Tenure Attrition Flight Risk by Job Role (<= 3 Years Tenure)
-- Identifies which roles suffer the most immediate post-onboarding turnover
WITH EarlyTenure AS (
    SELECT 
        JobRole,
        COUNT(*) AS EarlyTenureEmployees,
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS EarlyAttritionCount,
        ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1.0 ELSE 0.0 END) * 100.0 / COUNT(*), 2) AS EarlyAttritionRatePct
    FROM employee
    WHERE YearsAtCompany <= 3
    GROUP BY JobRole
)
SELECT 
    JobRole,
    EarlyTenureEmployees,
    EarlyAttritionCount,
    EarlyAttritionRatePct,
    DENSE_RANK() OVER (ORDER BY EarlyAttritionRatePct DESC) AS EarlyAttritionRank
FROM EarlyTenure
ORDER BY EarlyAttritionRatePct DESC;
