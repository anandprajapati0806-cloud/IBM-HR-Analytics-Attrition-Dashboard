-- =========================================
-- DATA IMPORT
-- HR Analytics Dashboard
-- =========================================

CREATE TABLE hr_analytics (
Age INT,
Attrition VARCHAR(5),
BusinessTravel VARCHAR(50),
DailyRate INT,
Department VARCHAR(50),
DistanceFromHome INT,
Education INT,
EducationField VARCHAR(50),
EmployeeCount INT,
EmployeeNumber INT,
EnvironmentSatisfaction INT,
Gender VARCHAR(50),
HourlyRate INT,
JobInvolvement INT,
JobLevel INT,
JobRole VARCHAR(50),
JobSatisfaction INT,
MaritalStatus VARCHAR(50),
MonthlyIncome INT,
MonthlyRate INT,
NumCompaniesWorked INT,
Over18 VARCHAR(50),
OverTime VARCHAR(50),
PercentSalaryHike INT,
PerformanceRating INT,
RelationshipSatisfaction INT,
StandardHours INT,
StockOptionLevel INT,
TotalWorkingYears INT,
TrainingTimesLastYear INT,
WorkLifeBalance INT,
YearsAtCompany INT,
YearsInCurrentRole INT,
YearsSinceLastPromotion INT,
YearsWithCurrManager INT
)

SELECT * FROM hr_analytics;
SELECT COUNT(*) AS total_rows FROM hr_analytics;



-- =========================================
-- Data Cleaning 
-- =========================================

-- Checking NULL Values
SELECT
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Null_Age,
	SUM(CASE WHEN Attrition IS NULL THEN 1 ELSE 0 END) AS Null_Atrrition,
	SUM(CASE WHEN MonthlyIncome IS NULL THEN 1 ELSE 0 END) AS Null_MonthlyIncome,
	SUM(CASE WHEN Department IS NULL THEN 1 ELSE 0 END) AS Null_Department,
	SUM(CASE WHEN JobSatisfaction IS NULL THEN 1 ELSE 0 END) AS Null_JobSatisfaction,
	SUM(CASE WHEN WorkLifeBalance IS NULL THEN 1 ELSE 0 END) AS Null_WorkLifeBalance,
	SUM(CASE WHEN OverTime IS NULL THEN 1 ELSE 0 END) AS Null_OverTime
FROM hr_analytics;

SELECT 


-- Checking Duplicates Values
SELECT EmployeeNumber, COUNT(*) AS Duplicate_Count FROM hr_analytics
GROUP BY EmployeeNumber
HAVING COUNT(*) > 1;


-- MIN and MAX age
SELECT
    MAX(Age) AS Max_Age,
	MIN(Age) As Min_Age
FROM hr_analytics;


-- Attrition Distinct Values
SELECT DISTINCT(Attrition) FROM hr_analytics;


-- Department Distinct Values
SELECT DISTINCT(Department) FROM hr_analytics;


--  Dropping Irrelevant Columns
ALTER TABLE hr_analytics
DROP COLUMN EmployeeCount,
DROP COLUMN Over18, 
DROP COLUMN StandardHours;

SELECT * FROM hr_analytics
LIMIT 5;



-- =========================================
-- IBM Overview
-- =========================================

-- Query 1: Total employees
SELECT COUNT(*) AS total_employee FROM hr_analytics;


-- Query 2: Attrition Rate (Standard attrition rate is 10 - 12 healthy)
SELECT 
    COUNT (*) AS total_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
	ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM hr_analytics;


-- Query 3: Employees by Department (Largest department with 65% employees)
SELECT Department,
    COUNT(*) AS total_employees,
	ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM hr_analytics
GROUP BY Department;


-- Query 4: Employees by Gender (60% Male - 40% Female)
SELECT Gender,
    COUNT(*) AS Total_Employees,
	ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM hr_analytics
GROUP BY Gender;


-- Query 5: Employees by JobRole (Sales Executives largest job 22% - Sales | Reseach | Laboratory = 38%)
SELECT JobRole,
    COUNT(*) AS total_employees,
	ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM hr_analytics
GROUP BY JobRole 
ORDER BY total_employees DESC;



-- =========================================
-- Attrition Check 
-- =========================================


