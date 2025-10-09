-- ==========================================================
-- HR Employee Attrition Analysis
-- Dataset: IBM HR Analytics (fictional dataset created by IBM)
-- Author: Ron Draughon
-- Note: Attrition = 'Yes' means the employee left the company
-- ==========================================================

---------------------------------------------------------
-- General Template Query
-- This query structure was reused across multiple analyses
---------------------------------------------------------
SELECT DimensionColumn,
       COUNT(*) AS num_employees,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS num_leaving,
       ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_rate
FROM HR_Employees
GROUP BY DimensionColumn
ORDER BY attrition_rate DESC;

-- Example: Replace DimensionColumn with JobRole, Department, BusinessTravel, etc.

---------------------------------------------------------
-- 1. Attrition by Age Groups
-- Highlights very high attrition among employees age 21 and under
---------------------------------------------------------
SELECT CASE 
         WHEN Age BETWEEN 18 AND 21 THEN '18-21'
         WHEN Age BETWEEN 22 AND 30 THEN '22-30'
         WHEN Age BETWEEN 31 AND 40 THEN '31-40'
         WHEN Age BETWEEN 41 AND 50 THEN '41-50'
         WHEN Age BETWEEN 51 AND 60 THEN '51-60'
         ELSE 'Over 60'
       END AS age_group,
       COUNT(*) AS num_employees,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS num_leaving,
       ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_rate
FROM HR_Employees
GROUP BY CASE 
         WHEN Age BETWEEN 18 AND 21 THEN '18-21'
         WHEN Age BETWEEN 22 AND 30 THEN '22-30'
         WHEN Age BETWEEN 31 AND 40 THEN '31-40'
         WHEN Age BETWEEN 41 AND 50 THEN '41-50'
         WHEN Age BETWEEN 51 AND 60 THEN '51-60'
         ELSE 'Over 60'
       END
ORDER BY attrition_rate DESC;

---------------------------------------------------------
-- 2. Attrition by Monthly Income Groups
-- Shows attrition is highest under $2k/month, lowest over $15k
---------------------------------------------------------
SELECT CASE 
         WHEN MonthlyIncome BETWEEN 1000 AND 1999 THEN '$1k–$1.9k'
         WHEN MonthlyIncome BETWEEN 2000 AND 2999 THEN '$2k–$2.9k'
         WHEN MonthlyIncome BETWEEN 3000 AND 5999 THEN '$3k–$5.9k'
         WHEN MonthlyIncome BETWEEN 6000 AND 8999 THEN '$6k–$8.9k'
         WHEN MonthlyIncome BETWEEN 9000 AND 11999 THEN '$9k–$11.9k'
         WHEN MonthlyIncome BETWEEN 12000 AND 14999 THEN '$12k–$14.9k'
         ELSE 'Over $15k'
       END AS income_group,
       COUNT(*) AS num_employees,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS num_leaving,
       ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_rate
FROM HR_Employees
GROUP BY CASE 
         WHEN MonthlyIncome BETWEEN 1000 AND 1999 THEN '$1k–$1.9k'
         WHEN MonthlyIncome BETWEEN 2000 AND 2999 THEN '$2k–$2.9k'
         WHEN MonthlyIncome BETWEEN 3000 AND 5999 THEN '$3k–$5.9k'
         WHEN MonthlyIncome BETWEEN 6000 AND 8999 THEN '$6k–$8.9k'
         WHEN MonthlyIncome BETWEEN 9000 AND 11999 THEN '$9k–$11.9k'
         WHEN MonthlyIncome BETWEEN 12000 AND 14999 THEN '$12k–$14.9k'
         ELSE 'Over $15k'
       END
ORDER BY attrition_rate DESC;

---------------------------------------------------------
-- 3. Attrition by Tenure (Years at Company)
-- Early tenure (0–2 years) shows very high attrition
---------------------------------------------------------
SELECT YearsAtCompany,
       COUNT(*) AS num_employees,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS num_leaving,
       ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_rate
