-- =============================================================================
-- Enterprise HR Analytics - PostgreSQL Business Queries
-- Author: Nihat (Data Analyst)
-- Database Architecture: Star Schema (1 Fact, 3 Dimensions)
-- =============================================================================

-- -----------------------------------------------------------------------------
-- QUERY 1: Top 3 Attrition Roles & Monthly Salary Cost Impact
-- Business Question: Which top 3 roles experience the highest attrition, and what is the financial impact?
-- -----------------------------------------------------------------------------
SELECT 
    j."JobRole",
    COUNT(*) AS AttritionCount,
    ROUND(AVG(f."MonthlyIncome"), 2) AS AvgMonthlyIncome,
    SUM(f."MonthlyIncome") AS TotalLostMonthlyBudget
FROM fact_employee_attrition f
JOIN dim_job j ON f.job_id = j.job_id
WHERE f."Attrition" = 'Yes'
GROUP BY j."JobRole"
ORDER BY AttritionCount DESC
LIMIT 3;

-- -----------------------------------------------------------------------------
-- QUERY 2: OverTime & Work-Life Balance Interaction
-- Business Question: How does working OverTime affect attrition across WorkLifeBalance ratings?
-- -----------------------------------------------------------------------------
SELECT 
    f."OverTime",
    s."WorkLifeBalance",
    COUNT(*) AS TotalEmployees,
    COUNT(CASE WHEN f."Attrition" = 'Yes' THEN 1 END) AS AttritionCount,
    ROUND(
        COUNT(CASE WHEN f."Attrition" = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 
        2
    ) AS AttritionRatePct
FROM fact_employee_attrition f
JOIN dim_satisfaction s ON f.satisfaction_id = s.satisfaction_id
GROUP BY f."OverTime", s."WorkLifeBalance"
ORDER BY f."OverTime" DESC, s."WorkLifeBalance" ASC;

-- -----------------------------------------------------------------------------
-- QUERY 3: High-Risk Active Staff by Department & Role
-- Business Question: Where are our active employees who earn <$3k or work OverTime located?
-- -----------------------------------------------------------------------------
SELECT 
    j."Department",
    j."JobRole",
    COUNT(*) AS HighRiskEmployeeCount,
    ROUND(AVG(f."YearsAtCompany"), 1) AS AvgTenureYears,
    ROUND(AVG(f."MonthlyIncome"), 2) AS AvgMonthlyIncome
FROM fact_employee_attrition f
JOIN dim_job j ON f.job_id = j.job_id
WHERE f."Attrition" = 'No' 
  AND (f."MonthlyIncome" < 3000 OR f."OverTime" = 'Yes')
GROUP BY j."Department", j."JobRole"
ORDER BY HighRiskEmployeeCount DESC;

-- -----------------------------------------------------------------------------
-- QUERY 4: Salary Gap Analysis using Window Functions (CTE + AVG OVER)
-- Business Question: Are employees who left paid significantly below their JobRole average?
-- -----------------------------------------------------------------------------
WITH RoleSalaryStats AS (
    SELECT 
        f."EmployeeNumber",
        j."JobRole",
        f."MonthlyIncome",
        f."Attrition",
        AVG(f."MonthlyIncome") OVER (
            PARTITION BY j."JobRole"
        ) AS "RoleAvgIncome"
    FROM fact_employee_attrition f
    JOIN dim_job j 
        ON f.job_id = j.job_id
)
SELECT 
    "EmployeeNumber",
    "JobRole",
    "MonthlyIncome",
    ROUND("RoleAvgIncome", 2) AS "RoleAvgIncome",
    ROUND("MonthlyIncome" - "RoleAvgIncome", 2) AS "IncomeDifference"
FROM RoleSalaryStats
WHERE "Attrition" = 'Yes' 
    AND "MonthlyIncome" < "RoleAvgIncome"
ORDER BY "IncomeDifference" ASC;

-- -----------------------------------------------------------------------------
-- QUERY 5: Attrition Rate by Education Field & Gender
-- Business Question: What is the attrition breakdown across academic background and gender?
-- -----------------------------------------------------------------------------
SELECT 
    d."EducationField",
    d."Gender",
    COUNT(*) AS TotalStaff,
    COUNT(CASE WHEN f."Attrition" = 'Yes' THEN 1 END) AS LeftStaff,
    ROUND(
        COUNT(CASE WHEN f."Attrition" = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 
        2
    ) AS AttritionRatePct
FROM fact_employee_attrition f
JOIN dim_demographics d ON f.demographics_id = d.demographics_id
GROUP BY d."EducationField", d."Gender"
ORDER BY AttritionRatePct DESC;