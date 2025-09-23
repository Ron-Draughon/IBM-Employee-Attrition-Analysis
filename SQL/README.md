# 💻 SQL Queries for IBM Employee Attrition Analysis

This folder contains the **SQL code** used to prepare and analyze the IBM HR dataset for the Employee Attrition Analysis project.  

The queries were written in **SQL Server** and designed to calculate attrition counts and rates across various employee dimensions such as **age, income, tenure, overtime, job role, and business travel**.  

---

## 📂 File Contents

### `HR_Attrition_Queries.sql`
- **Core query pattern**  
  Each query follows a general structure:  
  - `COUNT(*)` → total employees  
  - `SUM(CASE WHEN Attrition = 'Yes' …)` → employees who left  
  - Attrition rate = `ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2)`  

- **Included examples**  
  To avoid redundancy, representative queries are included that demonstrate:  
  1. **Basic groupings** (e.g., by EducationField, Department, JobRole).  
  2. **Bucketed values** (e.g., Age Groups, Monthly Income Groups).  
  3. **Multi-dimensional groupings** (e.g., Overtime + Department, Overtime + JobRole).  
  4. **Cross-bucket analysis** (e.g., Distance from Home + Daily Rate).  

---

## 📝 Notes
- These queries were used to **generate the measures and datasets** for the Power BI dashboard.  
- The general pattern can be reused by substituting the grouping column.  
- Only clean, production-ready queries are included; exploratory drafts were removed.  

---

👉 Return to the [main project folder](../README.md) for the full report and dashboard.