FROM HR_Employees
GROUP BY YearsAtCompany
ORDER BY attrition_rate DESC;

---------------------------------------------------------
-- 4. Attrition by Job Involvement
-- Engagement levels (1–4) correlate strongly with attrition
---------------------------------------------------------
SELECT JobInvolvement,
       COUNT(*) AS num_employees,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS num_leaving,
       ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_rate
FROM HR_Employees
GROUP BY JobInvolvement
ORDER BY attrition_rate DESC;

---------------------------------------------------------
-- 5. Attrition by Overtime and Department
-- Demonstrates combined effects of workload and department
---------------------------------------------------------
SELECT OverTime,
       Department,
       COUNT(*) AS num_employees,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS num_leaving,
       ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_rate
FROM HR_Employees
GROUP BY OverTime, Department
ORDER BY attrition_rate DESC;

---------------------------------------------------------
-- 6. Attrition by Business Travel and Job Role
-- Identifies high-risk combinations (e.g., Sales Reps who travel frequently)
---------------------------------------------------------
SELECT JobRole,
       BusinessTravel,
       COUNT(*) AS num_employees,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS num_leaving,
       ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_rate
FROM HR_Employees
GROUP BY JobRole, BusinessTravel
ORDER BY attrition_rate DESC;

---------------------------------------------------------
-- 7. Cross-Tab Example: Distance from Home × Daily Rate
-- Shows how low pay + long distance increases attrition risk
---------------------------------------------------------
SELECT CASE 
         WHEN DistanceFromHome BETWEEN 1 AND 5 THEN '1-5 miles'
         WHEN DistanceFromHome BETWEEN 6 AND 10 THEN '6-10 miles'
         WHEN DistanceFromHome BETWEEN 11 AND 15 THEN '11-15 miles'
         WHEN DistanceFromHome BETWEEN 16 AND 20 THEN '16-20 miles'
         WHEN DistanceFromHome BETWEEN 21 AND 25 THEN '21-25 miles'
         ELSE 'Over 25 miles'
       END AS distance_group,
       CASE 
         WHEN DailyRate BETWEEN 100 AND 500 THEN '$100–$500'
         WHEN DailyRate BETWEEN 501 AND 1000 THEN '$501–$1000'
         WHEN DailyRate BETWEEN 1001 AND 1500 THEN '$1001–$1500'
         ELSE 'Other'
       END AS daily_rate_group,
       COUNT(*) AS num_employees,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS num_leaving,
       ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_rate
FROM HR_Employees
GROUP BY CASE 
         WHEN DistanceFromHome BETWEEN 1 AND 5 THEN '1-5 miles'
         WHEN DistanceFromHome BETWEEN 6 AND 10 THEN '6-10 miles'
         WHEN DistanceFromHome BETWEEN 11 AND 15 THEN '11-15 miles'
         WHEN DistanceFromHome BETWEEN 16 AND 20 THEN '16-20 miles'
         WHEN DistanceFromHome BETWEEN 21 AND 25 THEN '21-25 miles'
         ELSE 'Over 25 miles'
       END,
       CASE 
         WHEN DailyRate BETWEEN 100 AND 500 THEN '$100–$500'
         WHEN DailyRate BETWEEN 501 AND 1000 THEN '$501–$1000'
         WHEN DailyRate BETWEEN 1001 AND 1500 THEN '$1001–$1500'
         ELSE 'Other'
       END
ORDER BY attrition_rate DESC;

---------------------------------------------------------
-- 8. Calculate the true percentage of overlap between
-- high-risk attrition groups (e.g., overtime, low pay, early tenure, etc.)
---------------------------------------------------------

