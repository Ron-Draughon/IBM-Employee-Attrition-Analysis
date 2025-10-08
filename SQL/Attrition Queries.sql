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