-- Query 1: Attrition by Department (Sales Department has highest attrtion 20.67 and HR is near 19.09)
SELECT Department, 
    COUNT(*) AS total_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
	ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.2 / COUNT(*), 2) AS attrition_rate
FROM hr_analytics
GROUP BY Department;


	
-- Query 2: Attrition by Gender (Male attrtion is higher 17%)
SELECT Gender,
    COUNT(*) AS total_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
	ROUND(
	    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2
		) AS percentage
FROM hr_analytics
GROUP BY Gender;



-- Query 3: Attrition by Age Group (18-25 Highest Attrition)
SELECT 
    CASE 
	    WHEN Age BETWEEN 18 AND 25 THEN '18-25'
	    WHEN Age BETWEEN 26 and 35 THEN '26-35'
	    WHEN Age BETWEEN 36 and 45 THEN '36-45'
	    WHEN Age BETWEEN 46 and 55 THEN '46-55'
	    ELSE '55+'
    END AS age_group,
	COUNT(*) AS total_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
	ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM hr_analytics
GROUP BY age_group
ORDER BY attrition_rate DESC;



-- Query 4: Attrition by Income Group (1k-3k highest attrition)
SELECT
    CASE
	    WHEN MonthlyIncome BETWEEN 1000 AND 3000 THEN 'Low (1k-3k)'
		WHEN MonthlyIncome BETWEEN 3001 AND 6000 THEN 'Medium (3k-6k)'
		WHEN MonthlyIncome BETWEEN 6001 AND 10000 THEN 'High (6k-10k)'
		ELSE 'Very High (10k+)'
	END AS Income_Group,
	COUNT(*) AS total_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
	ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS attrition_rate
FROM hr_analytics
GROUP BY Income_Group;



-- Query 5: Attrition by Overtime (Yes - 30 or No - 10.44)
SELECT OverTime,
    COUNT(*) AS total_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) attrition_count,
	ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) attrition_rate
FROM hr_analytics
GROUP BY OverTime;



-- Query 6: Attrition by WorkLifeBalance (31% for 1 'Bad')
SELECT WorkLifeBalance,
	 CASE
	     WHEN WorkLifeBalance = 1 THEN 'Bad'
		 WHEN WorkLifeBalance = 2 THEN 'Good'
		 WHEN WorkLifeBalance = 3 THEN 'Better'
		 When WorkLifeBalance = 4 THEN 'Best'
	END AS work_life_balance,
	COUNT(*) AS total_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_counts,
	ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM hr_analytics
GROUP BY WorkLifeBalance
ORDER BY attrition_rate DESC;



-- Query 7: Attrition by JobSatisfaction (22.84% for 1 'low')
SELECT JobSatisfaction,
    CASE
	    WHEN JobSatisfaction = 1 THEN 'Low'
		WHEN JobSatisfaction = 2 THEN 'Medium'
		WHEN JobSatisfaction = 3 THEN 'High'
		WHEN JobSatisfaction = 4 THEN 'Very High'
	END AS Job_Satisfaction,
	COUNT(*) AS total_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
	ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM hr_analytics
GROUP BY JobSatisfaction;



-- Query 8: Attrition by Years (29% attrition for tenurity between '0-2 years')
SELECT 
    CASE
	    WHEN YearsAtCompany BETWEEN 0 AND 2 THEN '0-2 Years'
		WHEN YearsAtCompany BETWEEN 3 AND 5 THEN '3-5 Years'
		WHEN YearsAtCompany BETWEEN 6 AND 10 THEN '6-10 Years'
		ElSE '10+ Years'
	END AS tenure_group,
	COUNT(*) AS total_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_counts,
	ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM hr_analytics
GROUP BY tenure_group
ORDER BY attrition_rate DESC;



-- =========================================
-- Exploratory Data Analysis (EDA)  
-- Multi-Factor Attrition Analysis
-- Cross-Dimensional Analysis
-- =========================================


--Query 1: Which department loses most? 
-- (Sales 70% attrition - r&d 52% attrition - HR 57% attrition)
-- Low salary + Overtime = employees leave. High salary + No Overtime = employees stay."
SELECT Department,
       OverTime,
	   CASE
	       WHEN MonthlyIncome BETWEEN 1000 AND 3000 THEN 'Low'
		   WHEN MonthlyIncome BETWEEN 3001 AND 6000 THEN 'Medium'
		   ELSE 'High'
	   END AS Income_Brand,
	   COUNT(*) AS total_employees,
	   SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_counts,
	   ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM hr_analytics