-- Flag each high-risk attribute for every employee
-- Each column creates a binary flag (1 = in risk group, 0 = not)
WITH HighRiskFlags AS (
    SELECT 
        EmployeeNumber,
        CASE WHEN OverTime = 'Yes' THEN 1 ELSE 0 END AS is_overtime,
        CASE WHEN YearsAtCompany <= 1 THEN 1 ELSE 0 END AS is_early_tenure,
        CASE WHEN MonthlyIncome < 2000 THEN 1 ELSE 0 END AS is_low_income,
        CASE WHEN JobInvolvement = 1 THEN 1 ELSE 0 END AS is_low_involvement,
        CASE WHEN WorkLifeBalance = 1 THEN 1 ELSE 0 END AS is_poor_wlb,
        CASE WHEN JobRole = 'Sales Representative' THEN 1 ELSE 0 END AS is_sales_rep,
        CASE WHEN BusinessTravel = 'Travel_Frequently' THEN 1 ELSE 0 END AS is_frequent_travel
    FROM HR_Employees
),

-- Counts how many high-risk flags each employee has
-- Adds up all 1s for each employee to see how many risk segments they belong to
RiskCounts AS (
    SELECT 
        EmployeeNumber,
        (is_overtime + is_early_tenure + is_low_income + 
         is_low_involvement + is_poor_wlb + is_sales_rep + 
         is_frequent_travel) AS risk_count
    FROM HighRiskFlags
),

-- Aggregates totals across the dataset
-- total_employees = all employees in dataset
-- at_risk_employees = employees with ≥1 high-risk factor
-- overlap_employees = employees in ≥2 risk groups (overlapping)
Totals AS (
    SELECT 
        COUNT(*) AS total_employees,
        SUM(CASE WHEN risk_count >= 1 THEN 1 ELSE 0 END) AS at_risk_employees,
        SUM(CASE WHEN risk_count >= 2 THEN 1 ELSE 0 END) AS overlap_employees
    FROM RiskCounts
)

-- Outputs the overlap percentage
-- overlap_rate_percent = percentage of at-risk employees that are in 2+ risk categories
SELECT 
    total_employees,
    at_risk_employees,
    overlap_employees,
    ROUND(100.0 * overlap_employees / at_risk_employees, 2) AS overlap_rate_percent
FROM Totals;

---------------------------------------------------------
-- 9 Create the Impact Summary View for the table
-- Calculates attrition metrics, applies the **half-gap method**, and estimates avoided leavers and savings.
---------------------------------------------------------

CREATE VIEW Impact_Summary_View AS

WITH CompanyAvg AS (
    -- Overall company attrition rate (dynamic)
    SELECT CAST(AVG(CASE WHEN Attrition = 'Yes' THEN 1.0 ELSE 0 END) AS DECIMAL(6,4)) AS company_attrition
    FROM HR_Employees
)

-- 1) Overtime
SELECT 
    'Overtime' AS Dimension,
    OverTime AS Segment,
    CASE WHEN OverTime = 'Yes' THEN 1 ELSE 2 END AS SegmentOrder,
    COUNT(*) AS headcount,
    CAST(ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*),4) AS DECIMAL(6,4)) AS current_attrition,
    -- Half-gap: midpoint between current and company average (only if current > company average)
    CAST(ROUND(
        CASE WHEN SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) > company_attrition 
             THEN company_attrition + ((SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*)) - company_attrition)/2
             ELSE SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) END
    ,4) AS DECIMAL(6,4)) AS target_attrition,
    -- Avoided leavers from the rate reduction
    CAST(ROUND(
        CASE WHEN SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) > company_attrition 
             THEN COUNT(*) * (
                    (SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*))
                  - (company_attrition + ((SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*)) - company_attrition)/2)
                  )
             ELSE 0 END
    ,0) AS INT) AS avoided_leavers,
    -- Use segment-level average salary (monthly -> annual)
    CAST(ROUND(AVG(MonthlyIncome)*12,2) AS DECIMAL(10,2)) AS avg_annual_salary,
    -- Savings = avoided_leavers * (0.5 * annual salary)
    CAST(ROUND(
        CASE WHEN SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) > company_attrition 
             THEN COUNT(*) * (
                    (SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*))
                  - (company_attrition + ((SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*)) - company_attrition)/2)
                  ) * (AVG(MonthlyIncome)*12*0.5)
             ELSE 0 END
    ,0) AS BIGINT) AS savings
FROM HR_Employees
CROSS JOIN CompanyAvg
GROUP BY OverTime, company_attrition, company_attrition  -- keep company_attrition in GROUP BY
HAVING SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) >= 1.5 * company_attrition

UNION ALL

-- 2) Monthly Income
SELECT 
    'Monthly Income' AS Dimension,
    IncomeGroup AS Segment,
    SegmentOrder,
    COUNT(*) AS headcount,
    CAST(ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*),4) AS DECIMAL(6,4)) AS current_attrition,
    CAST(ROUND(
        CASE WHEN SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) > company_attrition 
             THEN company_attrition + ((SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*)) - company_attrition)/2
             ELSE SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) END
    ,4) AS DECIMAL(6,4)) AS target_attrition,
    CAST(ROUND(
        CASE WHEN SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) > company_attrition 
             THEN COUNT(*) * (
                    (SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*))
                  - (company_attrition + ((SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*)) - company_attrition)/2)
                  )
             ELSE 0 END
    ,0) AS INT) AS avoided_leavers,
    CAST(ROUND(AVG(MonthlyIncome)*12,2) AS DECIMAL(10,2)) AS avg_annual_salary,
    CAST(ROUND(
        CASE WHEN SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) > company_attrition 
             THEN COUNT(*) * (
                    (SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*))
                  - (company_attrition + ((SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*)) - company_attrition)/2)
                  ) * (AVG(MonthlyIncome)*12*0.5)
             ELSE 0 END
    ,0) AS BIGINT) AS savings
FROM (
    -- Define income bands & an order column for display
    SELECT *,
        CASE WHEN MonthlyIncome < 2000 THEN '<$2k'
             WHEN MonthlyIncome BETWEEN 2000 AND 2999 THEN '$2k-$2.9k'
             WHEN MonthlyIncome BETWEEN 3000 AND 5999 THEN '$3k-$5.9k'
             WHEN MonthlyIncome BETWEEN 6000 AND 8999 THEN '$6k-$8.9k'
             WHEN MonthlyIncome BETWEEN 9000 AND 11999 THEN '$9k-$11.9k'
             WHEN MonthlyIncome BETWEEN 12000 AND 14999 THEN '$12k-$14.9k'
             ELSE '>$15k' END AS IncomeGroup,
        CASE WHEN MonthlyIncome < 2000 THEN 1
             WHEN MonthlyIncome BETWEEN 2000 AND 2999 THEN 2
             WHEN MonthlyIncome BETWEEN 3000 AND 5999 THEN 3
             WHEN MonthlyIncome BETWEEN 6000 AND 8999 THEN 4
             WHEN MonthlyIncome BETWEEN 9000 AND 11999 THEN 5
             WHEN MonthlyIncome BETWEEN 12000 AND 14999 THEN 6
             ELSE 7 END AS SegmentOrder
    FROM HR_Employees
) e
CROSS JOIN CompanyAvg
GROUP BY IncomeGroup, SegmentOrder, company_attrition
HAVING SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) >= 1.5 * company_attrition

UNION ALL