GROUP BY Department, OverTime, Income_Brand;



-- Query 2: Which job role loses most people? 
-- Department Sales 39% for Sales Representative Job Role 
-- Department R&D 23% for laboratory technician Job Role
-- Department HR 23% for Human Resource Job Role
SELECT 
    Department,
    JobRole,
	COUNT(*) AS total_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ElSE 0 END) AS people_left,
	ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS arrition_percent
FROM hr_analytics
GROUP BY Department, JobRole;



-- Query 3: Which age group is most at risk? 
-- 18-25 with low salary has extensivly 43% attrition rate
-- 26-35 with low salary also has 28% attrition rata

SELECT
    CASE
	    WHEN Age BETWEEN 18 AND 25 THEN '18-25'
		WHEN Age BETWEEN 26 and 35 THEN '26-35'
	    WHEN Age BETWEEN 36 and 45 THEN '36-45'
		ELSE '45+'
	END AS age_group,
	CASE
	    WHEN MonthlyIncome BETWEEN 1000 AND 3000 THEN 'Low'
		WHEN MonthlyIncome BETWEEN 3001 AND 6000 THEN 'Medium'
		ELSE 'High'
	END AS income_band,
	COUNT(*) AS total_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS people_left,
	ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as attrition_percent
FROM hr_analytics
GROUP BY age_group, income_band
ORDER BY age_group;



-- Query 4: Impact of overtime by department
-- In sales deprt who work overtime despite overtime, earning is less therefore attrition rate is 37%.
-- In HR deprt who work overtime despite overtime, earning is less therefore attrition rate is 29%.
-- in R&D deprt who work overtime despite overtime, earning is less therefore attrition rate is 27%.
SELECT
    Department,
	OverTime,
	COUNT(*) AS total_employees,
	ROUND(AVG(MonthlyIncome), 2) AS average,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS people_left,
	ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_percent
FROM hr_analytics
GROUP BY department, overtime
ORDER BY department;



-- Query 5: Impact of promotions
-- does not getting promoted cause employees to leave? 
-- Recent promoted employees leaves first and arrition_rate 18.93% cuased less salary
-- Employees with 5+ years leave also 16.28%
SELECT
    CASE
	    WHEN YearsSinceLastPromotion = 0 THEN 'Just Promoted'
		WHEN YearsSinceLastPromotion BETWEEN 1 AND 2 THEN '1-2 Years Ago'
		WHEN YearsSinceLastPromotion BETWEEN 3 AND 5 THEN '3-5 Years Ago'
		ELSE '5+ Years Ago'
	END AS promotion_group,
	COUNT(*) AS total_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS people_left,
	ROUND(AVG(MonthlyIncome),2) AS Average_salary,
	ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_percent
FROM hr_analytics
GROUP BY promotion_group;



-- Query 5: Final Complete Risk Profile
-- there's nobody who is aged 18-25, does overtime, AND earns a High income
-- 18-25 age group - overtime yes - income low - attrition rate is 73% 
-- 26-35 age group - overtime yes - income low - attrition rate is 59%
-- 18-25 age group - overtime yes - income medium - attrition is 46%
SELECT
    CASE
	    WHEN Age BETWEEN 18 AND 25 THEN '18-25'
		WHEN Age BETWEEN 26 AND 35 THEN '26-35'
		ELSE '36+'
	END AS age_group,
	OverTime,
	CASE
	    WHEN MonthlyIncome BETWEEN 1000 AND 3000 THEN 'Low'
		WHEN MonthlyIncome BETWEEN 3001 AND 6000 THEN 'Medium'
		ELSE 'High'
	END AS income_band,
	COUNT(*) AS total_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_counts,
	ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM hr_analytics
GROUP BY age_group, overtime, income_band
ORDER BY attrition_rate DESC
LIMIT 5;
		

-- KPI
SELECT
    COUNT(*) AS total_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_counts,
	ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS arrition_rate,
	ROUND(AVG(Age), 0) AS avg_age,
	ROUND(AVG(MonthlyIncome), 0) AS avg_monthly_income,
	ROUND(AVG(YearsAtCompany), 0) AS avg_tenure,
	ROUND(AVG(JobSatisfaction), 0) AS avg_job_satisfaction
FROM hr_analytics;