-- 3) Tenure
SELECT 
    'Tenure' AS Dimension,
    TenureGroup AS Segment,
    SegmentOrder,
    COUNT(*) AS headcount,
    CAST(ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*),4) AS DECIMAL(6,4)) AS current_attrition,
    CAST(ROUND(
        CASE WHEN SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) > company_attrition
             THEN company_attrition + ((SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*)) - company_attrition)/2
             ELSE SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) END
    ,4) AS DECIMAL(6,4)) AS target_attrition,
    CAST(ROUND(
        CASE WHEN SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) > company_attrition
             THEN COUNT(*) * (
                    (SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*))
                  - (company_attrition + ((SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*)) - company_attrition)/2)
                  )
             ELSE 0 END
    ,0) AS INT) AS avoided_leavers,
    CAST(ROUND(AVG(MonthlyIncome)*12,2) AS DECIMAL(10,2)) AS avg_annual_salary,
    CAST(ROUND(
        CASE WHEN SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) > company_attrition
             THEN COUNT(*) * (
                    (SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*))
                  - (company_attrition + ((SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*)) - company_attrition)/2)
                  ) * (AVG(MonthlyIncome)*12*0.5)
             ELSE 0 END
    ,0) AS BIGINT) AS savings
FROM (
    -- Bucket years at company & set display order
    SELECT *,
        CASE WHEN YearsAtCompany BETWEEN 0 AND 1 THEN '0-1 years'
             WHEN YearsAtCompany BETWEEN 2 AND 5 THEN '2-5 years'
             WHEN YearsAtCompany BETWEEN 6 AND 10 THEN '6-10 years'
             ELSE '10+ years' END AS TenureGroup,
        CASE WHEN YearsAtCompany BETWEEN 0 AND 1 THEN 1
             WHEN YearsAtCompany BETWEEN 2 AND 5 THEN 2
             WHEN YearsAtCompany BETWEEN 6 AND 10 THEN 3
             ELSE 4 END AS SegmentOrder
    FROM HR_Employees
) e
CROSS JOIN CompanyAvg
GROUP BY TenureGroup, SegmentOrder, company_attrition
HAVING SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) >= 1.5 * company_attrition

UNION ALL

-- 4) Job Involvement
SELECT 
    'Job Involvement' AS Dimension,
    CAST(JobInvolvement AS VARCHAR(10)) AS Segment,
    JobInvolvement AS SegmentOrder,
    COUNT(*) AS headcount,
    CAST(ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*),4) AS DECIMAL(6,4)) AS current_attrition,
    CAST(ROUND(
        CASE WHEN SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) > company_attrition
             THEN company_attrition + ((SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*)) - company_attrition)/2
             ELSE SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) END
    ,4) AS DECIMAL(6,4)) AS target_attrition,
    CAST(ROUND(
        CASE WHEN SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) > company_attrition
             THEN COUNT(*) * (
                    (SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*))
                  - (company_attrition + ((SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*)) - company_attrition)/2)
                  )
             ELSE 0 END
    ,0) AS INT) AS avoided_leavers,
    CAST(ROUND(AVG(MonthlyIncome)*12,2) AS DECIMAL(10,2)) AS avg_annual_salary,
    CAST(ROUND(
        CASE WHEN SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) > company_attrition
             THEN COUNT(*) * (
                    (SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*))
                  - (company_attrition + ((SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*)) - company_attrition)/2)
                  ) * (AVG(MonthlyIncome)*12*0.5)
             ELSE 0 END
    ,0) AS BIGINT) AS savings
FROM HR_Employees
CROSS JOIN CompanyAvg
GROUP BY JobInvolvement, company_attrition
HAVING SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) >= 1.5 * company_attrition

UNION ALL

-- 5) Work-Life Balance
SELECT 
    'Work-Life Balance' AS Dimension,
    CAST(WorkLifeBalance AS VARCHAR(10)) AS Segment,
    WorkLifeBalance AS SegmentOrder,
    COUNT(*) AS headcount,
    CAST(ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*),4) AS DECIMAL(6,4)) AS current_attrition,
    CAST(ROUND(
        CASE WHEN SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) > company_attrition
             THEN company_attrition + ((SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*)) - company_attrition)/2
             ELSE SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) END
    ,4) AS DECIMAL(6,4)) AS target_attrition,
    CAST(ROUND(
        CASE WHEN SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) > company_attrition
             THEN COUNT(*) * (
                    (SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*))
                  - (company_attrition + ((SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*)) - company_attrition)/2)
                  )
             ELSE 0 END
    ,0) AS INT) AS avoided_leavers,
    CAST(ROUND(AVG(MonthlyIncome)*12,2) AS DECIMAL(10,2)) AS avg_annual_salary,
    CAST(ROUND(
        CASE WHEN SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) > company_attrition
             THEN COUNT(*) * (
                    (SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*))
                  - (company_attrition + ((SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*)) - company_attrition)/2)
                  ) * (AVG(MonthlyIncome)*12*0.5)
             ELSE 0 END
    ,0) AS BIGINT) AS savings
FROM HR_Employees
CROSS JOIN CompanyAvg
GROUP BY WorkLifeBalance, company_attrition
HAVING SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) >= 1.5 * company_attrition

UNION ALL

-- 6) Job Role
SELECT 
    'Job Role' AS Dimension,
    JobRole AS Segment,
    DENSE_RANK() OVER (ORDER BY JobRole) AS SegmentOrder,
    COUNT(*) AS headcount,
    CAST(ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*),4) AS DECIMAL(6,4)) AS current_attrition,
    CAST(ROUND(
        CASE WHEN SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) > company_attrition
             THEN company_attrition + ((SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*)) - company_attrition)/2
             ELSE SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) END
    ,4) AS DECIMAL(6,4)) AS target_attrition,
    CAST(ROUND(
        CASE WHEN SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) > company_attrition
             THEN COUNT(*) * (
                    (SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*))
                  - (company_attrition + ((SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*)) - company_attrition)/2)
                  )
             ELSE 0 END
    ,0) AS INT) AS avoided_leavers,
    CAST(ROUND(AVG(MonthlyIncome)*12,2) AS DECIMAL(10,2)) AS avg_annual_salary,
    CAST(ROUND(
        CASE WHEN SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) > company_attrition
             THEN COUNT(*) * (
                    (SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*))
                  - (company_attrition + ((SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*)) - company_attrition)/2)
                  ) * (AVG(MonthlyIncome)*12*0.5)
             ELSE 0 END
    ,0) AS BIGINT) AS savings
FROM HR_Employees
CROSS JOIN CompanyAvg
GROUP BY JobRole, company_attrition
HAVING SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) >= 1.5 * company_attrition

UNION ALL

-- 7) Business Travel
SELECT 
    'Business Travel' AS Dimension,
    BusinessTravel AS Segment,
    DENSE_RANK() OVER (ORDER BY BusinessTravel) AS SegmentOrder,
    COUNT(*) AS headcount,
    CAST(ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*),4) AS DECIMAL(6,4)) AS current_attrition,
    CAST(ROUND(
        CASE WHEN SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) > company_attrition
             THEN company_attrition + ((SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*)) - company_attrition)/2
             ELSE SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) END
    ,4) AS DECIMAL(6,4)) AS target_attrition,
    CAST(ROUND(
        CASE WHEN SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) > company_attrition
             THEN COUNT(*) * (
                    (SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*))
                  - (company_attrition + ((SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*)) - company_attrition)/2)
                  )
             ELSE 0 END
    ,0) AS INT) AS avoided_leavers,
    CAST(ROUND(AVG(MonthlyIncome)*12,2) AS DECIMAL(10,2)) AS avg_annual_salary,
    CAST(ROUND(
        CASE WHEN SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) > company_attrition
             THEN COUNT(*) * (
                    (SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*))
                  - (company_attrition + ((SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*)) - company_attrition)/2)
                  ) * (AVG(MonthlyIncome)*12*0.5)
             ELSE 0 END
    ,0) AS BIGINT) AS savings
FROM HR_Employees
CROSS JOIN CompanyAvg
GROUP BY BusinessTravel, company_attrition
HAVING SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*) >= 1.5 * company_attrition;
